function tmx --description 'Create a new session with (optionally) given name or attach indendently to it'
	set -l session_name default
    if test (count $argv) -gt 0
        set -l session_name $argv[1]
    end
    if not tmux has-session -t $session_name
        echo "Launching tmux base session $session_name"
        tmux new-session -s $session_name
    else
        if set -q TMUX
            echo "You are already inside tmux" >&2
            return 1
        end
        echo "Attaching independently to tmux base session $session_name"
        # Use timestamp as unique session id
        set -l session_id {$session_name}_(date +%Y%m%d%H%M%S)
        # Create a new session without attaching it and link it to base session
        tmux new-session -d -t $session_name -s $session_id
        # Attach to new session and destroy new session once it is orphaned
        tmux attach-session -t $session_id \; set-option destroy-unattached
    end
end
