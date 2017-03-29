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
    $HOME/.nodenv/bin
    $HOME/.yarn/bin
    ./node_modules/.bin
)
export PATH=${(j_:_)PATHDIRS}
