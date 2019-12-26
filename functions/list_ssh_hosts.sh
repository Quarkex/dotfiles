list_ssh_hosts() {(
  list_mode=0
  if [ "$1" == "-l" ]; then list_mode=1; shift; fi

  hosts="$(
      grep -i "HOST " ~/.dotfiles/ssh/hosts/* \
      | sed 's/^.*Host //I'
  )"

  if [ ! "$*" == "" ]; then
      hosts="$( echo "$hosts" | grep "$*" )"
  fi

  if [ "$list_mode" -gt 0 ]; then
    echo "$hosts"
  else
    echo "$hosts" | paste -s -
  fi
)}
