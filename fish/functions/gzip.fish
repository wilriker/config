function gzip
    command -sq pigz
    and pigz $argv
    or begin
        echo "Install pigz"
        command gzip $argv
    end
end
