function ls --description 'List contents of directory'
    set -l param
    if isatty 1
        set param --color=always --classify
    end
    if command -sq exa
        command exa $param $argv
    else if command -sq grc
        grc -es --colour=auto ls $param $argv
    else
        command ls $param $argv
    end
end
