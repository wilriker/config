# Defined in /home/mcoenen/.config/fish/functions/yumu.fish @ line 2
function yumu
	sudo yum -q update
    and echo 0 >/tmp/last-update-check
end
