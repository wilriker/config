function rm --wraps=rm
    command rm -I --one-file-system $argv
end
