#!/usr/bin/env zsh

DOTFILES=${0:a:h}

# Prompt for confirmation before overwriting files
echo "\e[38;5;160mWarning! This script will overwrite the following files:\e[0m"
for source in $(find -H $DOTFILES -name '*.link'); do
  dest="$HOME/.${source:t:r}"
  echo "$dest"
done
read -q "REPLY?Are you sure you want to continue (y|n)?"
echo ""
if [[ $REPLY != "y" ]]; then
  echo "Canceled"
  exit 1
fi

# Link dotfiles to home directory
for source in $(find -H $DOTFILES -name '*.link'); do
  dest="$HOME/.${source:t:r}"
  rm -rf "$dest"
  ln -s "$source" "$dest"
  echo "link $source to $dest"
done

# Install Atom packages
while read pkg; do
  apm install "$pkg"
done < "${DOTFILES}/atom.link/installed-packages.txt"
