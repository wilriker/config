#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
	char *p;
	pid_t pid = strtol(argv[1], &p, 10);
	pid_t pgid = getpgid(pid);
	printf("%d\n", pgid);
	return 0;
}
