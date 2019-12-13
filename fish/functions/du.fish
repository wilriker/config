# Defined in /tmp/fish.CCweVo/du.fish @ line 2
function du
    command -sq cdu
    and cdu -idhx $argv
    or begin
        echo "Install cdu"
        command du $argv
    end
end
