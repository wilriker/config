function unarchive --description 'Extract with whatever it takes' --argument archive
	switch $archive
        case "*.tgz" "*.tar.gz" # tar compressed with gzip
            type -q pigz
            and tar -I pigz -xf $archive
            or tar -xf $archive
        case "*.tar.bz2" "*.tbz" "*.tbz2" # tar compressed with bzip2
            type -q pbzip2
            and tar -I pbzip2 -xf $archive
            or tar -xf $archive
        case "*.tar.xz" "*.txz" # tar compressed with xz
            if tar --xz --help >&- ^&- # ancient tar versions might not support it
                tar -xf $archive
            else
                xzcat $archive | tar -xf -
            end
        case "*.tar" "*.tar.*" # any other (un)compressed tar file
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
            type -q unrar
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
