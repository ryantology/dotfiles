#!/bin/bash

# Install packages
apps=(
    dropbox
    1password
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
    ghostty
    tableplus
    microsoft-office
    visual-studio-code
    whatsapp
    windsurf
    obsidian
)

brew install "${apps[@]}"
