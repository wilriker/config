status is-interactive; or exit
type -q __fish_command_not_found_handler; and exit

if type -p -q yum
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l __packages (yum whatprovides -q "*bin/$argv[1]" | egrep "(\.i386|\.x86_64|\.noarch|\.src)" | sort -u)
        if count $__packages >/dev/null
            printf "%s may be found in the following packages:\n" "$argv[1]"
            printf "  %s\n" $__packages
        else
            __fish_default_command_not_found_handler $argv[1]
        end
    end
end
