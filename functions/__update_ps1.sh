__update_ps1() {
    if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" == function ]; then
        if [[ $TERM == *256color* ]]; then
            PS1="\[\e]0;\u@\h: \w\a\]${PROMPT_CHAIN_COLOR}$(__git_ps1 " (%s)")\n$INPUT_COLOR"'\$ ';
        else
            PS1='\[\e]0;\u@\h: \w\a\]'"${PROMPT_CHAIN}$(__git_ps1 " (%s)")\n"'\$ ';
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
