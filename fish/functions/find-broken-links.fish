# Defined in /tmp/fish.2EiSjY/find-broken-links.fish @ line 2
function find-broken-links --description 'Find broken symlinks in and below the current dir'
	find . -xtype l
end
