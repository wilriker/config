function unln
	for file in $argv
        sed -i '' $file
    end
end
