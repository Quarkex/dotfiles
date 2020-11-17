roll() {
  if [[ "$1" == "" ]]; then
    roll 1d6
  else
    for item in $@; do
      case $item in
        coin)
          shuf -n 1 -e head tails
          ;;
        *)
          if [[ "${item,,}" =~ [0-9]d[0-9] ]]; then
            read amount dice <<<$(echo "${item,,}" | tr "d" " " )
            if [[ "$amount" -gt 1 ]]; then
              show_total=true
            else
              show_total=false
            fi

            total=0
            while [ $amount -gt 0 ]; do
              result="$(shuf -n 1 -i 1-$dice)"
              let total=$(( $total + $result ))

              info=""
              case $result in
                $dice)
                  info="critical hit"
                  ;;
                1)
                  info="critical fail"
                  ;;
                *)
                  ;;
              esac

              echo -n -e "\t"
              if [[ "$info" == "" ]]; then
                echo "d$dice: $result"
              else
                echo "d$dice: $result ($info)"
              fi

              let amount=$(( $amount - 1 ))
            done
            if [ $show_total == true ]; then
              echo -e "\tTotal: $total"
            fi
            echo
          else
            echo "$item"
          fi
          ;;
      esac
    done
  fi
}
