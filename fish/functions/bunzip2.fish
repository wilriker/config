function bunzip2
	exists pbunzip2
    and pbunzip2 $argv
    or command bunzip2 $argv
end
