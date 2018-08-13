#!/usr/bin/env fish

set -l update_interval 3600
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
# CentOS symbol in nerd font
set -l icon \uf304
if test $diff -gt $update_interval
    echo $now >$update_check_file
    set updates (flock -xn $lock_file yum check-update | egrep "(\.i386|\.x86_64|\.noarch|\.src)" | wc -l)
    echo $updates >$update_result_file
else
    set updates (cat $update_result_file)
end

echo -n "$icon $updates"
