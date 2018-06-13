# Environment variables
set -gx LANG en_GB.UTF-8
set -gx LC_COLLATE C
set -gx EDITOR nvim
set -gx DIFFPROG "$EDITOR -d"
set -gx VISUAL $EDITOR
set -gx PAGER less
set -gx BROWSER vivaldi-stable
set -gx FILE_MANAGER nemo
set -gx XKB_DEFAULT_LAYOUT gb
set -gx GOPATH $HOME/workspace/go
