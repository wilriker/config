set -l alphabet a b c d e f g h i j k l m n o p q r s t u v w x y z
for letter in $alphabet
    set -l completions (herbstclient -q complete_shell 0 $letter)
    for completion in $completions
        complete -xc herbstclient -d "Command" -a $completion
    end
end
