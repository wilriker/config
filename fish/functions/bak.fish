# Defined in /tmp/fish.Ia6XdV/bak.fish @ line 2
function bak
	set -l file (string replace --regex -- '/$' '' $argv[1])
	mv $file $file.bak
end
