function nvimw
    if command -sq $argv
        vim (which $argv)
    else if functions -q $argv
        funced $argv
    else
        echo "No executable or function named $argv found"
        return 1
    end
end
