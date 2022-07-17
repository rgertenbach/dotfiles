# Utility functions to sync the files between git repo and local machine.

import os
import shutil

from typing import Generator

def load_files_to_sync(allowlist_filepath: str) -> Generator[str, None, None]:
  """Gets the files to sync from the file that contains the allowlist.

  Args:
    allowlist_filepath: A filepath to the allowlist containing files to copy

  Yields:
    string filepaths of the files to copy.
  """
  with open(allowlist_filepath) as f:
    yield from (filepath.strip() for filepath in f.readlines())


def remove_leading_slash(filepath: str) -> str:
  """Removes leading slashes to make directories relative to Root.

  The source directory of the repo is assumed to be the PWD and simulates
  ROOT.

  Args:
    filepath: The Absolute filepath of the file to copy.
  """
  return filepath.lstrip('/')

