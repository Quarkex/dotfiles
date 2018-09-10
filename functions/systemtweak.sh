function systemtweak {(
    echo "installing system custom software...";
    sudo apt-get install \
    awesome \
    xfe \
    sshfs \
    vim \
    gpm \
    cmus \
    texlive \
    python-pip \
    youtube-dl \
    sox \
    libsox-fmt-mp3 \
    flac \
    id3v2 \
    imagemagick \
    pdftk \
    lynx \
    zip \
    apache2 \
    mysql-server \
    phpmyadmin \
    git \
    kpcli libterm-readline-gnu-perl libdata-password-perl \
    wicd-curses \
    wakeonlan \
    cifs-utils \
    alsa alsa-tools \
    googlecl
    echo "done\n"

    echo "cleaning system"
    sudo apt-get autoremove;
    sudo apt-get -o APT::Clean-Installed="false" autoclean;

    #leave a minimal xsession ready to launch
    if [ ! -f "$HOME/.xinitrc.disabled" ]; then
        echo "xterm & awesome" > "$HOME/.xinitrc.disabled"
    fi

    #who can work without music? leave it to google.
    echo "installing Google Music API (unnificial) and GMusicFS..."
    sudo pip install https://github.com/terencehonles/fusepy/tarball/master
    sudo pip install https://github.com/simon-weber/Unofficial-Google-Music-API/tarball/develop
    sudo pip install https://github.com/EnigmaCurry/GMusicFS/tarball/master

    if [ ! -f "$HOME/.gmusicfs" ]; then
        echo "adding .gmusicfs file in home directory...";
        echo "[credentials]" > "$HOME/.gmusicfs";
        echo "username = your_username@gmail.com" >> "$HOME/.gmusicfs";
        echo "password = your_password" >> "$HOME/.gmusicfs";
        echo "deviceId = your_mobile_id" >> "$HOME/.gmusicfs";
        chmod 600 "$HOME/.gmusicfs";
    fi
    if [ ! -d "/mnt/gmusicfs" ]; then
        echo "adding gmusicfs folder in mnt directory...";
        sudo mkdir /mnt/gmusicfs
        sudo chmod 777 "/mnt/gmusicfs";
    fi
    sudo addgroup $USER fuse; #just to be sure you can actually use fuse
    sudo addgroup $USER audio;#just to be sure you can actually play sound
    echo "done."


)}
