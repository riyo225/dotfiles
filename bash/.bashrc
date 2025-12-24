# ~/.bashrc

# --- If not running interactively, don't do anything ---
case $- in
    *i*) ;;
      *) return;;
esac

# --- History settings ---
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# --- Update window size after each command ---
shopt -s checkwinsize

# --- Enable programmable completion features ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi

# --- Load Shared Settings ---
[ -f ~/dotfiles/common/path ] && source ~/dotfiles/common/path
[ -f ~/dotfiles/common/aliases ] && source ~/dotfiles/common/aliases

# --- Custom Prompt for Bash ---
export PS1='\[\e[31m\]\u\[\e[0m\]@\[\e[35m\]\h\[\e[0m\]:\[\e[31m\]\w\[\e[0m\]\$ '
