function cow {(
if [[ -z $COW ]]; then
    /usr/games/fortune -s | /usr/games/cowsay
else
    /usr/games/fortune -s | /usr/games/cowsay -f $COW
fi
)}
