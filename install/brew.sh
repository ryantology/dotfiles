#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure Homebrew is in PATH
# On Apple Silicon, brew installs to /opt/homebrew
# On Intel, brew installs to /usr/local
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install the Homebrew packages I use on a day-to-day basis.

apps=(
    bat
    eza
    node
    coreutils
    moreutils
    findutils
    fd
    ripgrep
    jq
    gh
    fzf
    zoxide
    php
    composer
    pnpm
    imagemagick
    tree
    ffmpeg
    wget
    diff-so-fancy
    git
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
