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

# As last part of initialization, source the autostart directory.
set -l configdir ~/.config
for file in $configdir/fish/autostart/*.fish
    # Skip non-files or unreadable files.
    # This allows one to use e.g. symlinks to /dev/null to "mask" something (like in systemd).
    test -f $file -a -r $file
    and source $file
end
