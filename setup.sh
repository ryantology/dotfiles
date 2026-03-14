#!/bin/zsh

# Dotfiles setup script
# This symlinks dotfiles to ~/ and sets up the shell environment.
# Safe to run multiple times - will prompt before overwriting.

#
# Utils
#

print_error() {
  printf "\e[0;31m  [x] $1 $2\e[0m\n"
}

print_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

print_success() {
  printf "\e[0;32m  [ok] $1\e[0m\n"
}

# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Get the dotfiles directory's absolute path
DOTFILES_DIR="$( cd "$( dirname "${0}" )" && pwd )"
export DOTFILES_DIR

dir_backup=~/dotfiles_old

# Create backup directory
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~..."
mkdir -p $dir_backup
echo "done"

#
# Files to symlink
#

declare -a FILES_TO_SYMLINK=(
  'shell/shell_aliases'
  'shell/shell_config'
  'shell/shell_exports'
  'shell/shell_functions'
  'shell/bash_profile'
  'shell/bashrc'
  'shell/zshrc'
  'shell/curlrc'
  'shell/inputrc'
  'shell/screenrc'
  'shell/vimrc'

  'git/gitattributes'
  'git/gitconfig'
  'git/gitignore'
)

# Back up existing dotfiles
for i in ${FILES_TO_SYMLINK[@]}; do
  target="$HOME/.${i##*/}"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up $target to $dir_backup/"
    mv "$target" "$dir_backup/"
  fi
done

# Create symlinks
print_info "Creating symlinks"

for i in ${FILES_TO_SYMLINK[@]}; do
  sourceFile="$DOTFILES_DIR/$i"
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

  if [ -L "$targetFile" ] && [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
    print_success "$targetFile -> $sourceFile (already linked)"
  elif [ -e "$targetFile" ]; then
    read -p "'$targetFile' already exists, overwrite? (y/n) " -n 1 yn
    printf "\n"
    if [[ "$yn" =~ ^[Yy]$ ]]; then
      rm -rf "$targetFile"
      ln -fs "$sourceFile" "$targetFile"
      print_success "$targetFile -> $sourceFile"
    else
      print_error "Skipped $targetFile"
    fi
  else
    ln -fs "$sourceFile" "$targetFile"
    print_success "$targetFile -> $sourceFile"
  fi
done

# Symlink Ghostty config
print_info "Setting up Ghostty config"
mkdir -p "$HOME/.config/ghostty"
ghostty_source="$DOTFILES_DIR/ghostty/config"
ghostty_target="$HOME/.config/ghostty/config"
if [ -e "$ghostty_target" ] && [ ! -L "$ghostty_target" ]; then
  mv "$ghostty_target" "$dir_backup/ghostty-config"
fi
ln -fs "$ghostty_source" "$ghostty_target"
print_success "$ghostty_target -> $ghostty_source"

# Copy binaries
print_info "Setting up bin scripts"
ln -fs $DOTFILES_DIR/bin $HOME

declare -a BINARIES=(
  'crlf'
  'git-delete-merged-branches'
)

for i in ${BINARIES[@]}; do
  echo "Setting permissions for :: ${i##*/}"
  chmod +rwx $HOME/bin/${i##*/}
done

#
# ZSH setup
#

install_zsh() {
  if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
    # Install zinit if not present
    if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
      print_info "Installing zinit..."
      bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    else
      print_success "zinit already installed"
    fi

    # Set zsh as default shell if it isn't already
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
      print_success "Default shell changed to zsh"
    else
      print_success "zsh is already the default shell"
    fi
  else
    platform=$(uname)
    if [[ $platform == 'Linux' ]]; then
      if [[ -f /etc/redhat-release ]]; then
        sudo yum install zsh
      elif [[ -f /etc/debian_version ]]; then
        sudo apt-get install zsh
      fi
      install_zsh
    elif [[ $platform == 'Darwin' ]]; then
      echo "Installing zsh via Homebrew..."
      brew install zsh
      install_zsh
    fi
  fi
}

install_zsh

# Reload zsh settings
print_info "Setup complete! Restart your terminal or run: source ~/.zshrc"
