function gunzip
    command -sq unpigz
    and unpigz $argv
    or begin
        echo "Install pigz"
        command gunzip $argv
    end
end
