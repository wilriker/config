function make
	exists grc; and grc -es --colour=auto make $argv; or command make $argv
end
