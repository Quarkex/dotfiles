if [ command -v play >/dev/null 2>&1 ]; then
    alias play="play -q ";
else
    function play {
        if [[ ! -e /tmp/mplayer-control-fifo ]]; then
            mkfifo /tmp/mplayer-control-fifo
        fi
        for i in "$@"; do
            nohup mplayer -slave -input file=/tmp/mplayer-control-fifo -really-quiet "$i" 2&>/dev/null
        done
        if [[ -e /tmp/mplayer-control-fifo ]]; then
            rm /tmp/mplayer-control-fifo
        fi
    }
fi
