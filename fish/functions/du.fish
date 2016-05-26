function du
	if exists cdu
		cdu -idh $argv
	else
		du $argv
	end
end
