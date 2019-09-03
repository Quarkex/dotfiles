function ps_find {(
    ps ax | grep "$(echo "$*" | sed 's/^\(.\)\(.*\)/[\1]\2/')" | sed -e 's/^[\ ]*//' -e 's/ .*$//'
)}
