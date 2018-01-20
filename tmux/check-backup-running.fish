#!/usr/bin/env fish

if pgrep -fa /bin/backup.fish >/dev/null ^/dev/null
    echo -n "bip"
    exit 0
end

echo -n "-"
