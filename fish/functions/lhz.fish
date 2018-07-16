# Defined in /tmp/fish.CtGu2j/lhz.fish @ line 1
function lhz --description 'List contents of compressed archives'
	for a in $argv
        switch $a
            case "*.tar*"
                tar -tf $a
            case "*.zip"
                unzip -l $a
        end
    end
end
