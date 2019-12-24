#!/bin/bash
domains="$(
    grep -i "HOST " ~/.dotfiles/ssh/hosts/* \
    | sed 's/^.*Host //I' \
    | paste -s -
)"
for domain in $domains; do
    echo "Propagating to $domain:"
    ssh "$domain" ~/.dotfiles/update_dotfiles.sh
    echo
done
