function snake_case {
  echo "$*" | sed -e 's/\([A-Z]\{1\}\)/_\L\1\E/g' -e 's/^_//'
}
