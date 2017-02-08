if status is-login

    # Nothing to do if nvim is not installed at all
    if not type -q nvim
        exit
    end

    echo "function vim --wraps vim; nvim \$argv; end" | source

    echo "function ex --wraps ex; nvim -e \$argv; end" | source
    echo "function exim --wraps exim; nvim -E \$argv; end" | source

    echo "function view --wraps view; nvim -R \$argv; end" | source
    echo "function rview --wraps rview; nvim -RZ \$argv; end" | source
    echo "function rvim --wraps rvim; nvim -Z \$argv; end" | source

    echo "function vimdiff --wraps vimdiff; nvim -d \$argv; end" | source
end
