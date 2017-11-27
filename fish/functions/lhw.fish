# Defined in /tmp/fish.hQdxYz/lhw.fish @ line 2
function lhw
	type -pq $argv
    and lh (command -s $argv)
    or return 1
end
