# Nothing to do if grc is not installed at all
if not command -s grc >/dev/null
    exit
end

# Define programs that should be wrapped
set -l execs dig g++ gcc make mount netstat ping ping6 ps traceroute

for executable in $execs

    # If program is not installed or function is already present skip
    if not command -s $executable >/dev/null
        or functions -q $executable
        continue
    end

    # Create function
    function $executable --inherit-variable executable --wraps=$executable
        grc -es --colour=auto $executable $argv
    end
end
