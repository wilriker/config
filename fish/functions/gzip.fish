function gzip
	if exits pigz
		pigz $argv
	else
		gzip $argv
	end
end
