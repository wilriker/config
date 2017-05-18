function feh
	if string match -qr -- '-.*' $argv[1]
        command feh $argv
    else
        set -l file (realpath $argv[1])
        set -l dir (dirname $file)
        command feh $dir --start-at $file
    end
end
