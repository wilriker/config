# Defined in /tmp/fish.6RkQ5J/lhz.fish @ line 2
function lhz --description 'List contents of compressed archives'
    for a in $argv
        switch $a
            case "*.tar*" "*.tgz" "*.tbz2" "*.tzst"
                tar -tvf $a
            case "*.zip"
                unzip -l $a
            case "*.deb"
                ar -t $a
        end
    end
end
