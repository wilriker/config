function diff
	if exists colordiff
		colordiff $argv
	else
		diff
	end
end
