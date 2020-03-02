function unarchive --description 'Extract with whatever it takes'
    for archive in $argv
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
                if tar --xz --help >&- 2>&- # ancient tar versions might not support it
                    tar -xf $archive
                else
                    xzcat $archive | tar -xf -
                end
            case "*.tar.zst" "*.tzst"
                tar -I zstd -xf $archive
            case "*.tar" "*.tar.*" # any other (un)compressed tar file
                tar -xf $archive
            case "*.gz"
                gunzip $archive
            case "*.bz2"
                bunzip2 $archive
            case "*.zst"
                unzstd $archive
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
            case "*.zip" "*.jar" "*.war" "*.jmod"
                unzip $archive
            case "*.crx"
                if not unzip $archive
                    set -l inner_zip_offset (fgrep --byte-offset --only-matching --text PK\x03\x04 $archive | head -1 | cut -d: -f1)
                    set -l inner_zip (mktemp --suffix=".zip")
                    dd if=$archive of=$inner_zip skip=$inner_zip_offset iflag=skip_bytes >&- 2>&-
                    unzip $inner_zip
                end
            case "*.7z"
                7za x $archive
            case "*.deb"
                ar x $archive
            case '*'
                echo "unknown extension"
        end
    end
end
