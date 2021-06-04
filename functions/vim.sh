vim(){
  clientserver=$(command vim --version | grep "+clientserver")
  if [[ "$clientserver" == "" ]]; then
      command vim "$@"
  else
    servername="$(command vim --serverlist | head -1)"
    [[ "$servername" == "" ]] && first_vim=true
    [[ "$servername" == "" ]] && servername="main"
    if [[ $# > 0 ]] && [[ ! $first_vim == true ]]; then
      command vim --servername "$servername" --remote-silent "$@"
    else
      command vim --servername "$servername" "$@"
    fi
  fi
}
