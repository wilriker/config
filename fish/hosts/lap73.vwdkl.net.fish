# Init environment

# $PROG_HOME dirs
set -gx JAVA_HOME $HOME/opt/jdk8
set -gx GRADLE_HOME $HOME/opt/gradle
set -gx M2_HOME $HOME/opt/maven
set -gx NODE_HOME $HOME/opt/node
set -gx GOROOT $HOME/opt/go

set -gx FILE_MANAGER nautilus
set -gx SHELL (command -s fish)

if not functions -q ssh
    function ssh -d "Set another TERM value"
        set -lx TERM xterm-256color
        command ssh $argv
    end
end
