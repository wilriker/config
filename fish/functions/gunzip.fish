function gunzip
    type -q unpigz
    and unpigz $argv
    or command gunzip $argv
end
