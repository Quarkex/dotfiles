function remove-special-characters {
    simulate=false;
    while getopts "::n" opt; do
        case $opt in
            n)
                simulate=true;
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                exit 1
                ;;
        esac
    done
    shift $(( OPTIND-1 ));

    if [ $simulate == true ]; then
        echo "simulating";
    else
        echo "working";
    fi

    file=$!;
    d="$( dirname "$file" )"
    f="$( basename "$file" )"
    new="${f//[^a-zA-Z0-9\/\._\-áéíóúÁÉÍÓÚñÑüÜ ]/}"
    if [ "$f" != "$new" ];then      # if equal, name is already clean, so leave alone
        if [ -e "$d/$new" ];then
            echo "Notice: \"$new\" and \"$f\" both exist in "$d":"
            ls -ld "$d/$new" "$d/$f"
        else
            if [ $simulate == true ]; then
                echo "\"$file\" renamed as \"$d/$new\""
            else
                mv "$file" "$d/$new"
            fi
        fi
    else
        echo "Filename is already correct.";
    fi
}
