function feh
	if test (count $argv) -eq 0
        command feh
    else if string match -qr -- '^-.*' (string trim -- argv[1])
        command feh $argv
    else
        set -l file (realpath $argv[1])
        if test -d $file
            command feh $file
        else
            set -l dir (dirname $file)
            command feh $dir --start-at $file
        end
    end
end
