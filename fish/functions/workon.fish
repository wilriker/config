function workon --description 'Activate virtual environment in /home/mcoenen/.virtualenvs'
	set tgt {$WORKON_HOME}/$argv[1]
  if [ -d $tgt ]

    # deactivate any active venv, and activate the target
    # this needs to be rewritten with the `type` fish command
    if test -n "$VIRTUAL_ENV"
      deactivate
    end

    . $tgt/bin/activate.fish
  else
    echo "$tgt not found"
  end
end
