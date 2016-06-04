function exists --description 'Check if a given command exists'
	set -l usage "Usage: exists [--on-disk-only] <command-name>"
    set -l arg_count (count $argv)

	if test $arg_count -gt 2
        echo $usage
        return 1
    end

    if string match -q -- "--on-disk-only" $argv[1]
        if test $arg_count -ne 2
            echo $usage
            return 1
        end
        if not command -s $argv[2]
            if type -q $argv[2]
                echo "$argv[2] exists but is of type "(type -t $argv[2])
            end
            return 1
        end
    else
        if test $arg_count -ne 1
            echo $usage
            return 1
        end
        type -q $argv
    end
end
