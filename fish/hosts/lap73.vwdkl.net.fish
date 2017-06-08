# Init environment on login
# As we do not have login on this machine we do it just everytime
#if status is-login

    # $PROG_HOME dirs
    set -gx JAVA_HOME $HOME/opt/jdk1.8
    set -gx GRADLE_HOME $HOME/opt/gradle
    set -gx M2_HOME $HOME/opt/maven
    set -gx WORKON_HOME ~/.virtualenvs
    set -gx NODE_HOME $HOME/opt/node
    set -gx GOROOT $HOME/opt/go
    set -gx GOPATH $HOME/workspace/go

    set -gx SHELL (command -s fish)
#end

function ssh -d "Set another TERM value"
    set -lx TERM xterm-256color
    command ssh $argv
end
