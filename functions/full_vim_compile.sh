#! /bin/bash

# Description:
#   Compile a full-featured Vim from source on Ubuntu/Debian distros. Based
#   entirely on
#   https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# Use:
#   ./compile_full_vim.sh

full_vim_compile(){
    echo "y" | sudo apt-get remove \
        vim \
        vim-runtime \
        gvim \
        vim-tiny \
        vim-common \
        vim-gui-common
    echo "y" | sudo apt-get install \
        git \
        libncurses5-dev \
        libgnome2-dev \
        libgnomeui-dev \
        libgtk2.0-dev \
        libatk1.0-dev \
        libbonoboui2-dev \
        libcairo2-dev \
        libx11-dev \
        libxpm-dev \
        libxt-dev \
        python-dev ruby-dev \
        mercurial

    cd ~
    git clone https://github.com/vim/vim.git .vim-src
    cd .vim-src
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim81
    sudo checkinstall
}
