# Remove Folder
# Version 06.11.2023
# Created by: Dean Hoile

#Easy script to remove folders and or files in bulk, remember that certain directories will require the script to be run with sudo/root.

#!/bin/zsh

# Set the folder paths and executable file you want to search for
folders_and_files_to_remove=(
    "/Library/Application Support/Dialog"
    "/usr/local/bin/dialog"
)

# Set the log file path
log_file="/Library/Logs/text.log"

# Function to remove folders and files
remove_item() {
    local item="$1"
    echo "Removing: $item"
    rm -rf "$item" >> "$log_file" 2>&1
}

# Iterate over folders and files and remove them if they exist
for item in "${folders_and_files_to_remove[@]}"; do
    if [ -e "$item" ]; then
        remove_item "$item"
        if [ $? -eq 0 ]; then
            echo "Successfully removed: $item" | tee -a "$log_file"
        else
            echo "Error: Unable to remove: $item. Check the log file for details." | tee -a "$log_file"
        fi
    else
        echo "Item not found: $item" | tee -a "$log_file"
    fi
done
