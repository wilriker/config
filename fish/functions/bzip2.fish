function bzip2
    command -sq pbzip2; and pbzip2 $argv
    or begin
        echo "Install pbzip2"
        command bzip2 $argv
    end
end
