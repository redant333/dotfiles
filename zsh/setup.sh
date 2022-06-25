#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up zsh"
install_dependencies "$relative/deps.txt"

inform "Installing oh-my-zsh"
if [[ ! -d ~/.oh-my-zsh ]]; then
    export RUNZSH=no
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    inform "oh-my-zsh already installed"
fi

install_link "$relative/.zshrc" "$HOME/.zshrc"

GHI_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/ghi.zsh-theme
install_link "$relative/ghi.zsh-theme" "$GHI_PATH"