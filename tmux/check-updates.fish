#!/usr/bin/env fish

function install_pacman_hook -S -d "Install a pacman hook to reset update count if not existing"
    set -l hook /etc/pacman.d/hooks/reset-update-count.hook
    if not test -f $hook
        sudo mkdir -p /etc/pacman.d/hooks
        echo "\
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Reset available updates count after upgrade
Depends = coreutils
Depends = bash
When = PostTransaction
Exec = /usr/bin/sh -c '/usr/bin/echo 0 > $update_result_file'\
" | sudo tee $hook >&-
    end
end

set -l update_interval 3600
if type -q pacaur
    or type -q pacman
    set update_interval 900
end
set -l updates 0
set -l lock_file /tmp/update-check.lock

set -l update_check_file /tmp/last-update-check
set -l update_result_file /tmp/update-count
if not test -f $update_check_file
    echo 0 >$update_check_file
end
set -l now (date +%s)
set -l old (cat $update_check_file)
set -l diff (math "$now - $old")
set -l icon 
if type -q yum
    set icon 
end
if test $diff -gt $update_interval
    echo $now >$update_check_file
    if type -q pacaur
        install_pacman_hook
        pacaur -Sy >&- ^&-
        set updates (flock -xn $lock_file pacaur -Qu | wc -l)
    else if type -q pacman
        install_pacman_hook
        sudo pacman -Sy >&- ^&-
        set updates (flock -xn $lock_file pacman -Qu | wc -l)
    else if type -q yum
        set updates (flock -xn $lock_file yum check-update | egrep "(\.i386|\.x86_64|\.noarch|\.src)" | wc -l)
    end
    echo $updates >$update_result_file
else
    set updates (cat $update_result_file)
end

echo -n "$icon $updates"
