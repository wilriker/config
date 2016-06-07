function _get_herbstclient_completion
    set -l tokens (commandline -op)

    # If the user only just entered "herbstclient" return everything
    if test (count $tokens) -eq 1
        herbstclient -q complete 0
        return
    end

    set -l parameters $tokens[2..-1]
    set -l position (math (count $parameters) - 1)
    set -l completions (herbstclient -q complete $position $parameters)

    # If the last parameter equals the only result increase the position to get the next token
    if test (count $completions) -eq 1
        and string match -- $completions[1] $parameters[-1]
        set position (math $position + 1)
    end
    herbstclient -q complete $position $parameters
end

complete -xc herbstclient -d "" -a '(_get_herbstclient_completion)'

complete -c herbstclient -f -s n -l no-newline -d 'Do not print a newline if output does not end with a newline.'
complete -c herbstclient -f -s 0 -l print0 -d 'Use the null character as delimiter between the output of hooks.'
complete -c herbstclient -f -s l -l last-arg -d 'When using -i or -w, only print the last argument of the hook.'
complete -c herbstclient -f -s i -l idle -d 'Wait for hooks instead of executing commands.'
complete -c herbstclient -f -s w -l wait -d 'Same as --idle but exit after first --count hooks.'
complete -c herbstclient -f -s c -l count -r -d 'Let --wait exit after COUNT hooks were received and printed.'
complete -c herbstclient -f -s q -l quiet -d 'Do not print error messages if herbstclient cannot connect to the running herbstluftwm instance.'
complete -c herbstclient -f -s v -l version -d 'Print the herbstclient version.'
complete -c herbstclient -f -s h -l help -d 'Print the herbstclient usage with its command line options.'
