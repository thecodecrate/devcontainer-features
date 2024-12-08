#!/bin/zsh

set -euo pipefail

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Tests
check "testalias exists" command -v testalias
check "testalias works" echo "$(testalias)"
check "testalias result" test "$(testalias)" = 'Hello, World!'
