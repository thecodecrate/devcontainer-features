#!/bin/zsh

set -euo pipefail

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Tests before removing aliases directory
check "directory exists" ls -lha "$ALIASES_DIR"
check "testalias exists" zsh -ic "command -v testalias"
check "testalias works" zsh -ic "testalias"
check "testalias result" zsh -ic "test \"\$(testalias)\" = 'Hello, World!'"

# Remove aliases directory
rm -rf "$ALIASES_DIR"

# Tests after removing aliases directory
check "directory should NOT exist" test ! -d "$ALIASES_DIR"
check "testalias should NOT exist" test ! -n "$(zsh -ic 'command -v testalias')"
