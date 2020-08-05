function camel_case {
  echo "$*" | sed -e 's/_\([a-z]\{1\}\)/\U\1\E/g' -e 's/^\([a-z]\)/\U\1\E/'
}
