# Defined in /tmp/fish.miFxJ4/lhz.fish @ line 2
function lhz --description 'List contents of compressed archives'
	for a in $argv
        switch $a
            case "*.tar*" "*.tgz"
                tar -tf $a
            case "*.zip"
                unzip -l $a
            case "*.deb"
                ar -t $a
        end
    end
end
