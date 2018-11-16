# Dropbox/.bashrc: To be included by ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# environment
if [ -f ~/.dotfiles/environment.sh ]; then
    . ~/.dotfiles/environment.sh
fi

# aliases
if [ -f ~/.dotfiles/bash_aliases.sh ]; then
    . ~/.dotfiles/bash_aliases.sh
fi

# functions
for i in ~/.dotfiles/functions/*.sh; do
    source "$i"
done

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]; then
#    STARTED_SCREEN=1 ; export STARTED_SCREEN
#    screen -RR -S main || echo "Screen failed! continuing with normal bash startup"
#fi
# [end of auto-screen snippet]

# if we are inside a tmux session...
#if [ "$TERM" = "screen" ] && [ -n "$TMUX_PANE" ]; then
    #echo "Welcome to ${HOSTNAME}, user ${USER}.";
#else
    # if we are using ssh
    #if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        # this will end with an error code if the session exist. Awesome
        #/usr/bin/tmux new-session -d -s main &>/dev/null;
        # we'll attach to that session anyway
        #exec /usr/bin/tmux attach-session -t main;
    #fi
#fi

