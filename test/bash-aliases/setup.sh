#!/bin/bash

set -euo pipefail

# Simulate VS Code terminal and CI environment
export TERM_PROGRAM="vscode"
export CI="true"
