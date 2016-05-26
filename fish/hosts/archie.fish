if status --is-login
	set -gx BROWSER "google-chrome-stable"
	set -gx JAVA_HOME /usr/lib/jvm/default
	set -gx M2_HOME /opt/maven
	set -gx GRADLE_HOME /usr/share/java/gradle
end
