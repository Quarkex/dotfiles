function pdfpages {(
    while getopts "::hvi" opt; do
        case $opt in
            h)
                echo "this script is made to manage a glob of type **/*.pdf or similar.";
                echo "It will then output each file with the amount of pages, and the sum"
                echo "of all files."
                exit;
                ;;
            v)
                verbose=1;
                ;;
            i)
                index=1;
                verbose=1;
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
#if first argument is help or is not set
if [ -z ${1+x} ] || [ "help" == ${1} ]; then
    echo "this script is made to manage a glob of type **/*.pdf or similar.";
    echo "It will then output each file with the amount of pages, and the sum"
    echo "of all files."
    exit;
else
    files=${@}
    n=0;
    echo Counting pages...
    for i in $files; do
        docpages=$(pdfinfo "${i}" | grep Pages | sed 's/[^0-9]*//');
        if [[ $docpages == "" ]]; then
            docpages=0;
        fi
        if [[ $index == 1 ]]; then
            pags="[pag $(expr $n + 1)]"
        fi
        let n=$n+$docpages;
        if [[ $verbose == 1 ]]; then
            echo "$i: $docpages $pags"
        fi
    done;
    echo "Total pages: $n"
fi
)}
