#!/bin/bash
function backup_compose_instances {(
    if [[ "$EUID" -ne 0 ]]; then
        echo "Please run as root";
        exit;
    fi

    compose_folder="/srv/compose/"
    #backup_destination="backup_server:httpdocs/compose-backups"
    backup_destination=""
    backup_folder="/srv/backups"
    if [[ ! -d "$backup_folder" ]]; then
        mkdir "$backup_folder"
    fi

    function make_instance_backup {
        instance="${1%%/}"
        instance="${instance##$compose_folder}"
        instance_backup_folder="$backup_folder/$instance"
        timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
        filename="${instance##*/}"'_'"${timestamp}"'.tar.gz'

        echo -n "$2Processing ${instance}..."

        if [[ ! -d "$instance_backup_folder" ]]; then
            mkdir -p "$instance_backup_folder"
        fi

        tar -zcpf "$instance_backup_folder/$filename" --transform "s,^${compose_folder#/},," "$1" &>/dev/null

        echo " done. File size: $(du -csh "$instance_backup_folder/$filename" | tail -n 1 | sed 's/[ ]*total//g')"
    }

    function recurse_instances {
        for folder in "${1%/}"/*; do
            if [[ -d "$folder" ]]; then
                if [[ "${folder##*\.}" == "d" ]]; then
                    echo "${2}Processing nested folder: $folder"
                    recurse_instances "$folder" "$2    "
                    echo "$2    Nested folder “$folder” size: $(du -csh "$folder" | tail -n 1 | sed 's/[ ]*total//g')"
                else
                    if [[ ! -f "$folder/.nobackup" ]]; then
                        make_instance_backup "$folder" "$2"
                    fi
                fi
            fi
        done
    }

    echo "Begining backup process."
    echo "Folder to backup: $compose_folder"
    echo "Saving destination: $backup_folder"

    recurse_instances "$compose_folder"
    echo "Total folder size: $(du -csh "$backup_folder" | tail -n 1 | sed 's/[ ]*total//g')"

    if [[ "$backup_folder" != "" ]]; then
        echo "Cleaning files older than 3 days..."
        find "${backup_folder}"/* -type f -mtime +2 -print | xargs rm -rf
        echo "Total folder size after cleaning: $(du -csh "$backup_folder" | tail -n 1 | sed 's/[ ]*total//g')"
    fi

    if [[ "$backup_destination" != "" ]]; then
        echo "Syncing with backup server..."
        rsync -e "ssh -i /srv/.ssh/backup_server -l backups" --progress --delete -azh "$backup_folder" $backup_destination
    fi

    echo "Done."
)}
