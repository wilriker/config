function traceroute
	exists grc; and grc -es --colour=auto traceroute $argv; or command traceroute $argv
end
