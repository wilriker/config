function ping6
    if not exists --on-disk-only ping6 >&- ^&-
        echo "ping6 not found, falling back to ping -6"
        ping -6 $argv
        return
    end
	exists grc; and grc -es --colour=auto ping6 $argv; or command ping6 $argv
end
