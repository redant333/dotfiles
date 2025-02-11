#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up fiddle"

mkdir -p ~/bin
install_link "$relative/fiddle" "$HOME/bin/fiddle"

