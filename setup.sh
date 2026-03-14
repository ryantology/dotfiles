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

dir_backup=~/dotfiles_old

# Symlink a file, backing up any existing non-symlink target
symlink() {
  local source="$1"
  local target="$2"

  # Ensure target directory exists
  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    print_success "$target (already linked)"
  elif [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup_name=$(echo "$target" | sed "s|$HOME/||; s|/|-|g; s|^\.||")
    mv "$target" "$dir_backup/$backup_name"
    ln -fs "$source" "$target"
    print_success "$target -> $source (backed up original)"
  else
    [ -L "$target" ] && rm "$target"
    ln -fs "$source" "$target"
    print_success "$target -> $source"
  fi
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

# Create backup directory
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~..."
mkdir -p $dir_backup
echo "done"

#
# Dotfiles -> ~/.dotfile (dot-prefixed in home directory)
#

print_info "Symlinking dotfiles"

declare -a DOTFILES=(
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

for i in ${DOTFILES[@]}; do
  symlink "$DOTFILES_DIR/$i" "$HOME/.${i##*/}"
done

#
# App configs -> specific locations
#

print_info "Symlinking app configs"

# Ghostty
symlink "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# Claude Code
declare -a CLAUDE_FILES=(
  'settings.json'
  'CLAUDE.md'
  'review-style.md'
)

for f in ${CLAUDE_FILES[@]}; do
  symlink "$DOTFILES_DIR/claude/$f" "$HOME/.claude/$f"
done

symlink "$DOTFILES_DIR/claude/commands" "$HOME/.claude/commands"

#
# Bin scripts
#

print_info "Setting up bin scripts"
ln -fs $DOTFILES_DIR/bin $HOME

for i in crlf git-delete-merged-branches; do
  chmod +rwx $HOME/bin/$i
  print_success "$HOME/bin/$i (executable)"
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

print_info "Setup complete! Restart your terminal or run: source ~/.zshrc"
