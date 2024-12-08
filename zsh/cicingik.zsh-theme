function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo '['`basename $VIRTUAL_ENV`'] '
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{${reset_color}%}%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}⚡%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

base_prompt="%{${reset_color}%}%F{magenta}%n%F{cyan}@%F{yellow}%m%F{red}:%F{cyan}%0~%F{red}|%f"
post_prompt="%{${reset_color}%}%F{cyan}%f"
venv_prompt='%{$fg[red]%}$(virtualenv_info)%{$reset_color%}%'

local nl=$'\n%{\r%}%F{cyan}⇒%f '


PROMPT="${venv_prompt} ${base_prompt}\$(git_prompt_info)${post_prompt} ${nl}"
unset venv_prompt base_prompt post_prompt
