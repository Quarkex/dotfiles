propagate_ssh_hosts() {(
    source ~/.dotfiles/bashrc
    for domain in $( list_ssh_hosts ); do
        echo "Propagating to $domain:"
        echo "Command: $@"
        ssh "$domain" $@
        echo
    done
)}
