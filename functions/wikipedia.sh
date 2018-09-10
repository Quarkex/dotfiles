function wikipedia {(
    local lang="en"
    while getopts ":l:" opt; do
        case $opt in
            l)
                lang="$OPTARG"
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
    local query=$(rawurlencode "${*:1}")
    lynx "http://${lang}.wikipedia.org/w/index.php?search=${query}"
)}
