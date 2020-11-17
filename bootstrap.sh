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
    wget \
    tar \
    libevent-dev \
    libncurses-dev \
-y

if [[ "$(which tmux)" == "" ]]; then
  tmux_version="3.1b"
  wget -O /tmp/tmux_src.tar.gz https://github.com/tmux/tmux/releases/download/${tmux_version}/tmux-${tmux_version}.tar.gz \
    && mkdir /tmp/tmux_src/ \
    && tar -C /tmp/tmux_src/ -xf /tmp/tmux_src.tar.gz \
    && rm -r /tmp/tmux_src.tar.gz \
    && cd /tmp/tmux_src/tmux-${tmux_version}/ \
    && /tmp/tmux_src/tmux-${tmux_version}/configure \
    && make \
    && sudo make install \
    && cd - \
    && rm -rf /tmp/tmux_src
fi

if [ ! -d $HOME/.dotfiles ]; then
    git clone "git@git.atanor.dev:quarkex/dotfiles.git" \
        $HOME/.dotfiles --recurse-submodules
fi

sudo cp $HOME/.dotfiles/tmux.conf /etc/tmux.conf

for file in \
    Xdefaults \
    Xresources \
    gitconfig \
    lynxrc \
    slack-term \
    tmux.conf \
    vim \
; do
    if [ ! -e $HOME/".$file" ]; then
        ln -s $HOME/.dotfiles/"$file" $HOME/".$file"
    fi
done

# Hook vim config file
if [ -L ~/.vimrc ]; then rm ~/.vimrc; fi
if [ ! -f ~/.vimrc ]; then touch ~/.vimrc; fi
grep "source ~/.dotfiles/vimrc" ~/.vimrc &>/dev/null
if [ ! $? -eq 0 ]; then
    echo -e "source ~/.dotfiles/vimrc\n$(cat ~/.vimrc)" \
        >~/.vimrc
fi

# Hook ssh config file
if [ ! -d ~/.ssh ];        then mkdir ~/.ssh;        fi
if [ ! -f ~/.ssh/config ]; then touch ~/.ssh/config; fi
grep "Include ~/.dotfiles/ssh/config" ~/.ssh/config &>/dev/null
if [ ! $? -eq 0 ]; then
    echo -e "Include ~/.dotfiles/ssh/config\n$(cat ~/.ssh/config)" \
        >~/.ssh/config
fi

# Hook bash_profile
grep "# Load personal bash_profile" $HOME/.bash_profile &>/dev/null
if [ ! $? -eq 0 ]; then echo '
# Load personal bash_profile
if [ -f ~/.dotfiles/bash_profile ]; then
    . ~/.dotfiles/bash_profile
fi'>>$HOME/.bash_profile
fi

# Hook bashrc
grep "# Load personal bashrc" $HOME/.bashrc &>/dev/null
if [ ! $? -eq 0 ]; then echo '
# Load personal bashrc
if [ -f ~/.dotfiles/bashrc ]; then
    . ~/.dotfiles/bashrc
fi'>>$HOME/.bashrc
fi

