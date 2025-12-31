# --- Load Shared Settings ---
[ -f ~/dotfiles/common/path ] && source ~/dotfiles/common/path
[ -f ~/dotfiles/common/aliases ] && source ~/dotfiles/common/aliases


# -- Zsh Efficiency Settings ---
# Automatically 'cd' into a directory just by typing its name
setopt auto_cd
# Spelling correction for commands (e.g., 'mkae' -> 'make')
setopt correct


# --- Git branch information ---
autoload -Uz vcs_info
setopt PROMPT_SUBST
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'


# --- Prompt configuration ---
PROMPT='%F{cyan}%n%f@%F{blue}%m%f:%F{cyan}%~%f${vcs_info_msg_0_} %# '
