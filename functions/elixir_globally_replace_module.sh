function elixir_globally_replace_module {
  from="${1}"; to="${2}";

  snake_from="$(echo "$from" | sed -e 's/\([A-Z]\{1\}\)/_\L\1\E/g' -e 's/^_//')";
  snake_to="$(echo "$to" | sed -e 's/\([A-Z]\{1\}\)/_\L\1\E/g' -e 's/^_//')";

  find . -type f -exec sed -i -e 's/'"$from"'/'"$to"'/g' -e 's/'"${snake_from}"'/'"${snake_to}"'/g' {} \;
}
