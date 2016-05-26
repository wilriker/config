function dig
	exists grc; and grc -es --colour=auto dig $argv; or command dig $argv
end
