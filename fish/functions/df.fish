function df
    command -sq dfc
    and dfc -d $argv
    or begin
        echo "Install dfc"
        command df $argv
    end
end
