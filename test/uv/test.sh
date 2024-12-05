#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'uv' feature with default options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "uv installed" bash -c "uv --version"

# Report result
reportResults
