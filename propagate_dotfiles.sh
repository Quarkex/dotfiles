#!/bin/bash
source ~/.dotfiles/bashrc
for domain in $( list_ssh_hosts ); do
    echo "Propagating to $domain:"
    ssh "$domain" ~/.dotfiles/update_dotfiles.sh
    echo
done
