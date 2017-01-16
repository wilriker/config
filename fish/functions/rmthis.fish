function rmthis --description 'Remove the current directory with all its contents'
	set -l DIR (pwd)
    if string match -q -- $HOME $DIR
        echo "Do NOT try to delete \$HOME!" >&2
        return 1
    end
    cd ..
    command rm -rf -- $DIR
end
