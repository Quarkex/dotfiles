#!/bin/bash

for dir in \
    .ssh \
    .local \
    workbench \
    forge \
    vault \
; do
    if [ ! -d $HOME/$dir ]; then
        mkdir -p $HOME/$dir
    fi
done

if [ -d $HOME/Plantillas ]; then
    rmdir $HOME/Plantillas
    ln -s $HOME/.dotfiles/plantillas $HOME/Plantillas
fi

if [ ! -f $HOME/.ssh/config ]; then
    scp -r -P 42 $USER@atanor.dev:.ssh/* $HOME/.ssh/.
fi

sudo apt install \
    build-essential \
    cowsay \
    curl \
    fortune \
    git \
    htop \
    lynx \
    rename \
    tmux \
    wget \
-y

if [ ! -d $HOME/.dotfiles ]; then
    git clone "git@git.atanor.dev:quarkex/dotfiles.git" \
        $HOME/.dotfiles --recurse-submodules
fi

sudo cp $HOME/.dotfiles/tmux.conf /etc/tmux.conf

for file in \
    vim \
    vimrc \
    lynxrc \
    gitconfig \
    Xdefaults \
    Xresources \
; do
    if [ ! -e $HOME/".$file" ]; then
        ln -s $HOME/.dotfiles/"$file" $HOME/".$file"
    fi
done

if [ ! "$(tail -n 4 $HOME/.bashrc | head -n 1)" == "# Load personal bashrc" ];
then echo '

# Load personal bashrc
if [ -f ~/.dotfiles/bashrc ]; then
    . ~/.dotfiles/bashrc
fi'>>$HOME/.bashrc
fi
