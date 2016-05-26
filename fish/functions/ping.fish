function ping
	exists grc; and grc -es --colour=auto ping $argv; or command ping $argv
end
