# name: Agnoster
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for FISH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).

## Set this options in your config.fish (if you want to :])
set -g theme_display_user yes
set -g theme_hide_hostname no
# set -g default_user your_normal_user



set -g current_bg NONE
set segment_separator \uE0B0
set right_segment_separator \uE0B0
# ===========================
# Helper methods
# ===========================

set __fish_git_prompt_char_branch ''
set __fish_git_prompt_char_detached '➦'
set __fish_git_prompt_char_clean '✔'
set __fish_git_prompt_char_dirty '⚡'
set __fish_git_prompt_char_staged '~'
set __fish_git_prompt_char_stashed '$'
set __fish_git_prompt_char_ahead '↑'
set __fish_git_prompt_char_behind '↓'
set __fish_git_prompt_char_diverged '↕'

function git_branch_status -d "Get the branch state compared to upstream"
	set -l git_status (command git status --ignore-submodules | head -n 2 | tail -n 1)
	if test -n $git_status
		if echo $git_status | grep -q "ahead"
			echo -n $__fish_git_prompt_char_ahead
		else if echo $git_status | grep -q "behind"
			echo -n $__fish_git_prompt_char_behind
		else if echo $git_status | grep -q "diverged"
			echo -n $__fish_git_prompt_char_diverged
		end
	end
end

function git_is_workdir
	set -l workdir (command git rev-parse --is-inside-work-tree ^&-)
	test "$workdir" = "true"
end

function git_is_bare
	set -l bare (command git rev-parse --is-bare-repository ^&-)
	test "$bare" = "true"
end

function git_is_git_dir
	git_is_workdir; or git_is_bare
end


# ===========================
# Segments functions
# ===========================

function prompt_segment -d "Function to draw a segment"
  set -l bg
  set -l fg
  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end
  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end
  if [ "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg" ]
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator "
    set_color -b $bg
    set_color $fg
  else
    set_color -b $bg
    set_color $fg
    echo -n " "
  end
  set current_bg $argv[1]
  if test (count $argv) -ge 3; and test -n "$argv[3]"
    echo -n -s $argv[3] " "
  end
end

function prompt_finish -d "Close open segments"
  if [ -n $current_bg ]
    set_color -b normal
    set_color $current_bg
    echo -n "$segment_separator "
  end
  set -g current_bg NONE
end


# ===========================
# Theme components
# ===========================

function prompt_virtual_env -d "Display Python virtual environment"
  if test "$VIRTUAL_ENV"
    prompt_segment yellow black (basename $VIRTUAL_ENV)
  end
end

function prompt_user -d "Display current user if different from $default_user"
  if [ "$theme_display_user" = "yes" ]
    if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
      set USER (whoami)
      get_hostname
      if [ $HOSTNAME_PROMPT ]
        set USER_PROMPT $USER@$HOSTNAME_PROMPT
      else
        set USER_PROMPT $USER
      end
      prompt_segment 1c1c1c white $USER_PROMPT
    end
  else
    get_hostname
    if [ $HOSTNAME_PROMPT ]
      prompt_segment 1c1c1c white $HOSTNAME_PROMPT
    end
  end
end

function get_hostname -d "Set current hostname to prompt variable $HOSTNAME_PROMPT if connected via SSH"
  set -g HOSTNAME_PROMPT ""
  if [ "$theme_hide_hostname" != "yes" -a -n "$SSH_CLIENT" ]
    set -g HOSTNAME_PROMPT (hostname)
  end
end

function prompt_dir -d "Display the current directory"
  prompt_segment 87afd7 black (pwd)
end

function prompt_git -d "Display the current git state"
  if git_is_git_dir
	set -l branch
	set -l bg		white
	set -l fg		black
	set -l ref		(command git symbolic-ref --quiet HEAD)
    if [ $status -gt 0 ]
      set branch (command git show-ref --head -s --abbrev | head -n1 ^&-)
      set branch "$__fish_git_prompt_char_detached $branch "
    else
      set branch "$__fish_git_prompt_char_branch "(echo $ref | sed "s|refs/heads/| |")
    end
	git_is_bare; and set branch "$branch (bare)"
	if git_is_workdir
		set -l dirty	(command git diff --no-ext-diff --ignore-submodules --quiet --exit-code;			or echo -n $__fish_git_prompt_char_dirty)
		set -l staged	(command git diff --no-ext-diff --ignore-submodules --quiet --exit-code --cached;	or echo -n $__fish_git_prompt_char_staged)
		set -l stashed	(command git rev-parse --verify --quiet refs/stash >&-; and echo -n $__fish_git_prompt_char_stashed)
		set -l state
		if test -z $dirty
			set state $__fish_git_prompt_char_clean
		else
			set state $dirty
			set bg yellow
		end
		set branch "$branch $staged$stashed$state"
	end
    prompt_segment $bg $fg "$branch"
  end
end

function prompt_status -d "the symbols for a non zero exit status, root and background jobs"
    if [ $RETVAL -ne 0 ]
      prompt_segment black red "✘"
    end

    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
      prompt_segment black yellow "⚡"
    end

    # Jobs display
    if [ (jobs -l | wc -l) -gt 0 ]
      prompt_segment black cyan "⚙"
    end
end

function prompt_prompt -d "Display the prompt character in a new line"

	set_color -b black
    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
		set_color red
		echo -en "\n# "
	else
		set_color green
		echo -en "\n\$ "
    end
	set_color normal
end

# ===========================
# Apply theme
# ===========================

function fish_prompt
  set -g RETVAL $status
  prompt_user
  prompt_status
  prompt_dir
  prompt_virtual_env
  type -q git; and prompt_git
  prompt_finish
  prompt_prompt
end
