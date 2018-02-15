# Defined in /tmp/fish.3aJhQO/get_suspend_blockers.fish @ line 2
function get_suspend_blockers
	set -l inhibitors (systemd-inhibit)
    if test (count $inhibitors) -gt 1
        set inhibitors $inhibitors[1..-3]
        set -l blockers
        while count $inhibitors >/dev/null ^&1
            if string match -iq -- '*sleep*' $inhibitors[2]
                and string match -iq -- '*block*' $inhibitors[4]
                set blockers $blockers $inhibitors[1..5]
            end
            set -e inhibitors[1..5]
        end
        if test (count $blockers) -gt 0
            echo -e (string join -- '\n' $blockers)
        end
    end
end
