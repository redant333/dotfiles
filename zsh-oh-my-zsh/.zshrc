# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Plugins
plugins=(
sudo
wd
)

source $ZSH/oh-my-zsh.sh

#########################################################
# Configuration                                         #
#########################################################

# Disable shared history. This means that every terminal
# instance will have its own history.
unsetopt share_history

# This is needed to make the prompt work properly
setopt PROMPT_SUBST

# Current folder on the left side and Git branch on the right side
PROMPT='%{$fg_bold[red]%}ᗈ %{$reset_color%}%~%{$fg_bold[red]%} : %{$reset_color%}'
RPROMPT='%{$fg[white]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}'

# Give syntax highlighting abilities to less (needs source-highlight package)
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#########################################################
# Aliases                                               #
#########################################################

# Open serial port and save all output to ~/logs. Current user needs to be in dialout group.
alias picolog='picocom -b 115200 /dev/ttyUSB0 | tee ~/logs/`date +"%Y-%m-%d_%H-%M-%S"`.log'
alias picolog1='picocom -b 115200 /dev/ttyUSB1 | tee ~/logs/`date +"%Y-%m-%d_%H-%M-%S"`.log'

# Open the newest file from current directory in glogg
alias gllat='glogg *(.om[1])'

# Git
alias gcb='git symbolic-ref --short HEAD' # Current git branch

# Networking
alias int='echo -e "Local IP: $(hostname -I)\n" && ping 8.8.8.8' # Print IP and ping Google
alias iploc='curl ipinfo.io' # Print public IP and IP location. Useful when working with VPN

# General purpose
alias rc='vim ~/.zshrc'
alias op='xdg-open'
alias acs='apt-cache search'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias grepc='grep -r --include=\*.{c,cpp,cc}'
alias greph='grep -r --include=\*.{h,hpp,hh}'
alias -g G='| grep'
alias -g L="| less"
alias -g difftool="difftool --dir-diff"

# Simple calculator
function calculate {
	zmodload zsh/mathfunc
	result=$(($@))
	printf 'res: %s\ndec: %d\nhex: %X\n' "$result" "$result" "$result"
}
alias c='noglob calculate'
