function gmusicfs {(
    set -e;
    if [ -d "/mnt/gmusicfs" ]; then
        /usr/local/bin/gmusicfs $@ "/mnt/gmusicfs";
    else
        /usr/local/bin/gmusicfs $@;
    fi
)}
