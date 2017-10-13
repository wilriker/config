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

if status is-interactive; and type -p -q yum
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l __packages (yum whatprovides "*bin/$argv[1]" | egrep "(\.i386|\.x86_64|\.noarch|\.src)" | sort -u)
        if count $__packages >/dev/null
            printf "%s may be found in the following packages:\n" "$argv[1]"
            printf "  %s\n" $__packages
        else
            __fish_default_command_not_found_handler $argv[1]
        end
    end
end

# Make PATH distinct
vardistinct PATH

