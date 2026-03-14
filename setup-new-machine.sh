# New machine setup guide
# Copy paste this file in bit by bit. Don't run it all at once.

echo "Do not run this script in one go. Hit Ctrl-C NOW"
read -n 1

###############################################################################
# Backup old machine's dotfiles                                               #
###############################################################################

mkdir -p ~/migration/home
cd ~/migration

# Back up important files
cp ~/.extra ~/migration/home 2>/dev/null
cp ~/.z ~/migration/home 2>/dev/null
cp -R ~/.ssh ~/migration/home
cp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration 2>/dev/null
cp -R ~/Library/Services ~/migration 2>/dev/null
cp -R ~/Documents ~/migration
cp ~/.bash_history ~/migration/home 2>/dev/null
cp ~/.zsh_history ~/migration/home 2>/dev/null
cp ~/.gitconfig.local ~/migration

###############################################################################
# Homebrew (will install XCode Command Line Tools if needed)                  #
###############################################################################

$HOME/dotfiles/install/brew.sh
$HOME/dotfiles/install/brew-cask.sh

###############################################################################
# OSX defaults                                                                #
# https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
###############################################################################

sh $HOME/dotfiles/osx/set-defaults.sh

###############################################################################
# Symlinks to link dotfiles into ~/                                           #
###############################################################################

$HOME/dotfiles/setup.sh
