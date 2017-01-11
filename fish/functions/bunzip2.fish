function bunzip2
    type -q pbunzip2
    and pbunzip2 $argv
    or command bunzip2 $argv
end
