# Defined in /tmp/fish.9nMH0F/sts.fish @ line 2
function sts --argument logout
	set -l inhibitors (systemd-inhibit)
    if test (count $inhibitors) -gt 1
        if isatty
            echo "The following process(es) delay suspend:"
            echo -e (string join '\n' $inhibitors[1..-3])
        else
            notify-send "Suspend Delayed" (string join '\n' $inhibitors[1..-3])
        end
        while test (count (systemd-inhibit)) -gt 1
            sleep 2
            isatty; and echo -n "."
        end
    end
    fish -c "sleep 2; sudo systemctl suspend &" &; disown
    if test -n "$SSH_CONNECTION" -o -n "$logout"
        exit
    end
end
