function img2cover {(
    ext="jpg";
    cover=" (cover)";
    backcover=" (backcover)";
    joint=" - ";
    while getopts ":t:a:c:b:e:j:o:h" opt; do
        case $opt in
            h)
                echo "Joins images at the first or last page of a pdf.";
                echo "";
                echo "-t Define the title string.";
                echo "-a Define the author's name string.";
                echo "-c Define the cover identifier string. Defaults to \" (cover)\"";
                echo "-b Define the backcover identifier string. Defaults to \" (backcover)\"";
                echo "-e Define the extension for cover images. Defaults to \"jpg\"";
                echo "-j Define a join string between author and title. Defaults to \" - \"";
                echo "-o Select an output name.";
                echo "-h Show this help.";
                exit 0;
                ;;
            t)
                title="$OPTARG"
                ;;
            a)
                author="$OPTARG"
                ;;
            c)
                cover="$OPTARG"
                ;;
            b)
                backcover="$OPTARG"
                ;;
            e)
                ext="$OPTARG"
                ;;
            j)
                joint="$OPTARG"
                ;;
            o)
                outputname="$OPTARG"
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

    if [ $author == "" ]; then
        filename="${title%%.pdf}".pdf;
    else
        filename="$author$joint${title%%.pdf}".pdf;
    fi
    covername="${filename%%.pdf}$cover.$ext";
    backcovername="${filename%%.pdf}$backcover.$ext";
    if [ "$outputname" == "" ]; then
        outputname="$filename";
    else
        outputname="${outputname%%.pdf}.pdf";
    fi

    if [ -e "$filename" ]; then
        fileaux="$(mktemp -t "${0##*/}.XXXXXXXXXX.pdf")";
        cp "$filename" "$fileaux";

        size=$(pdfinfo "$fileaux" | grep "Page size");
        size=${size##*: };
        size=${size%% pts*};
        size=${size/\ x\ /x};

        function attach {
        if [ -e "$imagename" ]; then
            imageaux="$(mktemp -t "${0##*/}.XXXXXXXXXX.pdf")";
            working_copy="$(mktemp -t "${0##*/}.XXXXXXXXXX.pdf")";
            convert "$imagename" -gravity center -background white -extent $size "$imageaux";
            if [ -e "$imageaux" ]; then
                if [ ! $invert == true ];then
                    echo "Attaching cover...";
                    pdftk "$imageaux" "$fileaux" cat output "$working_copy";
                else
                    echo "Attaching backcover...";
                    pdftk "$fileaux" "$imageaux" cat output "$working_copy";
                fi
                if [ $? ]; then
                    mv "$working_copy" "$fileaux";
                fi
                rm "$imageaux";
            fi
        fi
    }

    imagename="$covername"; invert=false; attach;
    imagename="$backcovername"; invert=true; attach;

    function conclude {
    mv "$fileaux" "$outputname";
        }

        if [ ! -e "${outputname}" ]; then
            conclude;
        else
            echo "File exist: ${outputname}. Overwrite?";
            select  item in Yes No;
            do
                if [ $item = "No" ]; then
                    rm "$fileaux";
                    break
                fi
                if [ $item = "Yes" ]; then
                    conclude;
                    break
                fi
            done
        fi

    else
        echo "The file $filename does not exist.";
    fi

)}
