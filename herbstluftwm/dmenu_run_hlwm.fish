#!/usr/bin/env fish

if not command -sq dmenu
	echo "Error: Requirement dmenu not found in your PATH." >&2
	exit 1
end

# Get the currently active tag
set -l tag (herbstclient attr tags.focus.name)
set -l cmd

# Redirect to dmenu_path if available
if command -sq dmenu_path
    dmenu_path | dmenu $argv | read -a cmd

# If we can find stest use the code from latest dmenu_path directly
else if command -sq stest
	set -l cachedir $HOME/.cache
    set -q XDG_CACHE_HOME; and set cachedir $XDG_CACHE_HOME

    set -l cache $HOME/.dmenu_cache
	test -d $cachedir; and set cache $cachedir/dmenu_run

	if stest -dqr -n $cache $PATH
		stest -flx $PATH | sort -u | tee $cache | dmenu $argv | read -a cmd
	else
		dmenu $argv < $cache | read -a cmd
    end
else
	echo "Error: Requires dmenu_path or stest in your PATH." >&2
	exit 2
end

set -l script_dir (cd (dirname (status filename)); and pwd)
exec env $script_dir/run_on_tag.fish --tag $tag $cmd
