function mount
	exists grc; and grc -es --colour=auto mount $argv; or command mount $argv
end
