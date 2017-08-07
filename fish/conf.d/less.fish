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
