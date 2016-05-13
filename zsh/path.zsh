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
    /Applications/Postgres.app/Contents/Versions/latest/bin
)
export PATH=${(j_:_)PATHDIRS}
