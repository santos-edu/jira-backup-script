#!/bin/bash

config_file=='/etc/jira-backup.conf'

timestamp=$(date +'%Y-%m-%d-%H-%M')

#Test config file 

if [ -e ${config_file} ]; then
    source ${config_file}
else
    echo "Error: ${config_file} missing"
    exit 1
fi

attachment_backup_output="${backup_dir}/jira-attachments-${timestamp}.tar.bz2"
database_dump_output="${backup_dir}/jira-dump-${timestamp}.sql.bz2"


function setup() {
    if [ ! -d "${backup_dir}" ]; then
        echo "Creating ${backup_dir}"
        mkdir -p "${backup_dir}"
    fi
}

function backup_attachments() {
    echo "Backing up Jira attachments"
    /bin/tar -cjf ${attachment_backup_output} ${attachments_path}
    echo "Created ${attachment_backup_output}"
}

function dump_database() {
    echo "Dumping Jira database"    
    mysqldump -h ${db_host} -u ${db_user} -p${db_pass} --all-databases | bzip2 > "${database_dump_output}"
    echo "Created ${database_dump_output}"
}

function main() {
    echo "Backing up Jira"
    setup
    backup_attachments
    dump_database
}

main
