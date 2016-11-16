# Fix DEL key in st

if not status --is-interactive
    exit
end

if string match -q -- 'st*' $TERM
    tput smkx
end
