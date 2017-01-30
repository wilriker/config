#!/usr/bin/env fish

set -l updates 0
set -l lock_file /tmp/update-check.lock

if type -q pacaura
    set updates (flock -xn $lock_file pacaur -Qu | wc -l)
else if type -q pacman
    set updates (flock -xn $lock_file pacman -Qu | wc -l)
else if type -q yum
    set -l update_check_file /tmp/last-update-check
    set -l update_result_file /tmp/update-count
    if not test -f $update_check_file
        echo 0 > $update_check_file
    end
    set -l now (date +%s)
    set -l old (cat $update_check_file)
    set -l diff (math "$now - $old")
    if test $diff -gt 3600
        echo $now > $update_check_file
        set updates (flock -xn $lock_file yum check-update | egrep "(\.i386|\.x86_64|\.noarch|\.src)" | wc -l)
        echo $updates > $update_result_file
    else
        set updates (cat $update_result_file)
    end
end

echo -n $updates
