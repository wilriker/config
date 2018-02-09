status is-interactive
or exit
status is-login
or exit

# startx
if test -z "$DISPLAY" -a -z "$SSH_CONNECTION" -a -z "$NO_STARTX"
    if not command env DISPLAY=:0 xset -q >/dev/null ^&1
        sleep 0.5
        startx
        # exit
    end
end
