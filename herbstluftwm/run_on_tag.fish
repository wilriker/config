#!/usr/bin/env fish

set -l options 't/tag='
argparse --name run_on_tag.fish $options -- $argv
or exit 1


set -q _flag_tag; or set -l _flag_tag (herbstclient attr tags.focus.name)
set -l cmd $argv


# Stop here if the user aborted
test -z "$cmd"; and exit 0

# Move next window from this process to this tag. Prepend the rule so
# that it may be overwritten by existing custom rules e.g. in the
# autostart. Also set a maximum age for this rule of 60 seconds and
# mark it as one-time-only rule.
herbstclient rule prepend maxage=60 pid=(echo -n %self) tag=$_flag_tag once

exec env $cmd
