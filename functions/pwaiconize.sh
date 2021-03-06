function pwaiconize {(
    for filename in "$@"; do
        file="${filename%%.*}"
        ext="${filename#$file}"
        instruction="convert \"$filename\" "
        for n in 512 256 384 192 152 128 144 96 72 48; do
            instruction="$instruction \( -clone 0 -resize ${n}x${n} -write \"$file-$n${ext,,}\" \) "
        done
        instruction="$instruction -alpha on null: "
        eval "$instruction"
    done
)}
