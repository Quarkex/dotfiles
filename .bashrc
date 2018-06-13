# Dropbox/.bashrc: To be included by ~/.bashrc

#standard ubuntu prompt:
#export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$"

#nonr-standard ubuntu prompt:
#Non-colored
#export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$"
#Colored
export PS1="\[\e]0;\u@\h: \w\a\]\[\e[1;30m\]\u\[\e[0;32m\]@\h\[\e[0m\]:\w$\[\e[1;32m\]"
#If you do not reset the text color at the end of your prompt, both the text you enter and the console text will simply stay in that color. If you want to edit text in a special color but still use the default color for command output, you will need to reset the color after you press Enter, but still before any commands get run. You can do this by installing a DEBUG trap, like this:
trap 'echo -ne "\e[0m"' DEBUG

#trim the prompt so it does not grow huge
PROMPT_DIRTRIM=2

#enable history autocompletion wizardy
bind Space:magic-space

#set bash history preferences
export HISTCONTROL=ignorespace

#let's be polite. Allow others to talk to us
mesg y

#tell all our bash programs which care where our web home is
WWW_HOME="http://www.google.com";
export WWW_HOME;

#set up an easy access for documentation
function doc
{
    pushd "/usr/share/doc/$1" && ls
}
export -f doc

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]; then
#    STARTED_SCREEN=1 ; export STARTED_SCREEN
#    screen -RR -S main || echo "Screen failed! continuing with normal bash startup"
#fi
# [end of auto-screen snippet]

#sudo things that need it
alias apt-get="sudo apt-get"
alias service="sudo service"

# aliases
function say {
        espeak --stdout -v english "$1" | \
        play -t wav - \
        overdrive 10 \
        echo 0.8 0.8 5 0.7 \
        echo 0.8 0.7 6 0.7 \
        echo 0.8 0.7 10 0.7 \
        echo 0.8 0.7 12 0.7 \
        echo 0.8 0.88 12 0.7 \
        echo 0.8 0.88 30 0.7 \
        echo 0.6 0.6 60 0.7 \
        gain 8;
}
alias clear_history="cat /dev/null > ~/.bash_history"
alias :q='exit'
alias hasstring='find . -type f -print0 | xargs -0 grep $1'
alias cls='clear && echo "Current directory: $(pwd)" && ls'
alias xampp='sudo /opt/lampp/lampp'
alias youtube-mp3='youtube-dl -x --audio-format mp3 $1'
#alias dropboxmount='dropbox=/mnt/Dropbox; sshfs -o idmap=user $(whoami)@$(cat "$dropbox/_Workbench/IPs/ADA.txt"):/ "/mnt/$1"'
function dropboxmount {(
    command -v sshfs >/dev/null 2>&1 || { echo >&2 "This command require sshfs but it's not installed. Aborting."; exit 1; }
    if [ -d "/mnt/Dropbox" ]; then
        echo "Found a Dropbox folder in /mnt";
        dropbox="/mnt/Dropbox";
    else
        dropbox="$HOME/Dropbox";
    fi

    if [ -f "$dropbox/_Workbench/IPs/${1^^}.txt" ]; then
        ip=$(cat "$dropbox/_Workbench/IPs/${1^^}.txt");
        sshfs "$(whoami)@$ip:/" "/mnt/$1";
    else
        { echo >&2 "There is no ${1^^} server in IP folder."; }
    fi
)}
alias smus='screen -x "cmus" || screen -S "cmus" -m "cmus"'
alias open=xdg-open
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

function systemtweak {(
    echo "installing system custom software...";
    sudo apt-get install \
    awesome \
    xfe \
    sshfs \
    vim \
    gpm \
    cmus \
    texlive \
    python-pip \
    youtube-dl \
    sox \
    libsox-fmt-mp3 \
    flac \
    id3v2 \
    imagemagick \
    pdftk \
    lynx \
    zip \
    apache2 \
    mysql-server \
    phpmyadmin \
    git \
    kpcli libterm-readline-gnu-perl libdata-password-perl \
    wicd-curses \
    wakeonlan \
    cifs-utils \
    alsa alsa-tools \
    googlecl
    echo "done\n"

    echo "cleaning system"
    sudo apt-get autoremove;
    sudo apt-get -o APT::Clean-Installed="false" autoclean;

    #leave a minimal xsession ready to launch
    if [ ! -f "$HOME/.xinitrc.disabled" ]; then
        echo "xterm & awesome" > "$HOME/.xinitrc.disabled"
    fi

    #who can work without music? leave it to google.
    echo "installing Google Music API (unnificial) and GMusicFS..."
    sudo pip install https://github.com/terencehonles/fusepy/tarball/master
    sudo pip install https://github.com/simon-weber/Unofficial-Google-Music-API/tarball/develop
    sudo pip install https://github.com/EnigmaCurry/GMusicFS/tarball/master

    if [ ! -f "$HOME/.gmusicfs" ]; then
        echo "adding .gmusicfs file in home directory...";
        echo "[credentials]" > "$HOME/.gmusicfs";
        echo "username = your_username@gmail.com" >> "$HOME/.gmusicfs";
        echo "password = your_password" >> "$HOME/.gmusicfs";
        echo "deviceId = your_mobile_id" >> "$HOME/.gmusicfs";
        chmod 600 "$HOME/.gmusicfs";
    fi
    if [ ! -d "/mnt/gmusicfs" ]; then
        echo "adding gmusicfs folder in mnt directory...";
        sudo mkdir /mnt/gmusicfs
        sudo chmod 777 "/mnt/gmusicfs";
    fi
    sudo addgroup $USER fuse; #just to be sure you can actually use fuse
    sudo addgroup $USER audio;#just to be sure you can actually play sound
    echo "done."


)}

function gmusicfs {(
    set -e;
    if [ -d "/mnt/gmusicfs" ]; then
        /usr/local/bin/gmusicfs $@ "/mnt/gmusicfs";
    else
        /usr/local/bin/gmusicfs $@;
    fi
)}

function pdf2cbz {(
# Check dependencies
command -v zip >/dev/null 2>&1 || { echo >&2 "This command require zip but it's not installed. Aborting."; exit 1; }
command -v pdfimages >/dev/null 2>&1 || { echo >&2 "This command require pdfimages but it's not installed. Aborting."; exit 1; }
command -v pdfinfo >/dev/null 2>&1 || { echo >&2 "This command require pdfinfo but it's not installed. Aborting."; exit 1; }

# Test file type
filename=$(echo "$1" | sed 's/.*\///' );
type="$(file -b "$1")"
if [ "${type%%,*}" == "PDF document" ]; then
    name=$(echo "$1" | sed 's/\.pdf//' );
    echo "$filename is a PDF file.";

    # Create a temporal folder and move in
    mkdir ".pdf2cbz";
    cd ".pdf2cbz";

    # Extract images as jpegs using pdfimages
    echo "Extracting PDF images...";
    pdfimages -j "../$filename" "$name";

    count=`ls -1 *.ppm 2>/dev/null | wc -l`
    if [ $count != 0 ]
    then
        echo "Images obtained in ppm format. Converting to jpg...";
        for g in *.ppm; do convert "$g" "$g.jpg"; done;
            rm *.ppm;
            rename 's/\.ppm//' *.jpg;
        fi

        # Add the metadata file
        echo "Creating metadata file...";
        touch "Comicinfo.xml";
        echo '<?xml version="1.0"?>' >> "Comicinfo.xml";
        echo '<ComicInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">' >> "Comicinfo.xml";
        echo "<Title>$name</Title>" >> "Comicinfo.xml";
        echo "<Summary>$(pdfinfo "../$filename" | grep "Subject:" | sed 's/Subject:\s*//')</Summary>" >> "Comicinfo.xml";
        echo "<Keywords>$(pdfinfo "../$filename" | grep "Keywords:" | sed 's/Keywords:\s*//')</Keywords>" >> "Comicinfo.xml";
        echo "<Author>$(pdfinfo "../$filename" | grep "Author:" | sed 's/Author:\s*//')</Author>" >> "Comicinfo.xml";
        echo "<Publisher>$(pdfinfo "../$filename" | grep "Producer:" | sed 's/Producer:\s*//')</Publisher>" >> "Comicinfo.xml";
        echo "<PageCount>$(pdfinfo "../$filename" | grep "Pages:" | sed 's/Pages:\s*//')</PageCount>" >> "Comicinfo.xml";
        echo '</ComicInfo>' >> "Comicinfo.xml";

        # Move the original pdf inside
        mv "../$filename" "./$filename";

        # Zip all the files
        echo "Creating zip file...";
        zip "$name" *;

        # Move the final file out as a cbz and remove the temporal folder
        mv "$name.zip" "../$name.cbz";
        cd "..";
        echo "Cleaning up...";
        rm -r ".pdf2cbz";
        echo "Done.";
    else
        echo "$filename is not a PDF file.";
    fi
)}

function ff2num {(
    if [ "$1" = "." ]
    then
        execPath="${PWD%/}";
    else
        execPath="${1:-${PWD%/}}";
    fi
    while [ "${execPath: -1}" = "/" ]
    do
        execPath="${execPath%/}";
    done

    basename="${execPath##*/}";
    pushd . && cd "${execPath}";
    files=*.*;

    digits=1;
    amountOfFiles=0;
    for i in ${files}; do
        [ -f "$i" ] || continue;
        let amountOfFiles=amountOfFiles+1;
    done
    while [ "$amountOfFiles" -gt "11" ]; do
        let amountOfFiles=amountOfFiles=amomuntOfFiles/10;
        let digits=$digits+1;
    done

    a=0;
    for i in ${files}; do
        [ -f "$i" ] || continue;
        ext="${i##*.}";
        num=$(printf "%0${digits}d" ${a});
        mv "$i" "${basename}_$num.$ext";
        let a=a+1;
    done
    popd;
)}

function ff2cbz {(
      set -e;
      if [ "$1" = "." ]
      then
            execPath="${PWD%/}";
      else
            execPath="${1:-${PWD%/}}";
      fi
      while [ "${execPath: -1}" = "/" ]
      do
            execPath="${execPath%/}";
      done

      basename="${execPath##*/}";
      pushd . && cd "${execPath}";

      zip "$basename" * &&
      mv "$basename.zip" "../$basename.cbz" &&
      cd ".." &&
      rm -r "$basename";

      popd;
)}

function tex2odt {
      name="${1%.tex}";

      latex2html "$name.tex" -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode &&
      libreoffice --headless --convert-to odt:"OpenDocument Text Flat XML" "$name/index.html"
}

#function google2tex {
#      name="${1%.txt}";
#      output="${name}.tex";
#      content="${1}";
#
#      rm "${output}";
#      touch "${output}";
#
#
#      while read p; do
#            if [[ "${p}" =~ ^class: ]] ; then  
#                  content="$(grep -v -E ^class:.*$ "${content}")";
#            fi
#      done <"${content}"
#
#      while read p; do
#
#            if [[ "${p}" =~ ^class: ]] ; then  
#                  read -d '' p <<EOF
#\\\documentclass{$(sed 's/^class://' <<< "${p}")}
#\\\usepackage{graphicx}
#\\\usepackage{listings}
#\\\usepackage{hyperref}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^lang: ]] ; then 
#                  read -d '' p <<EOF
#\\\usepackage[$(sed 's/^lang://' <<< "${p}")]{babel}
#\\\usepackage[utf8]{inputenc}
#\\\usepackage[T1]{fontenc}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^geometry: ]] ; then  
#                  p="\\usepackage[$(sed 's/^geometry://' <<< "${p}")]{geometry}"; 
#            fi
#            if [[ "${p}" =~ ^has:code$ ]] ; then  
#                  read -d '' p <<EOF
#\\\usepackage{color}
#\\\definecolor{dkgreen}{rgb}{0,0.6,0}
#\\\definecolor{gray}{rgb}{0.5,0.5,0.5}
#\\\definecolor{mauve}{rgb}{0.58,0,0.82}
#
#\\\lstset{
#  frame=tb,
#  language=HTML,
#  aboveskip=3mm,
#  belowskip=3mm,
#  showstringspaces=false,
#  columns=flexible,
#  numbers=left,
#  basicstyle={\small\ttfamily},
#  numberstyle=\tiny\color{gray},
#  keywordstyle=\color{blue},
#  commentstyle=\color{dkgreen},
#  stringstyle=\color{mauve},
#  breaklines=true,
#  breakatwhitespace=true
#  tabsize=3
#}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^eop$ ]] ; then  
#                  read -d '' p <<EOF
#\\\begin{document}
#
#EOF
#            fi
#      
#      
#            echo "$p" >> "${output}";
#
#      done <"${content}"
#
#}

function rawurlencode {
    local string="${1}"
    local strlen=${#string}
    local encoded=""

    for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
    esac
    encoded+="${o}"
done
echo "${encoded}";    # You can either set a return variable (FASTER) 
#REPLY="${encoded}";   #+or echo the result (EASIER)... or both... :p
}

# Returns a string in which the sequences with percent (%) signs followed by
# two hex digits have been replaced with literal characters.
function rawurldecode {

    # This is perhaps a risky gambit, but since all escape characters must be
    # encoded, we can replace %NN with \xNN and pass the lot to printf -b, which
    # will decode hex for us

    echo $(printf '%b' "${1//%/\\x}") # You can either set a return variable (FASTER)

    #echo "${REPLY}"  #+or echo the result (EASIER)... or both... :p
}

function wikipedia {(
    local lang="en"
    while getopts ":l:" opt; do
        case $opt in
            l)
                lang="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                exit 1
                ;;
        esac
    done
    shift $(( OPTIND-1 ));
    local query=$(rawurlencode "${*:1}")
    lynx "http://${lang}.wikipedia.org/w/index.php?search=${query}"
)}
function websearch {(
    local query="";
    for argument in ${@:1}; do
        query="$query+$(rawurlencode "$argument")";
    done
    lynx "https://www.google.com/search?q=$query"
)}

function rtfm { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }

function videoclip {
    if [ $HOSTNAME == "ada" ]; then cd /media/quarkex/Root/Video/videoclip/; fi;
    local query="";
    for argument in ${@:1}; do
        query="$query+$(rawurlencode "$argument")";
    done
    query="$query+site:www.youtube.com";
    url="http://www.google.com/search?q=$query&btnI=I%27m+Feeling+Lucky";
    youtube-dl "$url";
};

function awake {(
    case "$1" in
        ada) wakeonlan 00:22:15:d3:99:df; ;;
        clu) wakeonlan f8:d1:11:0e:d5:27; ;;
        dimaxion) wakeonlan c4:2c:03:d9:48:aa; ;;
        klue) wakeonlan 00:1e:68:b9:22:45; ;;
        multivac) wakeonlan 60:a4:4c:3d:69:a8; ;;
        *) echo "Unknown machine.";
    esac
)}


function pdfpages {(
    while getopts "::hvi" opt; do
        case $opt in
            h)
                echo "this script is made to manage a glob of type **/*.pdf or similar.";
                echo "It will then output each file with the amount of pages, and the sum"
                echo "of all files."
                exit;
                ;;
            v)
                verbose=1;
                ;;
            i)
                index=1;
                verbose=1;
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                exit 1
                ;;
        esac
    done
    shift $(( OPTIND-1 ));
#if first argument is help or is not set
if [ -z ${1+x} ] || [ "help" == ${1} ]; then
    echo "this script is made to manage a glob of type **/*.pdf or similar.";
    echo "It will then output each file with the amount of pages, and the sum"
    echo "of all files."
    exit;
else
    files=${@}
    n=0;
    echo Counting pages...
    for i in $files; do
        docpages=$(pdfinfo "${i}" | grep Pages | sed 's/[^0-9]*//');
        if [[ $docpages == "" ]]; then
            docpages=0;
        fi
        if [[ $index == 1 ]]; then
            pags="[pag $(expr $n + 1)]"
        fi
        let n=$n+$docpages;
        if [[ $verbose == 1 ]]; then
            echo "$i: $docpages $pags"
        fi
    done;
    echo "Total pages: $n"
fi
)}

function tg {(
    set -e;
    output=$(echo -e "${@}\nsafe_quit" | telegram -W)
    output=$(sed -e '0,/^.* safe_quit/d' <<< "$output" );
    output=$(head -n -1  <<< "$output" );
    echo "$output";
)}

function tmux (){
if [ $# -eq 0 ]; then
    # this will end with an error code if the session exist. Awesome
    /usr/bin/tmux new-session -d -s main &>/dev/null;
    # we'll attach to that session anyway
    /usr/bin/tmux attach-session -t main;
else
    /usr/bin/tmux $@;
fi
}

# if we are inside a tmux session...
if [ "$TERM" = "screen" ] && [ -n "$TMUX_PANE" ]; then
    echo "Welcome to ${HOSTNAME}, user ${USER}.";
else
    # if we are using ssh
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        # this will end with an error code if the session exist. Awesome
        /usr/bin/tmux new-session -d -s main &>/dev/null;
        # we'll attach to that session anyway
        exec /usr/bin/tmux attach-session -t main;
    fi
fi
