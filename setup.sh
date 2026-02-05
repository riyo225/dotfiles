#!/bin/bash

DOT_DIRECTORY="$HOME/dotfiles"
SUCCESS=true

echo "Starting dotfiles setup..."

link_file() {
	local src="$1"
	local target="$2"

	mkdir -p "$(dirname "$target")"

	if ln -sfn "$src" "$target"; then
		echo "Linked: $target -> $src"
	else 
		echo "Error: Failed to link $target" >&2
		SUCCESS=false
	fi
}

link_file "$DOT_DIRECTORY/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOT_DIRECTORY/bash/.bashrc" "$HOME/.bashrc"
link_file "$DOT_DIRECTORY/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOT_DIRECTORY/nvim" "$HOME/.config/nvim"

if [ "$SUCCESS" = true ]; then
	echo "--------------------------------"
	echo "Setup completed successfully!"
else
	echo "--------------------------------"
	echo "Setup failed with some errors. Please check the messages above."
	exit 1
fi
