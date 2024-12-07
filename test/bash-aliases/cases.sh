#!/bin/bash

# Feature-specific tests
check "alias is loaded" alias testalias | grep 'echo Hello, World!'
check "alias works" testalias | grep 'Hello, World!'

# Test when there's no bash-aliases directory.
# rm -rf "$PWD/.devcontainer/etc/bash-aliases"
# check "no bash-aliases directory" bash -ic "echo 'No errors'"

# "testalias" alias should not be available anymore
# check "alias is not loaded" bash -ic "alias testalias 2>&1 | grep 'not found'"
