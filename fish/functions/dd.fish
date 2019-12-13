function dd
    command -sq dcfldd
    and dcfldd $argv
    or begin
        echo "Install dcfldd"
        command dd $argv
    end
end
