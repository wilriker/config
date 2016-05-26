function ping6
	exists grc; and grc -es --colour=auto ping6 $argv; or command ping6 $argv
end
