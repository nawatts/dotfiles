# dotfiles

## Getting started

1. Set the `DOTFILES` variable in `./zsh/zshrc.link` to the path of the
   directory containing this repository.
2. Run `./setup.zsh` to link files into home directory.
   Any file/directory ending with `.link` will be linked.
   `<name>.link` will be linked to `~/.<name>`.

## Additional setup

Additional steps are required for some applications.

### iTerm2

Load [iTerm2](https://www.iterm2.com/) preferences from dotfiles directory:

1. Open iTerm2 preferences
2. Switch to General tab
3. Check "Load preferences from a custom folder or URL"
4. Enter "~/.iterm2" for the custom folder

[Cousine font](https://fonts.google.com/specimen/Cousine)
