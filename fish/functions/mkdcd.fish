function mkdcd --description 'Create a directory and change into it'
    command mkdir -p $argv[1]
    and cd $argv[1]
end
