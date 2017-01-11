function gzip
    type -q pigz
    and pigz $argv
    or command gzip $argv
end
