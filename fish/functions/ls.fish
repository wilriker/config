function ls --description 'List contents of directory'
    set -l param
    if isatty 1
        set param --color --classify
    end
    if command -sq grc
        grc -es --colour=auto ls $param $argv
    else
        command ls $param $argv
    end
end
