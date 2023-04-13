#!/bin/zsh

# Get the serial number of the Machine
serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')

# Get the current computer Name, HostName, and LocalHostName
current_name=$(scutil --get ComputerName)
current_hostname=$(scutil --get HostName)
current_local_hostname=$(scutil --get LocalHostName)


# Set the computer Name, computer HostName, and computer LocalHostName to the serial number if it's not already set
if [ "$current_name" != "$serial" ]; then
    scutil --set ComputerName $serial
    echo "Computer Name changed to $serial"
else
    echo "Computer Name is already $serial"
fi
if [ "$current_hostname" != "$serial" ]; then
    scutil --set HostName $serial
    echo "Computer HostName changed to $serial"
else
    echo "Computer HostName is already $serial"
fi
if [ "$current_local_hostname" != "$serial" ]; then
    scutil --set LocalHostName $serial
    echo "Computer LocalHostName changed to $serial"
else
    echo "Computer LocalHostName is already $serial"
fi

# Flush the DNS cache so the new name takes effect
dscacheutil -flushcache

exit 0
