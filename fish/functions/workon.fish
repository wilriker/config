function workon --description 'Activate virtual environment in $WORKON_HOME'
    if test 1 -ne (count $argv)
        echo "Must specify a virtualenv"
        return 1
    end
    set -l workon_home $WORKON_HOME $HOME/.virtualenvs
    set -l virtualenv $workon_home[1]/$argv[1]
    set -l activate $virtualenv/bin/activate.fish
    if not test -f $activate
        echo "No virtualenv at $virtualenv"
        return 1
    end

    # deactivate any active virtualenv, and activate the virtualenv
    if test -n "$VIRTUAL_ENV"
        deactivate
    end

    source $activate
end
