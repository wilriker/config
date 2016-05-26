function gzip
	exists pigz; and pigz $argv; or command gzip $argv
end
