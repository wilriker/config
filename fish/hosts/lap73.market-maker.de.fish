# Init environment on login
# As we do not have login on this machine we do it just everytime
#if status --is-login

    # $PROG_HOME dirs
    set -gx JAVA_HOME /export/home/mcoenen/opt/jdk1.8
    set -gx GRADLE_HOME /export/home/mcoenen/opt/gradle
    set -gx M2_HOME /export/home/mcoenen/opt/maven
    set -gx WORKON_HOME ~/.virtualenvs
    set -gx SPRING_HOME /export/home/mcoenen/opt/spring

    set -gx SHELL (command -s fish)
#end

function ssh -d "Set another TERM value"
    set -lx TERM xterm-256color
    command ssh $argv
end
