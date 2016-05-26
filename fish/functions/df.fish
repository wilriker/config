function df
	exists dfc; and dfc -d $argv; or command df $argv
end
