USE AT YOUR OWN RISK

# Dockup

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)

Docker image to backup your Docker container volumes

Why the name? Docker + Backup = Dockup

# Usage

You have a container running with one or more volumes:

```
$ docker run -d --name mysql tutum/mysql
```

From executing a `$ docker inspect mysql` we see that this container has two volumes:

```
"Volumes": {
            "/etc/mysql": {},
            "/var/lib/mysql": {}
        }
```

Launch `dockup` container with the following flags:

```
$ docker run --rm \
--env-file env.txt \
--volumes-from mysql \
--name dockup sbrocher/dockup
```

The contents of `env.txt` being:

```
ST_AUTH=<public or private auth endpoint>
ST_KEY=<api key>
ST_USER=<user name>
BACKUP_NAME=mysql
PATHS_TO_BACKUP=/etc/mysql /var/lib/mysql
ST_BUCKET_NAME=dockup-backups
```

`dockup` will use your SoftLayer Object Storage credentials to create a new bucket (SoftLayer actually calls these containers, but for the safe of clarity we'll use bucket to refer to a SoftLayer Object Storage container) with name as per the environment variable `ST_BUCKET_NAME`, or if not defined, using the default name `docker-backups`. The paths in `PATHS_TO_BACKUP` will be tarballed, gzipped, time-stamped and uploaded to the SL bucket.


To perform a restore launch the container with the RESTORE variable set to true
