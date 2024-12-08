#!/bin/zsh

set -euo pipefail

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Setup
source ./setup.sh

get_title() {
    local filename="$1"

    # Extract the base filename without extension
    title="$(basename "$file" .sh)"
    # Remove optional prefix: number and dash (e.g., "00-"), and "test-"
    title="${title#*[-]}"
    title="${title#test-}"
    # Replace non-alphanumeric characters with spaces
    title="$(echo "$title" | sed 's/[^a-zA-Z0-9]/ /g')"
    # Capitalize each word
    title="$(echo "$title" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"

    echo "$title"
}

# Run test cases
for file in ./cases/*.sh; do
    if [[ "$(basename "$file")" == "__before.sh" ]]; then
        continue
    fi

    source ./cases/__before.sh

    title="$(get_title "$file")"
    check "[$title]" zsh -i "$file"
done

# Report result
reportResults
