roll() {
  if [[ "$1" == "" ]]; then
    roll 1d6
  else
    for item in "$@"; do
      case $item in
        coin)
          shuf -n 1 -e head tails
          ;;
        *)
          if [[ "${item,,}" =~ [0-9]d[0-9+\-] ]]; then
            symbol=""
            modifier=""
            read amount dice symbol modifier<<<$(echo "${item,,}" | tr "d" " " | sed -e 's/-/ - /g' -e 's/+/ + /g')

            if [[ "$amount" -gt 1 ]] || [[ ! "$modifier" == "" ]]; then
              show_total=true
            else
              show_total=false
            fi

            total=0
            while [ $amount -gt 0 ]; do
              result="$(shuf -n 1 -i 1-$dice)"
              let total=$(( $total + $result $symbol $modifier ))

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
              if [[ "$modifier" == "" ]]; then
                echo -e "\tTotal: $total"
              else
                echo -e "\tTotal $symbol $modifier: $total"
              fi
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
