function gcc
	exists grc; and grc -es --colour=auto gcc $argv; or command gcc $argv
end
