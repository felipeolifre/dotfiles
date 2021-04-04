#!/usr/bin/env bash

# Inspired by:
# - https://github.com/drduh/macOS-Security-and-Privacy-Guide
# - https://github.com/mathiasbynens/dotfiles
# - https://github.com/MikeMcQuaid/strap

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 $$ || exit; done 2>/dev/null &

# Prevent sleeping until the script has finished
caffeinate -s -w $$ &

echo "Hardening macOS..."

###############################################################################
# Hostname                                                                    #
###############################################################################

HOSTNAME="kikazaru"

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $HOSTNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $HOSTNAME

###############################################################################
# Disk Encryption                                                             #
###############################################################################

# Enable FileVault
sudo fdesetup enable

###############################################################################
# Application Firewall                                                        #
###############################################################################

# Enable Application Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Turn on logging mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on

# Enable stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Restart the Application Firewall process
sudo pkill -HUP socketfilterfw

###############################################################################
# DNS                                                                         #
###############################################################################

# TODO: Set up `dnscrypt-proxy`

###############################################################################
# Spotlight Suggestions                                                       #
###############################################################################

# TODO: Disable Spotlight Suggestions in the Spotlight preferences

###############################################################################
# Screensaver                                                                 #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Software Updates                                                            #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################
# Transmission.app                                                            #
###############################################################################

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true