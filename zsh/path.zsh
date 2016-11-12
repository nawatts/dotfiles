PATHDIRS=(
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /opt/X11/bin
    /Applications/Xcode.app/Contents/Developer/Tools
    ./node_modules/.bin
    $HOME/bin
    $HOME/.yarn/bin
)
export PATH=${(j_:_)PATHDIRS}
