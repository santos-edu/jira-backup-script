#!/bin/bash
#Clean backup attachments:
rm -rfv /var/backup/jira/*

#Clean jira system export backups:
find /var/atlassian/application-data/jira/export/*.zip* -ctime +1 -exec rm -rfv {} \; > /var/log/jira/rm-arq-old.txt

#Clean old logs
find /opt/atlassian/jira/logs/ -maxdepth 1 -name "*.log" -mtime +30 -exec rm -rfv {} \;
