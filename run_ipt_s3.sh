#!/bin/sh

MY_CONTAINER_NAME=name_of_your_container
LOCAL_IPT_DATA_DIR=/path/to/your/data

docker run --env-file env --detach --privileged --name $MY_CONTAINER_NAME --volume $LOCAL_IPT_DATA_DIR:/srv/ipt --publish 8080:8080 gbif/ipt

docker cp connect_s3.sh $MY_CONTAINER_NAME:/root/connect_s3.sh
docker cp sync.sh $MY_CONTAINER_NAME:/root/sync.sh
docker cp s3_backup.service $MY_CONTAINER_NAME:/etc/systemd/system/s3_backup.service
docker exec --user root $MY_CONTAINER_NAME chmod a+x /root/connect_s3.sh
docker exec --user root $MY_CONTAINER_NAME chmod a+x /root/sync.sh
docker exec --user root $MY_CONTAINER_NAME apt-get update
docker exec --user root $MY_CONTAINER_NAME apt-get install s3fs s4cmd inotify-tools rsync systemctl -y
docker exec --user root $MY_CONTAINER_NAME /root/connect_s3.sh
