#!/usr/bin/env bash

set -e # Exit immediately if a command fails

DOTFILES_DIR="$HOME/Development/dotfiles"

echo "🚀 Starting dotfiles installation..."

# 1. Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to PATH for Apple Silicon Macs during install run
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "🍺 Homebrew already installed."
fi

# 2. Install all CLI tools, apps, and VS Code extensions from Brewfile
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
    echo "📦 Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# 3. Clone Oh My Zsh custom plugins if missing
echo "🔌 Setting up Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 4. Create necessary parent directories
echo "📁 Creating config directories..."
mkdir -p ~/.config/starship
mkdir -p ~/.config/herdr
mkdir -p ~/.config/mise
mkdir -p "$HOME/Library/Application Support/Code/User"

# 5. Create Symlinks
echo "🔗 Creating symlinks..."

# Zsh & Starship
[ -f "$DOTFILES_DIR/zshrc" ] && ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
[ -f "$DOTFILES_DIR/starship/starship.toml" ] && ln -sf "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship/starship.toml

# Git
[ -f "$DOTFILES_DIR/gitconfig" ] && ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig

# Neovim
if [ -d "$DOTFILES_DIR/nvim" ]; then
    rm -rf ~/.config/nvim
    ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim
fi

# Herdr
[ -f "$DOTFILES_DIR/herdr/config.toml" ] && ln -sf "$DOTFILES_DIR/herdr/config.toml" ~/.config/herdr/config.toml

# Mise
[ -f "$DOTFILES_DIR/mise/config.toml" ] && ln -sf "$DOTFILES_DIR/mise/config.toml" ~/.config/mise/config.toml

# VS Code
[ -f "$DOTFILES_DIR/vscode/settings.json" ] && ln -sf "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
[ -f "$DOTFILES_DIR/vscode/keybindings.json" ] && ln -sf "$DOTFILES_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

# 6. Create .hushlogin to suppress 'Last login' banner
touch ~/.hushlogin

echo "✅ Setup complete! Reload your shell with: exec zsh"
