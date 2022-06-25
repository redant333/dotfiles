#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up VisualStudio Code"

install_dependencies "$relative/deps.txt"

# Installation instructions on https://code.visualstudio.com/docs/setup/linux
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

inform "Installing Microsoft GPG key, this requires sudo privileges"
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update

sudo apt install code

install_link "$relative/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
install_link "$relative/settings.json" "$HOME/.config/Code/User/settings.json"
