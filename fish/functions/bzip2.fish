function bzip2
	exists pbzip2
    and pbzip2 $argv
    or command bzip2 $argv
end
