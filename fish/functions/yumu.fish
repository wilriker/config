# Defined in /tmp/fish.c6GdS9/yumu.fish @ line 2
function yumu
	sudo yum -q update
    and echo 0 >/tmp/last-update-check
end
