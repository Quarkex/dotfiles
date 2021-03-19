search_and_replace(){
  target_string="$1"
  regexp_to_apply="$2"
  target_file="$3"
  target_lines="`grep -n "$target_string" "$target_file" | cut -d: -f1`"
  for target_line in $target_lines; do
    sed -i "${target_line}${regexp_to_apply}" "$target_file"
  done
}
