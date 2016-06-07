function get_herbstclient_completion
    set -l cmdline (commandline)
    set -l tokens (commandline -o)
    set -l parameters
    if test (count $tokens) -gt 1
        set parameters $tokens[2..-1]
    end
    set -l position (math (count $parameters) - 1)
    set -l completions (herbstclient -q complete $position $parameters)
    if string match $completions[1] $parameters[-1]
        set position (math $position + 1)
    end
    herbstclient -q complete $position $parameters
end

complete -xc herbstclient -d "" -a '(get_herbstclient_completion)'
