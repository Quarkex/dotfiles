function tmux (){
if [ $# -eq 0 ]; then
    /usr/bin/env tmux has-session -t main &>/dev/null;
    if [ ! $? -eq 0 ]; then
        /usr/bin/env tmux new-session -d -s main &>/dev/null;
    fi
    /usr/bin/env tmux attach-session -t main;
else
    /usr/bin/env tmux $@;
fi
}
