#!/bin/bash
INFO_TEXT="\e[36m"
WARN_TEXT="\e[33m"
NORMAL_TEXT="\e[m"

function inform() {
    echo -e "$INFO_TEXT $1 $NORMAL_TEXT"
}

function warn() {
    echo -e "$WARN_TEXT $1 $NORMAL_TEXT"
}

function install_dependencies() {
    dependencies_file="$1"

    inform "Installing dependencies from $dependencies_file, this requires sudo privileges"
    sed 's/#.*//' "$dependencies_file" | xargs sudo apt-get -y install
}

function install_link() {
    from=$1
    to=$2

    if [[ -L $to ]]; then
        inform "Found existing link $to while installing, replacing it"
        rm "$to"
    fi

    if [[ -e $to ]]; then
        backup_name="/tmp/$(basename "$to")_$(date +%Y-%m-%d_%H-%M-%S)"
        warn "Found existing $to, backing up as $backup_name and replacing"

        mv "$to" "$backup_name"
    fi

    ln -s "$(realpath "$from")" "$to"

    inform "$to installed"
}