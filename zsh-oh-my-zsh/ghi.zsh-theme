setopt PROMPT_SUBST

PROMPT_SYMBOL="ᗈ"

# Current folder on the left side and Git branch on the right side
PROMPT='%{$fg_bold[red]%}${PROMPT_SYMBOL} %{$reset_color%}%~%{$fg_bold[red]%} : %{$reset_color%}'
RPROMPT='%{$fg[white]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}'