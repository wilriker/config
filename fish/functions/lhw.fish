function lhw
	exists --on-disk-only $argv; and lh (which $argv); or return 1
end
