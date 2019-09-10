function websearch {(
    local query="";
    for argument in ${@:1}; do
        query="$query+$(rawurlencode "$argument")";
    done
    lynx "https://www.google.com/search?q=$query"
)}
