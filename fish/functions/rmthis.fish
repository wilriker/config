function rmthis --description 'Remove the current directory with all its contents'
    set -l protected_subdirs_pattern
    if set -q protected_home_subdirs; and test (count $protected_home_subdirs) -gt 0
        set protected_subdirs_pattern '(?:/('(string join '|' $protected_home_subdirs)')?)?'
    end
    set -l protected_dirs_pattern (string join '' '^' $HOME $protected_subdirs_pattern '$')
    set -l dir (pwd)
    if string match -rq -- $protected_subdirs_pattern $dir
        echo "Do NOT try to delete important directories!" >&2
        return 1
    end
    cd ..
    command rm -rf -- $dir
end
