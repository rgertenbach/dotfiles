# dotfiles

`sync` is a tool to consume an allowlist of dotfiles and sync them between the
actual location and a mirror in the repo. \
This is bidirectional and detects if upstream dotfiles are more recent and
allows to compare diffs before confirming overwriting. 
It does *not* detect a recently modified but initially lagging local file, it's
not that good.

Maybe I should add such a checker.

