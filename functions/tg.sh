function tg {(
    set -e;
    output=$(echo -e "${@}\nsafe_quit" | telegram -W)
    output=$(sed -e '0,/^.* safe_quit/d' <<< "$output" );
    output=$(head -n -1  <<< "$output" );
    echo "$output";
)}
