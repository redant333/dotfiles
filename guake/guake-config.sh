#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=../setup_utils.sh
source "$relative/../setup_utils.sh"

config_file="$relative/guake.conf"

if [[ $1 == 'save' ]]; then
    inform "Saving config to $config_file"
    guake --save-preferences "$config_file"
    inform "Config saved to $config_file"
elif [[ $1 == 'restore' ]]; then
    inform "Restoring config from $config_file"
    guake --restore-preferences "$config_file"
    inform "Config restored from $config_file"
else
    echo "guake-config.sh <save | restore>"
    exit 1
fi
