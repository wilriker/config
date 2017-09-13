# Defined in /tmp/fish.CCweVo/du.fish @ line 2
function du
	type -q cdu
    and cdu -idhx $argv
    or command du $argv
end
