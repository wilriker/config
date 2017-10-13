# Per-Host settings
set -l host (hostname)
set -l host_specific_file ~/.config/fish/hosts/$host.fish
if test -f $host_specific_file
    source $host_specific_file
else
    echo Creating host specific config file: $host_specific_file
    mkdir -p (dirname $host_specific_file)
    touch $host_specific_file
end

# Make PATH distinct
vardistinct PATH

