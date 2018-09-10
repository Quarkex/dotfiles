function tmux (){
if [ $# -eq 0 ]; then
    # this will end with an error code if the session exist. Awesome
    /usr/bin/env tmux new-session -d -s main &>/dev/null;
    # we'll attach to that session anyway
    /usr/bin/env tmux attach-session -t main;
else
    /usr/bin/env tmux $@;
fi
}
