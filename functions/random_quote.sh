random_quote() {(
  choices=( "bubble_dragon")
  animal=${choices[$RANDOM % ${#choices[@]} ]}
  fortune -s | cowsay -f $animal
  )}
