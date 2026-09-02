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

# Catppuccin Mocha - zsh-syntax-highlighting styles
typeset -A ZSH_HIGHLIGHT_STYLES

# Commands & Aliases
ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa,bold'          # Blue
ZSH_HIGHLIGHT_STYLES[alias]='fg=#f5c2e7,bold'            # Pink
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#cba6f7,bold'          # Mauve
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa,bold'         # Blue

# Arguments, Options & Paths
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f9e2af'  # Yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f9e2af'  # Yellow
ZSH_HIGHLIGHT_STYLES[path]='fg=#a6e3a1,underline'        # Green
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#a6e3a1'           # Green
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#fab387'              # Peach

# Errors & Unknown Tokens
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'    # Red
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7'        # Mauve

# Modern CLI Replacements
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias tree="eza --tree --icons"
alias cat="bat"

# Shortcuts
alias reload="source ~/.zshrc"
alias c="clear"

eval "$(starship init zsh)"
