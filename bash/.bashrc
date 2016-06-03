#
# ~/.bashrc
#

if shopt -q login_shell; then
	: # Things to do in login shell

	# Set variables
	export EDITOR="vim"
	export VISUAL=${EDITOR}
	export BROWSER="google-chrome-stable"
	export JAVA_HOME=/usr/lib/jvm/default
	export NVIM_TUI_ENABLE_TRUE_COLOR=

	# Aliases
	alias mkdir='mkdir -p -v'
	alias rm='rm -I --one-file-system'
	alias vim='vim -p'
	alias free='free -m'
	alias pgrep='pgrep -a -f'
	alias ya='yaourt'
	alias yau='yaourt -Syua'
	alias yas='yaourt -S'
	alias yar='yaourt -Rns'
	alias tmux='tmux attach'
	alias sudo='sudo '
	if type pigz &> /dev/null; then
		alias gzip='pigz'
		alias gunzip='unpigz'
	fi
	alias which='alias | which -i'

	# Stupid typo aliases
	alias gti='git'
	alias got='git'

	# Color wrappers
	GRC=`which grc &> /dev/null`
	if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
		alias colourify="$GRC -es --colour=auto"
		alias as='colourify as'
		alias configure='colourify ./configure'
		alias df='colourify df'
		alias diff='colourify diff'
		alias dig='colourify dig'
		alias gas='colourify gas'
		alias gcc='colourify gcc'
		alias g++='colourify g++'
		alias head='colourify head'
		alias ld='colourify ld'
		alias make='colourify make'
		alias mount='colourify mount'
		alias mtr='colourify mtr'
		alias mtrace='${GRC} mtrace'
		alias netstat='colourify netstat'
		alias ping='colourify ping'
		alias ps='colourify ps'
		alias tail='colourify tail'
		alias traceroute='colourify /usr/sbin/traceroute'
	fi
	type dfc &> /dev/null && alias df='dfc -d'
	type colordiff &> /dev/null && alias diff='colordiff'
	type cdu &> /dev/null && alias du='cdu -idh'
	alias ls='ls --color=auto'
	alias lh='ls -lah --group-directories-first'

	# less coloring
	export LESS='-g -i -M -R -w -z-4'
	export LESSOPEN='|lesspipe.sh %s'
	export LESS_TERMCAP_mb=$'\E[1;31m'					# begin blinking
	export LESS_TERMCAP_md=$'\E[1;38;5;208m'			# begin bold
	export LESS_TERMCAP_me=$'\E[0m'						# end mode
	export LESS_TERMCAP_so=$'\E[0;38;5;16;48;5;110m'	# begin standout-mode - info box
	export LESS_TERMCAP_se=$'\E[0m'						# end standout-mode
	export LESS_TERMCAP_us=$'\E[4;38;5;111m'			# begin underline
	export LESS_TERMCAP_ue=$'\E[0m'						# end underline

	# Better coloring for ls
	eval $(dircolors -b)

else
	: # Things to do in non-login shell
fi

if [[ $- = *i* ]]; then
	: # Things to do in interactive shell

	#PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/"~"}"'

	# Re-enable DEL key in bash when using simple terminal
	tput smkx
else
	: # Things to do in non-interactive shell
fi

# Machine local settings
host=$(hostname | sed -E 's/(-[0-9]+)?(\.(local|home))?$//')
[[ -f ~/.bashrc.${host} ]] && . ~/.bashrc.${host}

