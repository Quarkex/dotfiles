slice_album() {(for file in "$@"; do
  file="$(realpath "$file")"
  file_name="${file##*/}"
  file_path="${file%%/$file_name}"

  audio_file="${file_path}/${file_name%%.list}.mp3"
  album_folder="${file_path}/${file_name%%.list}"

  if [[ ! -d "$album_folder" ]]; then
    if [[ -f "$album_folder" ]]; then
      mv "$album_folder" "$album_folder.list"
    fi
    mkdir -p "$album_folder"
  fi

  times=()
  titles=()
  while read time title; do
    times+=( "$time" )
    titles+=( "$title" )
  done<"$file_name"

  tracks="${#times[@]}"
  zero_padding="${#tracks}"

  files=()
  for index in "${!times[@]}"; do
    printf -v track '%0'${zero_padding}'d' $(( ${index} + 1 ))
    start_time="${times[$index]}"
    end_time="${times[$index + 1]}"
    title="${titles[$index]}"
    files+=( "${start_time} ${end_time:-end} $track $title" )
  done

  for file in "${files[@]}"; do
    start_time="$(echo "$file" | cut -d\  -f1)"
    end_time="$(echo "$file" | cut -d\  -f2)"
    track="$(echo "$file" | cut -d\  -f3)"
    metadata="$start_time $end_time $track "
    title="${file:${#metadata}}"
    output_file="$album_folder/[$track-$tracks] $title.mp3"

    if [[ "$end_time" == "end" ]]; then
      ffmpeg -y -hide_banner -loglevel panic \
      -i "$audio_file" \
      -acodec copy \
      -metadata Title="$( echo "$title" | sed -e 's/\(.*\)([^\(].*)/\1/' -e 's/^ *//' -e 's/ *$//' )" \
      -metadata Artist="$( echo "$title" | sed -e 's/.*(\([^\(].*\))/\1/' -e 's/^ *//' -e 's/ *$//' )" \
      -metadata Album="${file_name%%.list}" \
      -metadata Track="${track}/${tracks}" \
      -ss "$start_time" \
      "$output_file"
    else
      ffmpeg -y -hide_banner -loglevel panic \
      -i "$audio_file" \
      -acodec copy \
      -metadata Title="$( echo "$title" | sed -e 's/\(.*\)([^\(].*)/\1/' -e 's/^ *//' -e 's/ *$//' )" \
      -metadata Artist="$( echo "$title" | sed -e 's/.*(\([^\(].*\))/\1/' -e 's/^ *//' -e 's/ *$//' )" \
      -metadata Album="${file_name%%.list}" \
      -metadata Track="${track}/${tracks}" \
      -ss "$start_time" \
      -to "$end_time" \
      "$output_file"
    fi
  done

done)}
