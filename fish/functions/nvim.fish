function nvim --wraps nvim
    tput smkx
    command nvim $argv
end
