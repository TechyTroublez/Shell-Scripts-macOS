#!/bin/zsh

## Demote standard user
# Version 19.10.2023
# Created by: Dean Hoile

LOG_FILE="/Library/Logs/Microsoft/IntuneScripts/DemoteUser.log"
loggedInUser=$(stat -f "%Su" /dev/console)

echo "Starting demotion process for user $loggedInUser..." >> "$LOG_FILE"

sudo dseditgroup -o edit -d "$loggedInUser" -t user admin >> "$LOG_FILE" 2>&1
errcode=$?

if [ "$errcode" -ne 0 ]; then
    echo "Demotion failed for user $loggedInUser" >> "$LOG_FILE"
    echo "Failed"
    exit 1
fi

echo "Admin rights revoked for user $loggedInUser" >> "$LOG_FILE"
echo "Demotion process completed." >> "$LOG_FILE"

exit 0
