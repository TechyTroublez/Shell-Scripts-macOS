#!/bin/zsh

# Create Admin
# Version 19.10.2023
# Created by: Dean Hoile

# Set variables
managedAdminAccount="ladmin"
managedAdminUID="509"  # Set the UID value here
managedAdminAccountPassword="GaDwu93re"
logFile="/Library/Logs/Microsoft/IntuneScripts/CreateAdmin.txt"

# Check if the admin account already exists
if id "$managedAdminAccount" &>/dev/null; then
    echo "Admin account '$managedAdminAccount' already exists. Skipping creation." | tee -a "$logFile"
else
    # Use sysadminctl to add an admin user
    sudo sysadminctl -addUser "$managedAdminAccount" -fullName "$managedAdminAccount" -UID "$managedAdminUID" -password "$managedAdminAccountPassword" -admin 2>&1 | tee -a "$logFile"
fi
