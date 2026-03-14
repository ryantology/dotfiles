# Dotfiles

Personal dotfiles for configuring macOS with Zsh and Homebrew.

Originally based on [nicksp/dotfiles](https://github.com/nicksp/dotfiles), modernized for current macOS and tooling.

## What's included

- [Zsh config](shell/zshrc) with [zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- [Shell aliases](shell/shell_aliases) and [functions](shell/shell_functions)
- [Git config](git/gitconfig) with aliases and diff-so-fancy
- [Ghostty](ghostty/config) terminal configuration
- [macOS defaults](osx/set-defaults.sh) for sensible system settings
- [Homebrew](install/brew.sh) and [cask](install/brew-cask.sh) package lists
- Handy [bin scripts](bin/)

## Requirements

- macOS (Apple Silicon or Intel)
- Zsh (the install script will set it up)

## Installation

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

For a fresh machine, use the full setup guide:

```sh
# Copy and run sections from setup-new-machine.sh one at a time
cat ~/dotfiles/setup-new-machine.sh
```

## Customization

### Local overrides

These files are gitignored and loaded automatically if present:

- **`~/.zsh.local`** - Extra shell config, PATH additions, machine-specific settings
- **`~/.gitconfig.local`** - Git user credentials and machine-specific git config:

```ini
[user]
  name = Your Name
  email = you@example.com
```

## Modern CLI tools

The brew install includes modern replacements for common tools:

| Classic | Modern | Description |
|---------|--------|-------------|
| `cat` | `bat` | Syntax-highlighted file viewing |
| `find` | `fd` | Faster, friendlier file finding |
| `grep` | `ripgrep` (`rg`) | Faster recursive search |
| `cd` | `zoxide` | Smart directory jumping (learns your habits) |
| `ls` | `eza` | Modern file listing with git status |

## License

[MIT](LICENSE)
