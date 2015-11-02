#!/bin/bash

# Find last backup file
: ${LAST_BACKUP:=$(swift list $ST_BUCKET_NAME | grep ^$BACKUP_NAME | sort -r | head -n1)}

# Download backup from S3
swift download $ST_BUCKET_NAME $LAST_BACKUP

# Extract backup
tar xzf $LAST_BACKUP $RESTORE_TAR_OPTION
