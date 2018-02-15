# Defined in /tmp/fish.QuNfHA/sts.fish @ line 2
function sts --argument logout
	set -l blockers (get_suspend_blockers)
    if count $blockers >/dev/null ^&1
        if isatty
            echo "The following process(es) block suspend:"
            echo -e (string join '\n' $blockers)
        else
            notify-send "Suspend Blocked" (string join '\n' $blockers)
        end
        while test (count (get_suspend_blockers)) -gt 0
            sleep 2
            isatty; and echo -n "."
        end
    end
    fish -c "sleep 2; sudo systemctl suspend &" &; disown
    if test -n "$SSH_CONNECTION" -o -n "$logout"
        exit
    end
end
