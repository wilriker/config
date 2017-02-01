if status --is-login

    # Environment variables
    set -gx LANG en_DK.UTF-8
    set -gx LC_COLLATE C
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx PAGER less
    set -gx BROWSER google-chrome-stable
    set -gx XKB_DEFAULT_LAYOUT de
    set -gx XKB_DEFAULT_VARIANT nodeadkeys
end
