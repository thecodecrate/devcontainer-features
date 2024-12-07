#!/bin/bash

# Simulate VS Code terminal by setting TERM_PROGRAM
export TERM_PROGRAM="vscode"

# Create the bash-aliases directory
mkdir -p "$PWD/.devcontainer/etc/bash-aliases"

# Create a test alias file
echo "alias testalias='echo Hello, World!'" > "$PWD/.devcontainer/etc/bash-aliases/test-aliases.sh"

# Reload RC
if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
    echo -e "$1" >> /etc/bash.bashrc
fi
if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
    echo -e "$1" >> /etc/zsh/zshrc
fi
