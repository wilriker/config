function rmthis --description 'Remove the current directory with all its contents'
	set -l DIR (pwd)
	cd ..
	command rm -rf -- $DIR
end
