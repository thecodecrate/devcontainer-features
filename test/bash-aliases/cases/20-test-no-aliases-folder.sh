#!/bin/bash

set -euo pipefail

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Tests before removing aliases directory
check "directory exists" bash -ic "test -d '$ALIASES_DIR'"
check "testalias exists" bash -ic 'command -v testalias'
check "testalias works" bash -ic 'testalias'
check "testalias result" bash -ic 'test "$(testalias)" = "Hello, World!"'

# Remove aliases directory
rm -rf "$ALIASES_DIR"

# Tests after removing aliases directory
check "directory should NOT exist" bash -ic "test ! -f '$ALIASES_DIR'"
check "testalias should NOT exist" bash -ic 'test ! "$(command -v testalias)"'
