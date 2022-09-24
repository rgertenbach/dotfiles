import os
import unittest
import tempfile

import synclib

class TestSyncLib(unittest.TestCase):
  def test_remove_leading_slash(self):
    self.assertEqual('a/b/c/', synclib.remove_leading_slash('/a/b/c/'))

    self.assertEqual('a/b/c/', synclib.remove_leading_slash('a/b/c/'))

  def test_load_files_to_sync(self):
    expected = ['line1', 'line 2', 'line3', 'line4']
    actual = synclib.load_files_to_sync('test_allowlist.txt')
    self.assertEqual(expected, list(actual))

  def test_replace_tilde(self):
    self.assertEqual('/h/r/.bashrc', 
                     synclib.replace_tilde('~/.bashrc', '/h/r'))

    self.assertEqual('/h/r/.bashrc', 
                     synclib.replace_tilde('/h/r/.bashrc', '/h/r'))
    # It's not this function's responsibility to check if the path makes sense.
    self.assertEqual('/h/~/.bashrc', 
                     synclib.replace_tilde('/h/~/.bashrc', '/h/r'))

  def test_copy_file_throws_if_source_not_found(self):
    with self.assertRaises(FileNotFoundError):
      synclib.copy_file('a', 'b')

  def test_copy_file_copies_file(self):
    with tempfile.NamedTemporaryFile() as source:
      with tempfile.TemporaryDirectory() as dest_dir:
        with open(source.name, 'a') as f:
          f.write('a\nb')

        dest = os.path.join(dest_dir, 'dest')
        synclib.copy_file(dest, source.name)

        with open(dest) as f:
          self.assertEqual(['a\n', 'b'], f.readlines())

  def test_copy_file_handles_older_file_with_handler(self):
    yes_handler = lambda dest, src: True
    with tempfile.NamedTemporaryFile() as old_dest:
      with tempfile.NamedTemporaryFile() as source:
        with open(source.name, 'w') as f:
          f.writelines('a\nb')
        synclib.copy_file(old_dest.name, source.name, False, yes_handler)
        with open(old_dest.name) as f:
          self.assertEqual('a\nb', f.read())

  def test_copy_file_handles_newer_file_with_yes_handler(self):
    yes_handler = lambda dest, src: True
    with tempfile.NamedTemporaryFile() as source:
      with open(source.name, 'w') as f:
        f.writelines('a\nb')
      with tempfile.NamedTemporaryFile() as new_dest:
        synclib.copy_file(new_dest.name, source.name, False, yes_handler)
        with open(new_dest.name) as f:
          self.assertEqual('a\nb', f.read())
      
  def test_copy_file_handles_newer_file_with_no_handler(self):
    no_handler = lambda dest, src: False
    with tempfile.NamedTemporaryFile() as source:
      with open(source.name, 'w') as f:
        f.writelines('a\nb')
      with tempfile.NamedTemporaryFile() as new_dest:
        synclib.copy_file(new_dest.name, source.name, False, no_handler)
        with open(new_dest.name) as f:
          self.assertEqual('', f.read())

  def test_copy_file_handles_missing_dest(self):
    no_handler = lambda dest, src: False
    with tempfile.NamedTemporaryFile() as source:
      with open(source.name, 'w') as f:
        f.writelines('a\nb')
      new_dest = tempfile.NamedTemporaryFile()
      synclib.copy_file(new_dest.name, source.name, False, no_handler)
      with open(new_dest.name) as f:
        self.assertEqual('', f.read())
      

if __name__ == '__main__':
  unittest.main()
