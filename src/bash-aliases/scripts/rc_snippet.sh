# Only runs on terminal from inside vscode editor
if [ -t 1 ] && [ "${TERM_PROGRAM}" = "vscode" ]; then
    ALIASES_FOLDER="$PWD/.devcontainer/etc/bash-aliases"

    # Dynamically load all *.sh files from ALIASES_FOLDER
    if [ -d "$ALIASES_FOLDER" ]; then
        for file in "$ALIASES_FOLDER/"*.sh; do
            if [ -e "$file" ] && [ -r "$file" ]; then
                source "$file"
            fi
        done
    fi
fi
