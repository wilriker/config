function get
	if type -q curl
        curl --continue-at - --location --progress-bar --remote-name --remote-time $argv
    else if type -q wget
        wget --continue --progress=bar --timestamping $argv
    end
end
