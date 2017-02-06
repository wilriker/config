if status is-login

    # Nothing to do if nvim is not installed at all
    if not type -q nvim
        exit
    end

    for exec in edit ex rview rvim vedit vi view vim
        echo "function $exec --wraps $exec; nvim \$argv; end" | source
    end

    echo "function vimdiff --wraps vimdiff; nvim -d \$argv; end" | source
end
