#!/usr/bin/env bash

# ~/.macos - https://mths.be/macos
# Modified from https://github.com/nicksp/dotfiles

# Close any open System Settings panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Settings" to quit' 2>/dev/null

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Computer Name                                                               #
###############################################################################

read -p "Set computer name (leave blank to skip): " computer_name
if [ -n "$computer_name" ]; then
  sudo scutil --set ComputerName "$computer_name"
  sudo scutil --set HostName "$computer_name"
  sudo scutil --set LocalHostName "$(echo "$computer_name" | tr ' ' '-')"
  echo "Computer name set to: $computer_name"
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic capitalization as it's annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it's annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Fill window when double-clicking its title bar
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Fill"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Apple software: Safari, Updater, etc.                                       #
###############################################################################

# Hide Safari's bookmark bar
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true

# Privacy: don't send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Prevent Safari from opening 'safe' files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Set Safari's home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Swipe controls for Google Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# Disable inline attachments in Mail.app (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
# Prevents other apps from intercepting keystrokes
defaults write com.apple.terminal SecureKeyboardEntry -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 2

###############################################################################
# Finder                                                                      #
###############################################################################

# Show the ~/Library folder
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Always open everything in Finder's list view
# Nlsv - List View, clmv - Column View, glyv - Gallery View
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

# Disable shadow in window screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# Show the mouse pointer in screenshots
# defaults write com.apple.screencapture showsCursor -bool true

###############################################################################
# Safari                                                                      #
###############################################################################

# Show the full URL in the address bar
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

###############################################################################
# Security                                                                    #
###############################################################################

# Enable Firewall
# sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable Stealth Mode (Mac doesn't respond to pings or port scans)
# sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

###############################################################################
# TextEdit                                                                    #
###############################################################################

# Use plain text mode for new TextEdit documents
# defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
# defaults write com.apple.TextEdit PlainTextEncoding -int 4
# defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show all processes in Activity Monitor
# defaults write com.apple.ActivityMonitor ShowCategory -int 100

# Visualize CPU usage in the Activity Monitor Dock icon
# defaults write com.apple.ActivityMonitor IconType -int 5

# Sort Activity Monitor results by CPU usage
# defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Do some clean up work                                                       #
###############################################################################

for app in "Activity Monitor" "Calendar" "Contacts" "cfprefsd" \
           "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
           "Terminal"; do
           killall "${app}" > /dev/null 2>&1
done

# Wait a bit before moving on...
sleep 1

echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."
