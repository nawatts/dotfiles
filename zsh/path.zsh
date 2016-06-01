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
    $(npm -g root)
    $HOME/bin
)
export PATH=${(j_:_)PATHDIRS}
