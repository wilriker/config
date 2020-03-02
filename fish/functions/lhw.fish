function lhw
    type -pq $argv; and lh (command -s $argv); or return 1
end
