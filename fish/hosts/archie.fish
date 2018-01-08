if status is-login
    set -gx JAVA_HOME /usr/lib/jvm/default
    set -gx M2_HOME /opt/maven
    set -gx GRADLE_HOME /usr/share/java/gradle
    set -gx SANE_CONFIG_DIR $HOME/.config/sane.d
    set -gx CLOJURE_HOME /usr/share/clojure
    set -gx GOPATH $HOME/workspace/go
end
