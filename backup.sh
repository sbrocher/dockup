#!/bin/bash

# Get timestamp
: ${BACKUP_SUFFIX:=.$(date +"%Y-%m-%d-%H-%M-%S")}
readonly tarball=$BACKUP_NAME$BACKUP_SUFFIX.tar.gz

# Create a gzip compressed tarball with the volume(s)
tar czf $tarball $BACKUP_TAR_OPTION $PATHS_TO_BACKUP

# Create bucket, if it doesn't already exist
BUCKET_EXIST=$(swift list | grep $ST_BUCKET_NAME | wc -l)
if [ $BUCKET_EXIST -eq 0 ]; 
then
  swift post $ST_BUCKET_NAME
fi

# Upload the backup to S3 with timestamp
swift upload $ST_BUCKET_NAME $tarball
