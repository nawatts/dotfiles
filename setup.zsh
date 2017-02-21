#!/usr/bin/env zsh

DOTFILES=${0:a:h}

# Prompt for confirmation before overwriting files
echo "\e[38;5;160mWarning! This script will overwrite the following files:\e[0m"
for source in $(find -H $DOTFILES -name '*.link'); do
  dest="$HOME/.${source:t:r}"
  if [[ -e "$dest" ]]; then
    echo "$dest"
  fi
done
read -q "REPLY?Are you sure you want to continue (y|n)?"
echo ""
if [[ $REPLY != "y" ]]; then
  echo "Canceled"
  exit 1
fi

# Install zplug
# https://github.com/zplug/zplug
export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d "${ZPLUG_HOME}" ]]; then
  git clone "https://github.com/zplug/zplug" "${ZPLUG_HOME}"
fi

# Link dotfiles to home directory
for source in $(find -H $DOTFILES -name '*.link'); do
  dest="$HOME/.${source:t:r}"
  rm -rf "$dest"
  ln -s "$source" "$dest"
  echo "link $source to $dest"
done

# Install zplug managed libraries/plugins
source "$HOME/.zshrc"
zplug install

# Install Atom packages
if [[ -x "$(command -v apm)" ]]; then
  apm install --packages-file "${DOTFILES}/atom.link/installed-packages.txt"
fi

# Install Vundle
mkdir -p "$HOME/.vim/bundle"
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"
fi
vim +PluginInstall +qall
