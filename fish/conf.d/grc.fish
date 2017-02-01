# Nothing to do if grc is not installed at all
if not type -q grc
    exit
end

# Define programs that should be wrapped
set -l execs    blkid dig docker docker-machine env free gcc g++ ip iptables \
                iostat journalctl last lsattr lsblk lsmod lspci make mount \
                mvn netstat nmap ping ping6 ps sar showmount stat sysctl \
                systemctl tcpdump traceroute tune2fs ulimit uptime vmstat w who

for executable in $execs

    # If program is not installed or function is already present skip
    if not command -s $executable >/dev/null
        or functions -q $executable
        continue
    end

    # Create function
    function $executable --inherit-variable executable --wraps=$executable
        command grc -es --colour=auto $executable $argv
    end
end

abbr -a './configure' 'grc -es --colour=auto ./configure'
