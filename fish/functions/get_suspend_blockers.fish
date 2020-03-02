# Defined in /tmp/fish.EtDa9F/get_suspend_blockers.fish @ line 1
function get_suspend_blockers
    systemd-inhibit | fgrep -B3 "Mode: block" | grep -B1 -A2 "What:.*sleep" | egrep "(Who:|Why:)"
end
