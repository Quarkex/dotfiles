(
while getopts ":c:L:l:" opt; do
    case $opt in
        c)
            collection="$OPTARG"
            ;;
        L)
            limit="$OPTARG"
            ;;
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


project="${1}"
file="${2}"
lang="${lang-es}"
limit=${limit--1};

project_folder="${project}"

if [[ "$project" == '' ]]; then
    echo "you need a project."
    exit 0;
elif [[ ! -d "$project_folder" ]]; then
    echo "that project doesn't exist."
    exit 0;
fi
if [[ $file == '' ]]; then
    echo "you need a file."
    exit 0;
elif [[ ! -e "$file" ]]; then
    echo "file not found."
    exit 0;
fi

counter=1;
headers="";
while read line; do

    raw_data="$(
        for i in {0..30}; do
            echo "$line" | ruby -rcsv -ne 'puts CSV.parse_line($_)['$i']';
        done;
    )";

    if [[ "$headers" == "" ]]; then
        headers="$raw_data"
        echo "Row $counter taken as headers row"
        continue;
    fi

    img_url=""

    file_content="";
    function file_content_add() {
        if [[ $file_content == "" ]]; then
            file_content="$*";
        else
            file_content="$( echo "${file_content}"; echo "$*" )";
        fi
    }

    post_id="";

    file_content_add "$(echo "---";)"
    n_of_lines="$(echo "$headers" | wc -l)";
    current_line=1;
    while [[ $n_of_lines -gt $current_line ]]; do
        label="$( echo "$headers" | sed -n "${current_line}p" )";
        value="$( echo "$raw_data" | sed -n "${current_line}p" )";
        value="${value//\"/”}"

        current_line=$(( $current_line + 1 ));

        if [[ "$value" == "00000000000000" ]]; then
            value="19700101000000"
        fi

        case "$label" in
            "F_INICIO")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_FIN")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_INICIO_NOV")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_FIN_NOV")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_INICIO_PUB")
                post_date="$(echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3/')"
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_FIN_PUB")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_REVISION")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_BAJA")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "F_PUB_ORIGINAL")
                value="$( echo "$value" | sed -r 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/\1-\2-\3 \4:\5:\6 -0000/' )"
                ;;
            "CODMENU")
                post_id="$value";
                ;;
            "CODCONTENIDO")
                if [[ "$post_id" == "" ]]; then
                    echo "$post_id"
                    post_id="$value";
                fi
                ;;
            "TITULO")
                file_content_add "$( echo "title: \"${value}\"" )"
                ;;
            "IMAGEN")
                img_url="http://www.arona.org/portal/RecursosWeb/IMAGENES/1/0_${value}_1.jpg"
                ;;
            "RESUMEN")
                md_head="$value";
                ;;
            "DESCRIPCION_COMUN")
                md_body="$value";
                continue;
                ;;
            *)
                ;;
        esac
        file_content_add "$(echo "$label: \"$value\"";)"
    done;
    file_content_add "$( echo "ref: \"$post_id\""; )"
    file_content_add "$( echo "lang: \"$lang\""  )"
    file_content_add "$( echo "layout: \"post\"" )"
    file_content_add "$( echo "---"              )"
    file_content_add "$( echo "$md_head"         )"
    file_content_add "$( echo "$md_body"         )"

    filename="${post_id}.${lang}.md"
    if [[ $post_date != "" ]]; then
        filename="${post_date}-${filename}"
    fi
    destination_folder="${project_folder}_${collection-posts}"

    if [[ ! -d "$destination_folder" ]]; then
        mkdir -p "$destination_folder"
        if [[ ! -d "$destination_folder" ]]; then
            echo "can't create destination folder $destination_folder"
            exit 1;
        fi
    fi

    if [[ $img_url != "" ]]; then
        img_destination_folder="${project_folder}img/${collection-posts}/${post_date//-/\/}/"
        img_file="${img_destination_folder}${post_id}.${img_url##*.}"

        if [[ ! -e "${img_file%.*}.png" ]]; then
            if [[ ! -d "$img_destination_folder" ]]; then
                mkdir -p "$img_destination_folder"
                if [[ ! -d "$img_destination_folder" ]]; then
                    echo "can't create destination folder $img_destination_folder"
                fi
            fi

            if [[ -d "$img_destination_folder" ]]; then
                wget -O "$img_file" "$img_url" || rm "$img_file"
                if [[ -e "$img_file" ]]; then
                    convert "${img_file}" "${img_file%.*}.png" && rm "$img_file"
                fi
            fi
        fi
    fi

    echo "$file_content">"$destination_folder/$filename" &&
        echo "Row $(( $counter + 1 )) written to ${destination_folder}/${filename}"

    if [[ $limit != -1 ]]; then
        if [[ $counter == $limit ]]; then
            break;
        fi
    fi
    counter=$(( $counter + 1 ));

done< "$file"
echo "Done"
)
