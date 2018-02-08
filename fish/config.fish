### Note: All scripts from conf.d dir have already been sourced at this point

# Per-Host settings
set -l host (hostname)
set -l host_specific_file ~/.config/fish/hosts/$host.fish
if test -f $host_specific_file
    source $host_specific_file
else
    echo "Creating host specific config file: $host_specific_file"
    mkdir -p (dirname $host_specific_file)
    touch $host_specific_file
end

# Make PATH distinct
vardistinct PATH

# Every after here is only relevant for interactive shells
status is-interactive; or exit

# startx
if test -z "$SSH_CONNECTION"; and not command env DISPLAY=:0 xset -q >/dev/null ^&1
    sleep 1
    startx
    # exit
end

# tmux
# test (whoami) = "root"; and exit
# test -z "$TMUX"; or exit
# tmx
