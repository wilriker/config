function gunzip
	exists unpigz; and unpigz $argv; or command gunzip $argv
end
