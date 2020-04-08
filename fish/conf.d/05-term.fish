status is-interactive; or exit
switch $TERM

    # Fix DEL key in st
    case 'st*'
        set -gx is_simple_terminal 1
        set -gx COLORTERM truecolor

    case "linux"
        set -e is_simple_terminal
        set -e COLORTERM
end

if set -q is_simple_terminal
    tput smkx 2>/dev/null
    function fish_enable_keypad_transmit --on-event fish_postexec
        tput smkx 2>/dev/null
    end

    function fish_disable_keypad_transmit --on-event fish_preexec
        tput rmkx 2>/dev/null
    end
end
