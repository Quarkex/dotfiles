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

if [[ -d $HOME/Plantillas && ! -L $HOME/Plantillas ]]; then
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

# Hook ssh config file
if [ ! -d ~/.ssh ];        then mkdir ~/.ssh;        fi
if [ ! -f ~/.ssh/config ]; then touch ~/.ssh/config; fi
grep "Include ~/.dotfiles/ssh/config" ~/.ssh/config &>/dev/null
if [ ! $? -eq 0 ]; then
    echo -e "Include ~/.dotfiles/ssh/config\n$(cat ~/.ssh/config)" \
        >~/.ssh/config
fi

# Hook bash_profile
if [ ! "$(tail -n 4 $HOME/.bash_profile | head -n 1)" == "# Load personal bash_profile" ];
then echo '

# Load personal bash_profile
if [ -f ~/.dotfiles/bash_profile ]; then
    . ~/.dotfiles/bash_profile
fi'>>$HOME/.bash_profile
fi

# Hook bashrc
if [ ! "$(tail -n 4 $HOME/.bashrc | head -n 1)" == "# Load personal bashrc" ];
then echo '

# Load personal bashrc
if [ -f ~/.dotfiles/bashrc ]; then
    . ~/.dotfiles/bashrc
fi'>>$HOME/.bashrc
fi

