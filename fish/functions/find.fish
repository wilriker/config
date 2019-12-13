function find
    command -sq fd
    and fd $argv
    or begin
        echo "Install fd"
        command find $argv
    end
end
