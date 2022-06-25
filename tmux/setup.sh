#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up tmux"

install_dependencies "$relative/deps.txt"

inform "Installing tmux-picker"
if [[ ! -d ~/.tmux/tmux-picker ]]; then
    mkdir -p ~/.tmux
    git clone https://github.com/pawel-wiejacha/tmux-picker ~/.tmux/tmux-picker
else
    inform "tmux-picker already installed"
fi

install_link "$relative/.tmux.conf" "$HOME/.tmux.conf"