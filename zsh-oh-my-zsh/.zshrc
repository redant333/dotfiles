# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
sudo
wd
)

source $ZSH/oh-my-zsh.sh
# Disable shared history. Maybe I'll enable it again at some point.
unsetopt share_history

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# This is needed to make the prompt work properly
setopt PROMPT_SUBST

# Current folder on the left side and Git branch on the right side
PROMPT='%{$fg_bold[red]%}ᗈ %{$reset_color%}%~%{$fg_bold[red]%} : %{$reset_color%}'
RPROMPT='%{$fg[white]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}'

# Give syntax highlighting abilities to less (needs source-highlight package)
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

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

function calculate {
	zmodload zsh/mathfunc
	result=$(($@))
	printf 'res: %s\ndec: %d\nhex: %X\n' "$result" "$result" "$result"
}
alias c='noglob calculate'
