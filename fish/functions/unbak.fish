# Defined in /tmp/fish.Q7Q2gq/unbak.fish @ line 1
function unbak
	set -l file (string replace --regex -- '/$' '' $argv[1])
    if not test -e $file
        exit 1
    end
    mv $file (string sub --length (math (string length $file)" - 4") $file)
end
