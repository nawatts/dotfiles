# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT_SEGMENTS=(
  # Working directory, replace $HOME with ~
  '%{$fg[cyan]%}%~% %'
  # Color prompt based on last command's exit code
  '(?.%{$fg[green]%}.%{$fg[red]%})%B ❯%b '
)
PROMPT=${(j::)PROMPT_SEGMENTS}

# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✎%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▹%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_STASHED=""
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_DIVERGED=""


ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{$fg[green]%}⇡"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%} "

ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX="%{$fg[red]%}⇣"
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%} "

function git_prompt() {
  echo "$(git_commits_ahead)$(git_commits_behind)$(git_prompt_status)$(git_current_branch)"
}

function rprompt_info() {
  local info=""
  local git_info="$(git_prompt)"
  if [[ $git_info ]]; then
    info="${info} $git_info"
  fi
  local venv_info="$(virtualenv_prompt_info)"
  if [[ $venv_info ]]; then
    info="$info $venv_info"
  fi
  echo $info
}

# ZSH line editing mode
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://dougblack.io/words/zsh-vi-mode.html
bindkey -v

# `zle -la` lists all available commands
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

setopt prompt_subst
precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
  VIM_CMD_PROMPT="%{$fg[blue]%}cmd%{$reset_color%}"
  VIM_INS_PROMPT="%{$fg[blue]%}ins%{$reset_color%}"
  RPROMPT="${${KEYMAP/vicmd/$VIM_CMD_PROMPT}/(main|viins)/$VIM_INS_PROMPT}$(rprompt_info)"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1
