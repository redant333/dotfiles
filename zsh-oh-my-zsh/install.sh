#!/bin/bash

GREEN_TEXT="\e[32m"
NORMAL_TEXT="\e[m"

# Check if root
if [[ $EUID -eq 0 ]]; then
   echo "This script is not intended to be run as root. It will ask for password when installing packages."
   exit 1
fi

# Install dependencies
echo -e $GREEN_TEXT "\n> Installing/updating Zsh" $NORMAL_TEXT
sudo apt install zsh

echo -e $GREEN_TEXT "\n> Installing/updating Git" $NORMAL_TEXT
sudo apt install git

echo -e $GREEN_TEXT "\n> Installing/updating wget" $NORMAL_TEXT
sudo apt install wget

echo -e $GREEN_TEXT "\n> Installing/updating source-highlight" $NORMAL_TEXT
sudo apt install source-highlight

# Download oh-my-zsh
echo -e $GREEN_TEXT "\n> Installing oh-my-zsh" $NORMAL_TEXT
export RUNZSH=no
export CHSH=yes
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



