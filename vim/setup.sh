#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up vim"

install_dependencies "$relative/deps.txt"
install_link "$relative/.vimrc" "$HOME/.vimrc"

# Install plugins
vim +'PlugInstall --sync' +qa
