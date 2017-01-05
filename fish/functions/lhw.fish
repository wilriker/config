function lhw
	type -pq $argv; and lh (which $argv); or return 1
end
