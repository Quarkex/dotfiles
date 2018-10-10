#!/bin/bash

backup_destination="backup_server:httpdocs/odoo-backups"
backup_folder="/home/docker_admin/backups"
if [[ ! -d "$backup_folder" ]]; then
    mkdir "$backup_folder"
fi

for odoo_container in /home/docker_admin/docker/odoo-*/; do
    instance="${odoo_container%%/}"
    instance="${instance##*odoo-}"
    instance_backup_folder="$backup_folder/$instance"

    echo "Processing ${instance}..."

    if [[ ! -d "$instance_backup_folder" ]]; then
        mkdir "$instance_backup_folder"
    fi
    echo "Saving files..."
    /usr/local/bin/c_odoo "$instance" save_files "$instance_backup_folder"

    for database in $odoo_container/data/filestore/*; do
        db="${database%%/}"
        db="${database##*/}"
        echo "Dumping ${db}..."
        /usr/local/bin/c_postgres pro dump "$db" "$instance_backup_folder"
    done
    echo "Done processing ${instance}."
done


echo "Cleaning files older than 3 days..."
find "${backup_folder}"/* -type f -mtime +2 -print | xargs rm -rf

echo "Syncing with backup server..."
rsync -e "ssh -i /home/docker_admin/.ssh/backup_server -l cipadmin" --progress --delete -azh "$backup_folder" $backup_destination

echo "Done."
