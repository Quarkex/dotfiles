function play_tar {
    archive="$1"
    track=$2
    tar tf "$archive"
    tar tf "$archive" | while read line; do
        index=$(( $index + 1 ))
        if [[ ${index:=0} -ge ${track:=0} ]]; then
            echo "$line"
            tar -xOf "$archive" "$line" | mplayer -really-quiet -cache 2048 -
        fi
    done
}
