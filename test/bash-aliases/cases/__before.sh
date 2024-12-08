#!/bin/zsh

##
# This file runs before each test case.
##

# Exit on error
set -euo pipefail

# Create aliases directory
export ALIASES_DIR="$PWD/.devcontainer/etc/bash-aliases"
rm -Rf "$ALIASES_DIR" && mkdir -p "$ALIASES_DIR"
cp ./stubs/* "$ALIASES_DIR"
