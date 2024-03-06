#!/bin/zsh

# Allow Network Settings Access
# Version 13.10.2023
# Created by: Dean Hoile

#For WiFi

/usr/bin/security authorizationdb write system.preferences.network allow
/usr/bin/security authorizationdb write system.services.systemconfiguration.network allow

