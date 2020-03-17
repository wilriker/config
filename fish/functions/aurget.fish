function aurget
    for package in $argv
        get "https://aur.archlinux.org/cgit/aur.git/snapshot/$package.tar.gz"
    end
end
