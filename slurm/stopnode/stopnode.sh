#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

LOGFILE=/home/slurm/elastic.log

hosts=$(scontrol show hostnames $1)
for host in ${hosts}
do
  echo "$(date): Terminating ${host}" &>> ${LOGFILE}
  instance_id=$(/opt/oci-cli/bin/oci compute instance list --compartment-id="ocid1.compartment.oc1..aaaaaaaa6u2o5avo46qt6oa2giscsuwwe2xa7k3qmjcwmtjrsc2ldkm2u6vq" | jq --raw-output '.data[] | select(."display-name" == "'${host}'") | select(."lifecycle-state" != "TERMINATED") | .id')
  if /opt/oci-cli/bin/oci compute instance terminate --force --instance-id="${instance_id}"  ; then
    echo "$(date):   Terminated ${host}" &>> ${LOGFILE}
  else
    echo "$(date):   Failed to terminate ${host}" &>> ${LOGFILE}
  fi
done
