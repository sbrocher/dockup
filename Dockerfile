FROM ubuntu:trusty
MAINTAINER Sebastian Brocher <seb@chimi.co>

RUN apt-get update && apt-get install -y python-pip && pip install python-swiftclient

ADD backup.sh /backup.sh
ADD restore.sh /restore.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

ENV ST_BUCKET_NAME dockup-backups
ENV ST_AUTH **DefineMe**
ENV ST_KEY **DefineMe**
ENV ST_USER **DefineMe**
ENV PATHS_TO_BACKUP /paths/to/backup
ENV BACKUP_NAME backup
ENV RESTORE false

CMD ["/run.sh"]
