#!/bin/bash
if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles && git pull --recurse-submodules
fi
