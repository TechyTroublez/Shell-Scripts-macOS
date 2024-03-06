#!/bin/zsh

# Date / Time setup
# Version 14.10.2023
# Created by: Dean Hoile

currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')

runAsUser() {
    if [[ $currentUser != "loginwindow" ]]; then
        uid=$(id -u "$currentUser")
        launchctl asuser $uid sudo -u $currentUser "$@"
    fi
}


/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
/usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true
/usr/bin/defaults write /private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeOnlyEnabled -bool YES
/usr/bin/defaults write /private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeZoneEnabled -bool YES
/usr/sbin/systemsetup -setusingnetworktime on
/usr/sbin/systemsetup -gettimezone
/usr/sbin/systemsetup -getnetworktimeserver