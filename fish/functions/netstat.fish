function netstat
	exists grc; and grc -es --colour=auto netstat $argv; or command netstat $argv
end
