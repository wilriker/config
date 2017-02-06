if status is-login

    # Nothing to do if grc is not installed at all
    if not type -q grc
        exit
    end

    # Define programs that should be wrapped
    set -l execs    blkid dig docker docker-machine env free gcc g++ ip iptables \
                    iostat journalctl last lsattr lsblk lsmod lspci make mount \
                    mvn netstat nmap ping ping6 ps sar showmount stat sysctl \
                    systemctl tcpdump traceroute tune2fs ulimit uptime vmstat w who

    for exec in $execs

        # If program is not installed or function is already present skip
        if not command -sq $exec
            or functions -q $exec
            continue
        end

        # Create function
        echo "function $exec --wraps $exec; command grc -es --colour=auto $exec \$argv; end" | source
    end

    echo "function configure; grc -es --colour=auto ./configure \$argv; end" | source
end
