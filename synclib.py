# Utility functions to sync the files between git repo and local machine.

import dataclasses
import datetime
import os
import shutil
import subprocess

from typing import Callable, Generator, Iterable

Handler = Callable[[str, str], bool]


def load_files_to_sync(allowlist_filepath: str) -> Generator[str, None, None]:
  'Loads the files to sync from the allowlist.'
  with open(allowlist_filepath) as f:
    for filepath in f.readlines():
      if stripped := filepath.strip():
        yield stripped


def remove_leading_slash(filepath: str) -> str:
  """Removes leading slashes to make directories relative to Root.

  The root directory simulates / and is assumed to be PWD.
  """
  return filepath.lstrip('/')


def replace_tilde(filepath: str, homedir: str) -> str:
  "Replaces a leading tilde with the homedir if it exists."
  if filepath.startswith('~'):
    return filepath.replace('~', homedir, 1)
  return filepath


def convert_to_local_path(filepath: str, homedir: str) -> str:
  return replace_tilde(filepath, homedir)


def convert_to_repo_path(filepath: str, homedir: str) -> str:
  return remove_leading_slash(replace_tilde(filepath, homedir))


def copy_file(dest: str, 
              source: str, 
              overwrite_newer: bool = False, 
              handler: Handler | None = None) -> None:
  """Moves a file from the source to the destination.

  Args:
    dest: The filepath of the destination to copy to.
    source: The source filepath.
    overwrite_newer: Whether to automatically overwrite newer files.
    handler: A function that determines whether to overwrite the file or not if
        the destination is newer.
        This function might ask the user if it's ok to overwrite
        and return that output.
        This has no effect if overwrite_newer is True.
        None is equivalent to a function returning False

  Raises:
    FileNotFoundError: If the source file does not exist.
  """
  if not os.path.exists(source):
    raise FileNotFoundError('source filepath %s not found.' % source)

  os.makedirs(os.path.dirname(dest), exist_ok=True)
  dest_exists = os.path.exists(dest)
  is_newer = dest_exists and os.path.getmtime(source) > os.path.getmtime(dest)
  is_different = dest_exists and bool(diff(dest, source))
  
  permission_to_overwrite = (
    not dest_exists
    or is_newer
    or not is_different
    or (handler is not None and handler(dest, source)))
    
  if overwrite_newer or permission_to_overwrite:
    shutil.copyfile(source, dest, follow_symlinks=False)


def formatted_mtime(filepath: str, fmt: str = '%F %T') -> str:
  return (
      datetime.datetime.fromtimestamp(os.path.getmtime(filepath))
      .strftime(fmt))


def diff(dest: str, src: str) -> bytes:
  'Runs diff on two files'
  d = subprocess.run(['diff', dest, src], capture_output=True)
  return d.stdout

def page(text: bytes) -> None:
  'Opens a text in less'
  pager = os.getenv('PAGER') or 'less'
  subprocess.run([pager], input=text)


def ask_handler(dest: str, src: str) -> bool:
  direct_answers = {'yes', 'y', 'no', 'n'}
  acceptable_answers = direct_answers | {'diff', 'd'}
  describe = lambda fp: f'{fp} ({formatted_mtime(fp)})'
  warning = f'{describe(dest)} is newer than {describe(src)} and different'
  query = f'{warning}, overwrite ((Y)es/(N)o/(D)iff)? '

  def input_loop() -> str:
    while (answer := input(query)).lower() not in acceptable_answers:
      continue
    return answer

  while (answer := input_loop()) not in direct_answers:
    if answer in {'d', 'diff'}:
      page(diff(dest, src))
    continue

  return answer == 'yes'


@dataclasses.dataclass
class Syncer:
  local_homedir: str
  repo_homedir: str
  overwrite_newer: bool = False
  handler: Handler | None = None
  verbose: bool = False
  dry_run: bool = True

  def __post_init__(self):
    if self.dry_run:
      print('In dry run mode!')

  def convert_to_local_path(self, filename: str) -> str:
    return convert_to_local_path(filename, self.local_homedir)

  def convert_to_repo_path(self, filename: str) -> str:
    return convert_to_repo_path(filename, self.repo_homedir)

  def copy_file(self, dest: str, src: str) -> None:
    if self.verbose:
      print('{}oving {} to {}.'.format('Pretend m' if self.dry_run else 'M', 
                                       src,
                                       dest))
    if not self.dry_run:
      copy_file(dest, src, self.overwrite_newer, self.handler)

  def pull_file(self, filepath: str) -> None:
    self.copy_file(self.convert_to_local_path(filepath), 
                   self.convert_to_repo_path(filepath))

  def push_file(self, filepath: str) -> None:
    self.copy_file(self.convert_to_repo_path(filepath), 
                   self.convert_to_local_path(filepath))

  def pull_files(self, filepaths: Iterable[str]) -> None:
    for filepath in filepaths:
      self.pull_file(filepath)

  def push_files(self, filepaths: Iterable[str]) -> None:
    for filepath in filepaths:
      self.push_file(filepath)

