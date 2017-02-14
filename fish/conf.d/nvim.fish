# Nothing to do if nvim is not installed at all
if not type -q nvim
    exit
end

echo 'function vim; echo "Use nvim!" >&2; return 1; end' | source
echo 'function vimdiff; echo "Use nvim -d!" >&2; return 1; end' | source

alias ex 'nvim -e'
alias exim 'nvim -E'

