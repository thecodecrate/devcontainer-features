# Only runs on terminal from inside vscode editor
if [ -t 1 ] && [ "${TERM_PROGRAM}" = "vscode" ]; then
    export UV_CACHE_DIR="$PWD/.uv_cache"
    mkdir -p "$UV_CACHE_DIR"
fi
