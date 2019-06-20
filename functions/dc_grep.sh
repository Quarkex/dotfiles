dc_grep(){
    if [[ ! "$1" == "" ]]; then
        if [[ ! "$2" == "" ]]; then
            watch 'docker-compose logs '"$1"' | grep '"$2"' | sed "s/^[^|]*|[^\ ]*\ .*\]/\n==>/" | tail'
        else
            watch 'docker-compose logs | grep '"$1"' | sed "s/^[^|]*|[^\ ]*\ .*\]/\n==>/" | tail'
        fi
    else
        watch 'docker-compose logs | sed "s/^[^|]*|[^\ ]*\ .*\]/\n==>/" | tail'
    fi
}
