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

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_dirtystate '±'
set -g __fish_git_prompt_char_cleanstate '✔'

function parse_git_dirty
  set -l submodule_syntax
  set submodule_syntax "--ignore-submodules=dirty"
  set git_dirty (command git status --porcelain $submodule_syntax  2> /dev/null)
  if [ -n "$git_dirty" ]
    if [ $__fish_git_prompt_showdirtystate = "yes" ]
      echo -n "$__fish_git_prompt_char_dirtystate"
    end
  else
    if [ $__fish_git_prompt_showdirtystate = "yes" ]
      echo -n "$__fish_git_prompt_char_cleanstate"
    end
  end
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
  set -l ref
  set -l dirty
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set dirty (parse_git_dirty)
    set ref (command git symbolic-ref HEAD 2> /dev/null)
    if [ $status -gt 0 ]
      set -l branch (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
      set ref "➦ $branch "
    end
    set branch_symbol \uE0A0
    set -l branch (echo $ref | sed  "s-refs/heads/-$branch_symbol -")
    if [ "$dirty" != "" ]
      prompt_segment yellow black "$branch $dirty"
    else
      prompt_segment white black "$branch $dirty"
    end
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
