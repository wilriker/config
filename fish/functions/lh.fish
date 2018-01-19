function lh
    set -l params -lah --group-directories-first
    if command -sq exa
        set params $params -b -g --git
    end
    ls $params $argv
end
