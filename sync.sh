#!/bin/bash

#
# This is run by the s3_backup.service
#
while true; do
    inotifywait -r -e modify,create,delete,move $IPT_DATA_DIR
    rsync -avz $IPT_DATA_DIR /root/s3data/ --delete-after
done
