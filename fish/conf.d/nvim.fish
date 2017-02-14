# Nothing to do if nvim is not installed at all
if not type -q nvim
    exit
end

alias vim nvim

alias ex 'nvim -e'
alias exim 'nvim -E'

alias view 'nvim -R'
alias rview 'nvim -RZ'
alias rvim 'nvim -Z'

alias vimdiff 'nvim -d'
