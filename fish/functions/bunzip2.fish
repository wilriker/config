function bunzip2
    command -sq pbunzip2
    and pbunzip2 $argv
    or begin
        echo "Install pbzip2"
        command bunzip2 $argv
    end
end
