function get
	if exists curl
        curl --continue-at - --location --progress-bar --remote-name --remote-time $argv
    else if exists wget
        wget --continue --progress=bar --timestamping $argv
    end
end
