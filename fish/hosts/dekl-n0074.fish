# Init environment

# $PROG_HOME dirs

# Old SSH remote servers...
if not functions -q ssh
    function ssh -d "Set another TERM value"
        set -lx TERM xterm-256color
        command ssh $argv
    end
end
