function videoclip {
    if [ $HOSTNAME == "ada" ]; then cd /media/quarkex/Root/Video/videoclip/; fi;
    local query="";
    for argument in ${@:1}; do
        query="$query+$(rawurlencode "$argument")";
    done
    query="$query+site:www.youtube.com";
    url="http://www.google.com/search?q=$query&btnI=I%27m+Feeling+Lucky";
    youtube-dl "$url";
};
