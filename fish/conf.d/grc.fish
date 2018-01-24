# Nothing to do if grc is not installed at all
if not command -sq grc
    exit
end

# Define programs that should be wrapped
set -l execs    blkid dig docker docker-machine env findmnt free gcc g++ ip iptables \
                iostat journalctl last lsattr lsblk lsmod lspci make mount \
                mvn netstat nmap ping ping6 ps sar showmount stat sysctl \
                systemctl tcpdump traceroute tune2fs ulimit uptime vmstat w who

alias grc 'grc -es --colour=auto'

for exec in $execs

    # If program is not installed or function is already present skip
    if not command -sq $exec
        or functions -q $exec
        continue
    end

    # Create function
    echo "function $exec --wraps $exec; grc $exec \$argv; end" | source
end

echo "function configure; grc ./configure \$argv; end" | source

echo "function drill --wraps drill; grc --config conf.dig drill \$argv; end" | source
