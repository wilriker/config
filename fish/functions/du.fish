function du
    command -sq cdu; and cdu -idhx $argv
    or begin
        echo "Install cdu"
        command du $argv
    end
end
