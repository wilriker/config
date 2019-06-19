# Defined in /tmp/fish.GlVDIT/lhz.fish @ line 2
function lhz --description 'List contents of compressed archives'
	for a in $argv
        switch $a
            case "*.tar*" "*.tgz"
                tar -tvf $a
            case "*.zip"
                unzip -l $a
            case "*.deb"
                ar -t $a
        end
    end
end
