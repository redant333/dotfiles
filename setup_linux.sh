#!/bin/bash
set -e

relative=$(dirname "$0")
# shellcheck source=./setup_utils.sh
source "$relative/setup_utils.sh"

# Collect setups
setups=()
for setup in "$relative"/*/setup.sh
do
    if yesno "Run $setup?"; then
        inform "$setup selected"
        setups+=("$setup")
    fi
done

# Check setups
echo
inform "Will run these setups:"
for setup in "${setups[@]}"
do
   inform "> $setup"
done

if ! yesno "Do you want to continue?"; then
    return 1
fi

# Run setups
for setup in "${setups[@]}"
do
   $setup
done
