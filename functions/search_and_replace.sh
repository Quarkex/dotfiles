find_and_replace(){
  target_string="$1"
  regexp_to_apply="$2"
  target_file="$3"
  target_line=`grep -n "$target_string" "$target_file" | cut -d: -f1`
  sed -i "${target_line}${regexp_to_apply}" "$target_file"
}
