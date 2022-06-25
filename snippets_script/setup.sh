#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up snipp"
install_dependencies "$relative/deps.txt"

mkdir -p ~/bin
install_link "$relative/snipp" "$HOME/bin/snipp"
