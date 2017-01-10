# Nothing to do if grc is not installed at all
if not type -q nvim
    exit
end

for executable in edit ex rview rvim vedit vi view vim
    function $executable --wraps=$executable
        nvim $argv
    end
end

function vimdiff --wraps=vimdiff
    nvim -d $argv
end
