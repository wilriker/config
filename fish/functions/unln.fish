function unln --description 'Replace symlinks by the actual destination'
	for file in $argv
        if test -L $file; and not test -d (readlink -f $file)
            sed -i '' $file
        else
            echo "$file not a symlink or pointing to a directory" >&2
        end
    end
end
