function bzip2
    type -q pbzip2
    and pbzip2 $argv
    or command bzip2 $argv
end
