function cat
    command -sq bat
    and bat $argv
    or begin
        echo "Install bat"
        command cat $argv
    end
end
