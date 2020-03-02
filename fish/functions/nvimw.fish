# Defined in /tmp/fish.22kAtn/nvimw.fish @ line 2
function nvimw
    if command -sq $argv
        nvim (command -s $argv)
    else if functions -q $argv
        funced $argv
    else
        echo "No executable or function named $argv found"
        return 1
    end
end
