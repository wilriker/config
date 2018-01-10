# Environment variables
set -gx LANG en_DK.UTF-8
set -gx LC_COLLATE C
set -gx EDITOR nvim
set -gx DIFFPROG "$EDITOR -d"
set -gx VISUAL $EDITOR
set -gx PAGER less
set -gx BROWSER google-chrome-stable
set -gx XKB_DEFAULT_LAYOUT gb
