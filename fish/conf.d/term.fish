if status --is-interactive
    switch $TERM

        # Fix DEL key in st
        case 'st*'
            set -gx is_simple_terminal 1

        case "linux"
            set -ex is_simple_terminal
            function fish_prompt
                fish_fallback_prompt
            end
    end

    if set -q is_simple_terminal
        tput smkx ^/dev/null
        function fish_enable_keypad_transmit --on-event fish_postexec
            tput smkx ^/dev/null
        end

        function fish_disable_keypad_transmit --on-event fish_preexec
            tput rmkx ^/dev/null
        end
    end
end
