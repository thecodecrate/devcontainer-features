#!/usr/bin/env bash

VERSION="${VERSION:-"latest"}"
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"
UPDATE_RC="${UPDATE_RC:-"true"}"
UV_INSTALL_DIR="${UV_INSTALL_DIR:-"~/.local/bin"}"

FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -eux
export DEBIAN_FRONTEND=noninteractive

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Ensure that login shells get the correct path if the user updated the PATH using ENV.
rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh

# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
        if id -u "${CURRENT_USER}" > /dev/null 2>&1; then
            USERNAME="${CURRENT_USER}"
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi

updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
        if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/bash.bashrc
        fi
        if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/zsh/zshrc
        fi
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Install UV if it's missing
if ! uv --version &> /dev/null ; then
    # Install dependencies
    check_packages curl unzip tar ca-certificates

    rc_content="$(cat "${FEATURE_DIR}/scripts/rc_snippet.sh")"
    updaterc "${rc_content}"

    mkdir -p $UV_INSTALL_DIR
    chown -R "${USERNAME}:${USERNAME}" "${UV_INSTALL_DIR}"
    chmod -R g+r+w "${UV_INSTALL_DIR}"
    find "${UV_INSTALL_DIR}" -type d -print0 | xargs -n 1 -0 chmod g+s

    echo "Installing UV..."

    UV_VERSION=$VERSION
    if [ "${VERSION}" = "latest" ] || [ "${VERSION}" = "lts" ]; then
        UV_VERSION=""
    fi

    UV_URL="https://astral.sh/uv/install.sh"
    if [ "${UV_VERSION}" != "" ]; then
        UV_URL="https://astral.sh/uv/$UV_VERSION/install.sh"
    fi

    su --login -c "export http_proxy=${http_proxy:-} && export https_proxy=${https_proxy:-} \
        && curl -LsSf https://astral.sh/uv/install.sh --output /tmp/uv-install.sh \
        && export UV_INSTALL_DIR=${UV_INSTALL_DIR} \
        && /bin/bash /tmp/uv-install.sh --quiet" ${USERNAME} 2>&1

    if [ "${VERSION}" = "latest" ] || [ "${VERSION}" = "lts" ]; then
        PATH=$PATH:${UV_INSTALL_DIR}/bin
        su --login -c "uv self update" ${USERNAME} 2>&1
    fi

    rm /tmp/uv-install.sh
fi

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
