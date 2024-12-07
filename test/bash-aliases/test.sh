#!/bin/bash

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Simulate VS Code terminal by setting TERM_PROGRAM
export TERM_PROGRAM="vscode"

# Create the bash-aliases directory
mkdir -p "$PWD/.devcontainer/etc/bash-aliases"

# Create a test alias file
echo "alias testalias='echo Hello, World!'" > "$PWD/.devcontainer/etc/bash-aliases/test-aliases.sh"

# Feature-specific tests
check "alias is loaded" bash -lc "alias testalias | grep 'echo Hello, World!'"
check "alias works" bash -lc "testalias | grep 'Hello, World!'"

# Test when there's no bash-aliases directory.
rm -rf "$PWD/.devcontainer/etc/bash-aliases"
check "no bash-aliases directory" bash -lc "echo 'No errors'"

# "testalias" alias should not be available anymore
check "alias is not loaded" bash -lc "alias testalias 2>&1 | grep 'not found'"

# Report result
reportResults