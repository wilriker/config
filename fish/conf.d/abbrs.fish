# This file contains abbreveations per command

# Only run in interactive shells
if not status is-interactive
    exit
end

if type -q yaourt
    abbr -a ya yaourt
    abbr -a yas 'yaourt -S'
    abbr -a yad 'yaourt -S --asdeps'
    abbr -a yau 'yaourt -Syua'
    abbr -a yar 'yaourt -Rns'
    abbr -a yao 'yaourt -Qtd'
end

if type -q pacaur
    abbr -a pa 'pacaur'
    abbr -a paq 'pacaur -Ss'
    abbr -a pas 'pacaur -S'
    abbr -a pad 'pacaur -S --asdeps'
    abbr -a pau 'pacaur -Syu'
    abbr -a par 'pacaur -Rns'
    abbr -a pao 'pacaur -Qtd'
end

if type -q systemctl

    # System-wide services
    abbr -a startd      'sudo systemctl start'
    abbr -a stopd       'sudo systemctl stop'
    abbr -a restartd    'sudo systemctl restart'
    abbr -a statusd     'sudo systemctl status'
    abbr -a enabled     'sudo systemctl enable'
    abbr -a reenabled   'sudo systemctl reenable'
    abbr -a disabled    'sudo systemctl disable'
    abbr -a editd       'sudo -E systemctl edit'
    abbr -a catd        'systemctl cat'

    # User services
    abbr -a ustartd     'systemctl --user start'
    abbr -a ustopd      'systemctl --user stop'
    abbr -a urestartd   'systemctl --user restart'
    abbr -a ustatusd    'systemctl --user status'
    abbr -a uenabled    'systemctl --user enable'
    abbr -a ureenabled  'systemctl --user reenable'
    abbr -a udisabled   'systemctl --user disable'
    abbr -a ueditd      'systemctl --user edit'
    abbr -a catd        'systemctl --user cat'

    # General
    abbr -a reloadd     'sudo systemctl daemon-reload'
    abbr -a ureloadd     'systemctl --user daemon-reload'
end

if type -q git
    abbr -a gti git
    abbr -a got git
end

if type -q yum
    abbr -a yums 'yum search'
    abbr -a yumi 'sudo yum install'
    abbr -a yumq 'yum info'
    abbr -a yumr 'sudo yum autoremove'
end

if type -q unarchive
    abbr -a x unarchive
end

if type -q herbstclient
    abbr -a hc herbstclient
end

if type -q colordiff
    abbr -a diff colordiff
end

if type -q free
    abbr -a free 'free -m'
end

if type -q pgrep
    abbr -a pgrep 'pgrep -fa'
end
