PROMPT='%{$fg[cyan]%}[%~% ]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '

ZSH_PROMPT_BASE_COLOR="%{$reset_color%}"

# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✎%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒%{$reset_color%}"

ZSH_THEME_BRANCH_NAME_COLOR="%{$fg[white]%}"

function git_prompt() {
  echo "$(git_prompt_status)%{$reset_color%} $(git_current_branch)"
}

function rprompt_info() {
  local info="$(git_prompt)"
  local venv_info=$(virtualenv_prompt_info)
  if [[ $venv_info ]]; then
    info="$info $venv_info"
  fi
  echo $info
}

RPROMPT='$(rprompt_info)'

setopt prompt_subst
