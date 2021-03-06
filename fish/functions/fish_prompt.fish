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
# ===========================
# Helper methods
# ===========================

function git_state -d "Information on current repo state and branch compared to upstream"
    set -l st 0
    set -l git_status (command git status --porcelain -b)

    # Read branch state into array
    echo $git_status[1] | read -al branch_state

    # Remove first to elements of branch state
    set -e branch_state[1]
    set -e branch_state[1]

    # Remove branch state from repo state
    set -e git_status[1]

    set -l changedFiles
    set -l conflictingFiles
    set -l stagedFiles
    set -l deletedFiles
    set -l untrackedFiles

    for line in $git_status
        switch "$line"
            case '\?\?*'
                set untrackedFiles $untrackedFiles 1
            case 'DD*' 'AU*' 'UD*' 'UA*' 'DU*' 'AA*' 'UU*'
                set conflicingFiles $conflictingFiles 1
            case 'D *' ' D*'
                set deletedFiles $deletedFiles 1
            case '*'
                if string match -rq -- '^\s\S' $line
                    set changedFiles $changedFiles 1
                else if string match -rq -- '^\S\s' $line
                    set stagedFiles $stagedFiles 1
                end
        end
    end

    set untrackedFiles (count $untrackedFiles)
    set conflicingFiles (count $conflicingFiles)
    set deletedFiles (count $deletedFiles)
    set changedFiles (count $changedFiles)
    set stagedFiles (count $stagedFiles)


    if test (math "$changedFiles + $deletedFiles + $stagedFiles + $untrackedFiles") -eq 0
        echo -n ' ✔'
    else
        if test $stagedFiles -ne 0
            echo -n " $stagedFiles✚"
        end
        if test $deletedFiles -ne 0
            echo -n " $deletedFiles✖"
        end
        if test $changedFiles -ne 0
            echo -n " $changedFiles⚡"
        end
        if test $untrackedFiles -ne 0
            echo -n " $untrackedFiles…"
        end
        set st 1
    end

    if string match -rq -- '.*\[(ahead \d+, behind \d+\].*)' "$branch_state"
        echo -n (string replace -r -- '.*\[ahead ' ' ↑' (string replace -- ', behind ' '↓' (string replace -r -- '\].*' '' "$branch_state")))
    else if string match -rq -- '.*\[ahead \d+\].*' "$branch_state"
        echo -n (string replace -r -- '.*\[ahead ' ' ↑' (string replace -r -- '\].*' '' "$branch_state"))
    else if string match -rq -- '.*\[behind \d+\].*' "$branch_state"
        echo -n (string replace -r -- '.*\[behind ' ' ↓' (string replace -r -- '\].*' '' "$branch_state"))
    end

    return $st
end


# ===========================
# Segments functions
# ===========================

function prompt_segment -d "Function to draw a segment"
    set -l bg
    set -l fg
    if test -n "$argv[1]"
        set bg $argv[1]
    else
        set bg normal
    end
    if test -n "$argv[2]"
        set fg $argv[2]
    else
        set fg normal
    end
    if test "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg"
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
    if test (count $argv) -ge 3
        and test -n "$argv[3]"
        echo -n -s $argv[3] " "
    end
end

function prompt_finish -d "Close open segments"
    if test -n $current_bg
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
    if test "$theme_display_user" = "yes"
        if test "$USER" != "$default_user" -o -n "$SSH_CLIENT"
            set USER (whoami)
            get_hostname
            if test -n "$HOSTNAME_PROMPT"
                set USER_PROMPT $USER@$HOSTNAME_PROMPT
            else
                set USER_PROMPT $USER
            end
            prompt_segment 1c1c1c white $USER_PROMPT
        end
    else
        get_hostname
        if test -n "$HOSTNAME_PROMPT"
            prompt_segment 1c1c1c white $HOSTNAME_PROMPT
        end
    end
end

function get_hostname -d "Set current hostname to prompt variable $HOSTNAME_PROMPT if connected via SSH"
    set -g HOSTNAME_PROMPT ""
    if test "$theme_hide_hostname" != "yes" -a -n "$SSH_CLIENT"
        set -g HOSTNAME_PROMPT (hostname)
    end
end

function prompt_dir -d "Display the current directory"
    prompt_segment 87afd7 black (prompt_pwd)
end

function prompt_git -d "Display the current git state"
    # If git isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq git
        return 1
    end
    set -l repo_info (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD 2>/dev/null)
    test -n "$repo_info"
    or return

    set -l git_dir $repo_info[1]
    set -l inside_gitdir $repo_info[2]
    set -l bare_repo $repo_info[3]
    set -l inside_worktree $repo_info[4]
    set -l short_sha
    if test (count $repo_info) = 5
        set short_sha $repo_info[5]
    end

    set -l bg white
    set -l fg black
    set -l repo_state

    set -l branch
    set -l ref (command git symbolic-ref HEAD 2>/dev/null; set os $status)
    if test $os -ne 0
        set branch "➦ $short_sha"
    else
        set branch ' '(string replace 'refs/heads/' '' $ref)
    end

    if test "true" = $inside_gitdir
        if test "true" = $bare_repo
            set branch "$branch (bare)"
        else
            set branch "GIT_DIR!"
        end
    else if test "true" = $inside_worktree
        set repo_state (git_state; or set bg yellow)
    end

    prompt_segment $bg $fg "$branch$repo_state"
end

function prompt_status -S -d "the symbols for a non zero exit status, root and background jobs"
    if test $last_status -ne 0
        prompt_segment black red "✘"
    end

    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if test $uid -eq 0
        prompt_segment black yellow "⚡"
    end

    # Jobs display
    if test (jobs -l | wc -l) -gt 0
        prompt_segment black cyan "⚙"
    end
end

function prompt_prompt -d "Display the prompt character in a new line"

    set_color -b black
    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if test $uid -eq 0
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
    set last_status $status
    prompt_user
    prompt_status
    prompt_dir
    prompt_virtual_env
    prompt_git
    prompt_finish
    prompt_prompt
end
