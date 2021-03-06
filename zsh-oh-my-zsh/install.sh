#!/bin/bash

GREEN_TEXT="\e[32m"
NORMAL_TEXT="\e[m"
RED_TEXT="\e[31m"

set -e

# Check if on Ubuntu 18
if [[ "$(lsb_release -is)" != "Ubuntu" ]] || [[ "$(lsb_release -rs)" != 18.* ]]; then
    echo -e "$RED_TEXT█████████████████████████████$NORMAL_TEXT"
    echo -e "$RED_TEXT█$NORMAL_TEXT WARNING: HERE BE DRAGONS! $RED_TEXT█$NORMAL_TEXT"
    echo -e "$RED_TEXT█████████████████████████████$NORMAL_TEXT"
    echo ""
    echo "A bit dramatic warning, I agree. But, seriously, I have only tested this script on Ubuntu 18."
    echo "The script might make some assumptions about your OS/package manager/setup that are not true."
    echo "Please check the script content and make sure it is not doing anything problematic."
    echo ""
    read -n1 -r -p "Press any key to continue or Ctrl+C to cancel..."
fi

# Check if root
if [[ "$EUID" == "0" ]]; then
   echo "This script is not intended to be run as root. It will ask for password when installing packages."
   exit 1
fi

# # Install dependencies
echo -e $GREEN_TEXT"\n> Installing/updating Zsh"$NORMAL_TEXT
sudo apt install zsh

echo -e $GREEN_TEXT"\n> Installing/updating Git"$NORMAL_TEXT
sudo apt install git

echo -e $GREEN_TEXT"\n> Installing/updating wget"$NORMAL_TEXT
sudo apt install wget

echo -e $GREEN_TEXT"\n> Installing/updating source-highlight"$NORMAL_TEXT
sudo apt install source-highlight

# Download oh-my-zsh
echo -e $GREEN_TEXT"\n> Installing oh-my-zsh"$NORMAL_TEXT
if [[ ! -d ~/.oh-my-zsh ]]; then
    export RUNZSH=no
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo -e $GREEN_TEXT"\n> oh-my-zsh already installed"$NORMAL_TEXT
fi

# Download the theme and put it into oh-my-zsh
echo -e $GREEN_TEXT"\n> Installing Ghi theme"$NORMAL_TEXT
GHI_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/ghi.zsh-theme
GHI_URL="https://raw.githubusercontent.com/redant333/dotfiles/master/zsh-oh-my-zsh/ghi.zsh-theme"
wget -O $GHI_PATH $GHI_URL
echo -e $GREEN_TEXT"\n> Ghi theme installed to $GHI_PATH"$NORMAL_TEXT

# Download .zshrc
RC_PATH=~/.zshrc
RC_URL="https://raw.githubusercontent.com/redant333/dotfiles/master/zsh-oh-my-zsh/.zshrc"
wget -O $RC_PATH $RC_URL
echo -e $GREEN_TEXT"\n> .zshrc installed to $RC_PATH"$NORMAL_TEXT

# Done
echo -e $GREEN_TEXT"\n> All done, you can start zsh now"$NORMAL_TEXT