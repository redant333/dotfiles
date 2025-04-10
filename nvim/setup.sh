#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up nvim"
install_dependencies "$relative/deps.txt"

nvim_executable="$HOME/bin/nvim"

inform "Downloading nvim"
mkdir -p "$(dirname "$nvim_executable")"
wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage -linux-arm64.appimage -O "$nvim_executable"
chmod +x "$nvim_executable"

inform "Installing configuration"
install_link "$relative" "$HOME/.config/nvim"

nvim --headless +"Lazy install" +q
