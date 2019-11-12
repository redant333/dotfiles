#!/bin/bash

GREEN_TEXT="\e[32m"
NORMAL_TEXT="\e[m"
RED_BACKGROUND="\e[30;41m"

# Check if on Ubunt 18.04
if [[ "$(lsb_release -is)" != "Ubuntu" ]] || [[ "$(lsb_release -rs)" != "18.04" ]]; then
    echo -e $RED_BACKGROUND"\n\n WARNING: HERE BE DRAGONS!\n"$NORMAL_TEXT
    echo ""
    echo "A bit dramatic warning, I agree. But, seriously, I have only tested this script on Ubuntu 18.04."
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
export RUNZSH=no
export CHSH=yes
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Download the theme and put it into oh-my-zsh
echo -e $GREEN_TEXT"\n> Installing Ghi theme"$NORMAL_TEXT
GHI_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/ghi.zsh-theme
GHI_URL="https://raw.githubusercontent.com/redant333/dotfiles/master/zsh-oh-my-zsh/ghi.zsh-theme"
curl $GHI_URL > $GHI_PATH
echo -e $GREEN_TEXT"\n> Ghi theme installed to $GHI_PATH"$NORMAL_TEXT

# Download .zshrc
RC_PATH=~/.zshrc
RC_URL="https://raw.githubusercontent.com/redant333/dotfiles/master/zsh-oh-my-zsh/.zshrc"
curl $RC_URL > $RC_PATH
echo -e $GREEN_TEXT"\n> .zshrc installed to $RC_PATH"$NORMAL_TEXT

