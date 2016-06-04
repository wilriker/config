function vimw
	if exists --on-disk-only $argv >&- ^&-
        vim (which $argv)
    else if functions -q $argv
        funced $argv
    else
        echo "No file or function named $argv found"
        return 1
    end
end
