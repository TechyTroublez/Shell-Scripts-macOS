#!/bin/zsh

# ==============================================================================
# Script Management Details
# Title: macOS User Directory Permissions Setter
# Author: Zackory Strbak (zackory.strbak@semikron-danfoss.com)
# Description: This script recursively removes read and write permissions for 
#              other and group users from all user directories except Shared 
#              and system accounts.
# Date: 10 November 2023
# Version: 1.0
#
# Disclaimer: This script is provided "as is" without any warranties or guarantees. 
# The author or the associated organization shall not be liable for any damages 
# or issues arising from the use of this script. Always make backups and verify 
# functionality in a safe environment before using any script in production.
# ==============================================================================

# Constants
LOG_FILE="/Library/Logs/Microsoft/IntuneScripts/SecureFolders.log"
USER_DIR="/Users"

# Log levels
INFO="INFO"
WARN="WARN"
ERROR="ERROR"


# Log function with log levels and timestamp including timezone
log() {
    local level="$1"
    local message="$2"
    echo "$(date +"%Y-%m-%d %H:%M:%S %z") - [$level] - $message" | tee -a "$LOG_FILE"
}

# Log rotation function
log_rotate() {
    local max_size=10240 # Max log file size in Kilobytes
    local size
    size=$(du -k "$LOG_FILE" | cut -f 1) # Get the size of LOG_FILE in Kilobytes
    if [ "$size" -ge "$max_size" ]; then
        mv "$LOG_FILE" "${LOG_FILE}_$(date "+%Y%m%d%H%M%S")"
        touch "$LOG_FILE"
    fi
}

# Log file header
log_file_header() {
    echo "===============================================================================" >> "$LOG_FILE"
    echo "Log start for: $(date "+%Y-%m-%d %H:%M:%S %z")" >> "$LOG_FILE"
    echo "Script Version: 1.0" >> "$LOG_FILE"
    echo "===============================================================================" >> "$LOG_FILE"
}

# Check for required commands
if ! command -v chmod >/dev/null 2>&1; then
    log "$ERROR" "chmod is required but it's not installed. Abort."
    exit 1
fi

# Start of the script with header and log rotation
log_file_header
log_rotate
log "$INFO" "Starting user directory permissions change..."

# Iterate over each directory in the /Users directory
for dir in "$USER_DIR"/*; do
    # Extract the username from the directory path
    username=$(basename "$dir")

    # Skip the Shared and system directories
    if [ "$username" != "Shared" ] && [[ ! "$username" =~ ^_ ]]; then
        log "$INFO" "Changing permissions for $username"
        sudo chmod -R og-rw "$dir"
    else
        log "$INFO" "Skipping $username"
    fi
done

# End of the script
log "$INFO" "User directory permissions change completed."