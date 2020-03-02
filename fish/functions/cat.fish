function cat
    command -sq bat; and bat --paging=never $argv
    or begin
        echo "Install bat"
        command cat $argv
    end
end
