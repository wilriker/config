# Init environment

# $PROG_HOME dirs
set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -gx GRADLE_HOME /usr/share/gradle
set -gx M2_HOME /usr/share/maven

set -gx FILE_MANAGER nautilus
set -gx SHELL (command -s fish)

if not functions -q ssh
    function ssh -d "Set another TERM value"
        set -lx TERM xterm-256color
        command ssh $argv
    end
end
