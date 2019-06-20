#sudo things that need it
alias apt-get="sudo apt-get"
alias service="sudo service"

alias ding="play /usr/share/sounds/freedesktop/stereo/complete.oga"
#alias copy="rsync -az"
alias ls="ls --color=auto --group-directories-first"
alias :q='exit'
alias hasstring='find . -type f -print0 | xargs -0 grep $1'
alias cls='clear && echo "Current directory: $(pwd)" && ls'
alias xampp='sudo /opt/lampp/lampp'
alias youtube-dl='youtube-dl --no-overwrites --write-sub --sub-lang en,es --embed-subs --add-metadata --download-archive ~/.youtube-dl_cache -o "~/Vídeos/_incoming_/%(extractor)s/%(playlist)s/%(autonumber)03d - %(title)s.%(ext)s" --restrict-filenames --write-all-thumbnail --write-description --write-info-json --write-annotations $1'
alias youtube-mp3='youtube-dl -x --audio-format mp3 --no-overwrites --add-metadata --download-archive ~/.youtube-dl_cache -o "~/Música/_incoming_/%(extractor)s/%(playlist)s/%(autonumber)03d - %(title)s.%(ext)s" --embed-thumbnail --audio-quality 0 --restrict-filenames --write-all-thumbnail --write-description --write-info-json --write-annotations $1'
share(){ net usershare add "$1" "$2" "$3" everyone:F guest_ok=y; }
#alias dropboxmount='dropbox=/mnt/Dropbox; sshfs -o idmap=user $(whoami)@$(cat "$dropbox/_Workbench/IPs/ADA.txt"):/ "/mnt/$1"'
alias smus='screen -x "cmus" || screen -S "cmus" -m "cmus"'
alias open=xdg-open
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

alias pacmd="sudo PULSE_RUNTIME_PATH=/var/run/pulse -u pulse pacmd"
alias asinks="pacmd list-sinks | grep -e 'name:' -e 'index:'"
alias ainputs="pacmd list-sink-inputs | grep -e 'media.name' -e 'index:'"
alias asetport="pacmd set-sink-port"
alias asetsink="pacmd set-default-sink "
alias amovesink="pacmd move-sink-input "

alias dc="docker-compose"

alias l='ls'
alias la='ls -a'
alias ll='ls -al'

alias add='git add'
alias amend='git amend'
alias ammend='git amend' # yes, I know...
alias commit='git commit'
alias log='git log'
alias pull='git pull'
alias push='git push'
alias status='git status'
alias changes='git changes'
alias last_change='git lastchange'

alias d='git diff'
alias s='status'
alias lg='git lg'
alias lc='last_change'
alias damn='git damn'
