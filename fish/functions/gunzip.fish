function gunzip
	if exists unpigz
		unpigz $argv
	else
		gunzip $argv
	end
end
