function rmthis --description 'Remove the current directory with all its contents'
    set -l DIR (pwd)
    if string match -riq -- '^'$HOME'(/(Downloads|Dropbox|tmp)?)?$' $DIR
        echo "Do NOT try to delete important directories!" >&2
        return 1
    end
    cd ..
    command rm -rf -- $DIR
end
