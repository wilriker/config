function unarchive --description 'Extract with whatever it takes' --argument archive
	switch $archive
        case "*.tgz" "*.tar.gz" # tar compressed with gzip
            exists pigz
            and tar -I pigz -xf $archive
            or tar -xzf $archive
        case "*.tar.bz2" "*.tbz" "*.tbz2" # tar compressed with bzip2
            exists pbzip2
            and tar -I pbzip2 -xf $archive
            or tar -xjf $archive
        case "*.tar.xz" "*.txz" # tar compressed with xz
            if tar --xz --help >&- ^&-
                tar --xz -xf $archive
            else
                xzcat $archive | tar -xf -
            end
        case "*.tar" # non-compressed, just bundled
            tar -xf $archive
        case "*.gz"
            gunzip $archive
        case "*.bz2"
            bunzip2 $archive
        case "*.xz"
            unxz $archive
        case "*.lzma"
            unlzma $archive
        case "*.Z"
            uncompress $archive
        case "*.rar"
            exists unrar
            and unrar x $archive
            or rar x -ad $archive
        case "*.zip" "*.jar" "*.war"
            unzip $archive
        case "*.7z"
            7za x $archive
        case '*'
            echo "unknown extension"
    end
end
