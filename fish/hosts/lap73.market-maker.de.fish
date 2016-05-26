# Init environment on login
if status --is-login

	# $PROG_HOME dirs
	set -gx JAVA_HOME /usr/java/default
	set -gx GRADLE_HOME /export/home/mcoenen/opt/gradle
	set -gx M2_HOME /export/home/mcoenen/opt/maven
	set -gx WORKON_HOME ~/.virtualenvs
	set -gx SPRING_HOME /export/home/mcoenen/opt/spring
end

