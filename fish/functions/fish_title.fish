# Defined in /tmp/fish.iNAAZX/fish_title.fish @ line 2
function fish_title
    # emacs is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS
        set -l cmd (string split --no-empty -- ' ' $argv)
        set -l title
        if test "$cmd[1]" = "sudo" -o "$USER" = "root"
            set title (echo "# $cmd[2]")
        else
            set title (status current-command)
        end
        echo $title (__fish_pwd)
    end
end
