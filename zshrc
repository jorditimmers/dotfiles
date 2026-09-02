autoload -Uz compinit && compinit -u

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  z
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

echo "Welcome back, $(whoami)! 🚀"

# Modern CLI Replacements
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias tree="eza --tree --icons"
alias cat="bat"

# Shortcuts
alias reload="source ~/.zshrc"
alias c="clear"

eval "$(starship init zsh)"
