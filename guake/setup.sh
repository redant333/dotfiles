#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

inform "Setting up Guake"
install_dependencies "$relative/deps.txt"
"$relative/guake-config.sh" restore

inform "Guake toggle hotkey cannot be set to Win + anything on Gnome. If you want that, set a global hotkey with this command:"
inform "dbus-send --type=method_call --dest=org.guake3.RemoteControl /org/guake3/RemoteControl org.guake3.RemoteControl.show_hide"
inform "More info on https://github.com/Guake/guake/issues/1076"
