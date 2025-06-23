#!/bin/bash

# Install packages
apps=(
    dropbox
    1password
    iterm2
    firefox
    google-chrome
    google-drive
    spotify
    slack
    discord
    zoom
    tuple
    steam
    sonos
    sonos-s1-controller
    insomnia
    tableplus
    microsoft-office
    visual-studio-code
    whatsapp
    windsurf
    obsidian
)

brew install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook
