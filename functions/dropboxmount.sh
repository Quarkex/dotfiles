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
