#!/bin/bash

# Add alternate version casks
brew tap homebrew/cask-versions

# Install packages
apps=(
    dropbox
    iterm2
    firefox
    google-chrome
    opera
    spotify
    skype
    slack
    discord
    zoom
    tuple
    steam
    sonos
    sonos-s1-controller
    insomnia
    monodraw
    sequel-pro
    tableplus
    sketch
    backblaze
    sublime-text
    microsoft-office
    visual-studio-code
    whatsapp
)

brew install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook
