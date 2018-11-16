# Add local bin folder to path
PATH="$PATH:$HOME/.local/bin"; export PATH
CDPATH="$CDPATH:~/workbench:~/vault:~/forge"; export CDPATH
EDITOR="vim"; export EDITOR

USER_COLOR="\[\e[38;5;$((0x$(sha1sum <<<"$USER"|cut -c1-2)))m\]"; export USER_COLOR
HOST_COLOR="\[\e[38;5;$((0x$(sha1sum <<<"$HOSTNAME"|cut -c1-2)))m\]"; export HOST_COLOR
INPUT_COLOR="\[\e[1;32m\]"; export INPUT_COLOR
CLEAR_COLOR="\e[0m"; export CLEAR_COLOR
PROMPT_CHAIN="\u@\h:\w"; export PROMPT_CHAIN
PROMPT_CHAIN_COLOR="${USER_COLOR}\u${CLEAR_COLOR}@${HOST_COLOR}\h${CLEAR_COLOR}:\w"; export PROMPT_CHAIN_COLOR


#standard ubuntu prompt:
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$"; export PS1

#nonr-standard ubuntu prompt:
#Non-colored
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$"; export PS1
#Colored
__update_ps1() {
    if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" == function ]; then
        if [[ $TERM == *256color* ]]; then
            PS1="\[\e]0;\u@\h: \w\a\]${PROMPT_CHAIN_COLOR}$(__git_ps1 " (%s)")$INPUT_COLOR"'\$ ';
        else
            PS1='\[\e]0;\u@\h: \w\a\]'"${PROMPT_CHAIN}$(__git_ps1 " (%s)")"'\$ ';
        fi
    else
        if [[ -f /etc/local/git-prompt.sh ]]; then
            source /etc/local/git-prompt.sh
            __update_ps1
        else
            if [[ "$(id -Gn $USER | grep '\bsudo\b')" ]]; then
                if [[ ! -d /etc/local ]]; then
                    sudo mkdir /etc/local
                fi
                sudo curl -o /etc/local/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
                __update_ps1
            fi
        fi
    fi
}
__update_ps1
PROMPT_COMMAND="__update_ps1; $PROMPT_COMMAND"; export PROMPT_COMMAND
#If you do not reset the text color at the end of your prompt, both the text you enter and the console text will simply stay in that color. If you want to edit text in a special color but still use the default color for command output, you will need to reset the color after you press Enter, but still before any commands get run. You can do this by installing a DEBUG trap, like this:
trap 'echo -ne "\e[0m"' DEBUG

#trim the prompt so it does not grow huge
PROMPT_DIRTRIM=2; export PROMT_DIRTRIM

#enable history autocompletion wizardy
bind Space:magic-space

#let's be polite. Allow others to talk to us
mesg y

#tell all our bash programs which care where our web home is
WWW_HOME="http://www.google.com"; export WWW_HOME

# Lets keep commands executed in multiple shells...
# avoid duplicates..
HISTTIMEFORMAT='%F %T: ';         export HISTTIMEFORMAT
HISTFILESIZE=-1;                  export HISTFILESIZE
#HISTSIZE=-1;                      export HISTSIZE
HISTCONTROL=ignoredups:erasedups; export HISTCONTROL
HISTIGNORE=?:??;                  export HISTIGNORE
# append history entries..
shopt -s histappend
# attempt to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
shopt -s lithist
# After each command, save and reload history
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"; export PROMPT_COMMAND
