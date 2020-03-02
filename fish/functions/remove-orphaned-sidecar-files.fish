# Defined in /tmp/fish.KgfyiV/remove-orphaned-sidecar-files.fish @ line 2
function remove-orphaned-sidecar-files --description 'Remove sidecar files that have no original image present recursively from the current directory' --argument extension print
    if test -z $extension
        echo "Usage: remove-orphaned-sidecar-files <sidecar-extension> [--print-only]"
        return 1
    end

    for sidecar in **.$extension
        if not test -f (string replace ".$extension" "" $sidecar)
            echo -n "Found orphaned $sidecar"

            # If no print-only is given delete the file
            if test -z $print
                rm $sidecar
                echo " - deleted"
            else
                # Finish print line
                echo
            end
        end
    end
end
