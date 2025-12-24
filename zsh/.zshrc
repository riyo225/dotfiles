# --- Load Shared Settings ---
[ -f ~/dotfiles/common/path ] && source ~/dotfiles/common/path
[ -f ~/dotfiles/common/aliases ] && source ~/dotfiles/common/aliases

# --- Custom Prompt for Zsh ---
PROMPT='%F{cyan}%n%f@%F{blue}%m%f %F{cyan}%~%f %# '
