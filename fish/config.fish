if status --is-login

	# Environment variables
	set -gx PATH ~/bin $PATH
	set -gx LANG en_DK.UTF-8
	set -gx LC_COLLATE C
	set -gx EDITOR vim
	set -gx VISUAL vim
	set -gx PAGER less
	set -gx BROWSER google-chrome-stable

	# LESS related settings
	set -gx LESS '-g -i -M -R -w -z-4'
	set -gx LESSOPEN '| /usr/bin/env lesspipe.sh %s 2>&-'
	set -gx LESS_TERMCAP_mb \e\[1\;31m
	set -gx LESS_TERMCAP_md \e\[1\;38\;5\;208m
	set -gx LESS_TERMCAP_me \e\[0m
	set -gx LESS_TERMCAP_se \e\[0m
	set -gx LESS_TERMCAP_so \e\[0\;38\;5\;16\;48\;5\;110m
	set -gx LESS_TERMCAP_ue \e\[0m
	set -gx LESS_TERMCAP_us \e\[4\;38\;5\;111m
end

# Per-Host settings
set -l host (hostname | sed -E 's/(-[0-9]+)?(\.(local|home))?$//')
set -l host_specific_file ~/.config/fish/hosts/$host.fish
if test -f $host_specific_file
	source $host_specific_file
else
	echo Creating host specific config file: $host_specific_file
	mkdir -p (dirname $host_specific_file)
	touch $host_specific_file
end

# Fix DEL key in st
tput smkx ^/dev/null
function fish_enable_keypad_transmit --on-event fish_postexec
   tput smkx ^/dev/null
end

function fish_disable_keypad_transmit --on-event fish_preexec
   tput rmkx ^/dev/null
end
