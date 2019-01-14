#! /bin/bash

set -euo pipefail
IFS=$'\n\t'

LOGFILE=/home/slurm/elastic.log

hosts=$(scontrol show hostnames $1)
for host in ${hosts}
do
  echo "$(date): Starting ${host}" &>> ${LOGFILE}
  instance_id=`python /usr/local/bin/createCustomInstance.py ${host}`
  echo "$(date):   Started ${host}" &>> ${LOGFILE}
  sleep 2
done

sleep 5m

for host in ${hosts}
do
  echo "$(date): Starting ${host}" &>> ${LOGFILE}
  scontrol update nodename=${host} nodehostname=${host} state=Resume
done
