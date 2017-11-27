# Defined in /tmp/fish.akshdG/mkdcd.fish @ line 2
function mkdcd --description 'Create a directory and change into it'
	mkdir $argv[1]
    and cd $argv[1]
end
