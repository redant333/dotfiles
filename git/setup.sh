#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up git"
install_dependencies "$relative/deps.txt"

echo "Enter email for .gitconfig:"
read -r email
sed -i "s/#email#/$email/" "$relative/.gitconfig"

install_link "$relative/.gitconfig" "$HOME/.gitconfig"
