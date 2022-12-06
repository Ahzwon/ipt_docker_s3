#!/bin/bash

# Create password file
echo $S3_ACCESS_KEY:$S3_SECRET_KEY > /root/passwd-s3fs
chmod 600 /root/passwd-s3fs

# Create S3 configuration file
echo "[default]" > ~/.s3cfg
echo access_key = $S3_ACCESS_KEY >> ~/.s3cfg
echo secret_key = $S3_SECRET_KEY >> ~/.s3cfg

# S3 command to make bucket on S3 host
# s4cmd mb s3://$S3_BUCKET_NAME --endpoint-url $S3_HOST

mkdir -p /root/s3data/ipt

# Mount S3 bucket
s3fs $S3_BUCKET_NAME /root/s3data/ipt -o passwd_file=/root/passwd-s3fs,use_path_request_style,url=$S3_HOST

# Might want to run this is recovering data from S3
# cp -R /root/s3data/ipt/* $IPT_DATA_DIR &&

# Enable service: synchronizing of IPT data dir to S3
systemctl enable s3_backup
systemctl start s3_backup
