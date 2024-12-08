#!/bin/bash

set -euo pipefail

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Info about the environment
check "Environment Info" echo "\
    PWD: $PWD\n\
    USER: $USER\n\
    HOME: $HOME\n\
    TERM_PROGRAM: $TERM_PROGRAM\n\
    CI: $CI\n\
    ALIASES_DIR: $ALIASES_DIR\n"

# Environment Vars
check "TERM_PROGRAM is vscode" test "$TERM_PROGRAM" = "vscode"
check "CI is true" test "$CI" = "true"
check "ALIASES_DIR is set" test -n "$ALIASES_DIR"

# Aliases directory
check "aliases directory" ls -lha "$ALIASES_DIR"
check "testalias.sh" cat "$ALIASES_DIR/testalias.sh"
