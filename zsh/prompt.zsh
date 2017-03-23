# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT_SEGMENTS=(
  # Working directory, replace $HOME with ~
  '%{$fg[cyan]%}%~% %'
  # Color prompt based on last command's exit code
  '(?.%{$fg[green]%}.%{$fg[red]%})%B ❯%b '
)
PROMPT=${(j::)PROMPT_SEGMENTS}

# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✎%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_STASHED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_DIVERGED=""

ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{$fg[green]%}⇡"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX="%{$fg[red]%}⇣"
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%} "

function git_has_remote() {
  local branch=${1:-$(git_current_branch)}
  [[ -n $(command git show-ref origin/${branch} 2> /dev/null) ]]
}

function git_prompt() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  local prompt="$(parse_git_dirty)"
  local branch=$(git_current_branch)
  if git_has_remote $branch ; then
    prompt+="$(git_commits_ahead)$(git_commits_behind)"
  fi
  prompt+="$branch"

  echo $prompt
}

function rprompt_info() {
  local info=""
  local git_info="$(git_prompt)"
  if [[ $git_info ]]; then
    info+=" $git_info"
  fi
  local venv_info="$(virtualenv_prompt_info)"
  if [[ $venv_info ]]; then
    info+=" $venv_info"
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
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

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
