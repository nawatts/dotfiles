PATHDIRS=(
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /opt/X11/bin
    /Applications/Xcode.app/Contents/Developer/Tools
    $DOTFILES/bin
    $HOME/.yarn/bin
    ./node_modules/.bin
    $HOME/.nodenv/bin
)
export PATH=${(j_:_)PATHDIRS}
