#!/usr/bin/env bash

UPDATE_RC="${UPDATE_RC:-"true"}"

set -eux
export DEBIAN_FRONTEND=noninteractive

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
        if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/bash.bashrc
        fi
        if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/zsh/zshrc
        fi
    fi
}

# Bash-aliases loader
SNIPPET_CONTENT=$(cat <<'EOF'
# Only runs on terminal from inside the vscode editor
if [ -t 1 ] && [ "${TERM_PROGRAM}" = "vscode" ]; then
    ALIASES_FOLDER="$PWD/.devcontainer/etc/bash-aliases"

    # Dynamically load all *.sh files from ALIASES_FOLDER
    if [ -d "$ALIASES_FOLDER" ]; then
        for file in "$ALIASES_FOLDER/"*.sh; do
            if [ -e "$file" ] && [ -r "$file" ]; then
                source "$file"
            fi
        done
    fi
fi
EOF
)

# Install loader
echo "Installing Loader..."
updaterc "${SNIPPET_CONTENT}"

echo "Done!"
