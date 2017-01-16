function rmthis --description 'Remove the current directory with all its contents'
    set -l protected_subdirs_pattern
    if set -q protected_home_subdirs
        if test (count $protected_home_subdirs) -gt 0
            set protected_subdirs_pattern '(?:/('(string join '|' $protected_home_subdirs)')?)?'
        end
    else
        echo '$protected_home_subdirs not set. Please set it with' >&2
        echo '$ set -U protected_home_subdirs ...' >&2
        echo 'Note: it can be empty but it should be set.' >&2
    end
    set -l protected_dirs_pattern (string join '' '^' $HOME $protected_subdirs_pattern '$')
    set -l dir (pwd)
    if string match -rq -- $protected_dirs_pattern $dir
        echo "Do NOT try to delete important directories!" >&2
        return 1
    end
    cd ..
    command rm -rf -- $dir
end
