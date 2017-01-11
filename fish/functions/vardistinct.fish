function vardistinct --description 'Remove duplicates from variables'
    if test (count $argv) = 1
        set -l newvar
        for v in $$argv
            if not contains -- $v $newvar
                set newvar $newvar $v
            end
        end
        set $argv $newvar
    else
        for a in $argv
            vardistinct $a
        end
    end
end
