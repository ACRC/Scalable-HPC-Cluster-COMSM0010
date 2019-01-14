#!/bin/sh

yum install -y nfs-utils
yum install -y gcc-c++
mkdir -p /mnt/shared
mount 10.1.0.56:/shared /mnt/shared
useradd slurm -u 1001 --home /home/slurm
useradd codrin -u 1002 --home /mnt/shared/home/codrin
useradd dan -u 1003 --home /mnt/shared/home/dan
cd /mnt/shared/
yum-config-manager --add-repo file:/mnt/shared/apps/slurm/RPMS/x86_64
yum install -y --nogpgcheck slurm-slurmd slurm-libpmi munge
mkdir /etc/slurm
mkdir /var/log/slurm/
mkdir /var/spool/slurmd
chown slurm:slurm /var/spool/slurmd
cat << EOF > /etc/slurm/slurm.conf
ClusterName=cluster
ControlMachine=mgmt

SlurmUser=slurm
SlurmctldPort=6817
SlurmdPort=6818
AuthType=auth/munge
StateSaveLocation=/var/spool/slurm
ProctrackType=proctrack/cgroup
#Prolog=
#Epilog=
#SrunProlog=
#SrunEpilog=
#TaskProlog=
#TaskEpilog=
TaskPlugin=task/cgroup
#UsePAM=

# TIMERS
SlurmctldTimeout=300
SlurmdTimeout=300
MinJobAge=300

# SCHEDULING
SchedulerType=sched/backfill
#SchedulerAuth=
SelectType=select/cons_res
SelectTypeParameters=CR_CPU_Memory

# LOGGING
SlurmctldLogFile=/var/log/slurm/slurmctld.log
SlurmdLogFile=/var/log/slurm/slurmd.log

include /mnt/shared/apps/slurm/slurm.conf

EOF
touch /tmp/hello0
cp /mnt/shared/munge.key /etc/munge/munge.key
chown munge:munge /etc/munge/munge.key
systemctl start munge

touch /tmp/hello1
cat << EOF > /etc/slurm/cgroup.conf
CgroupAutomount=yes
EOF
touch /tmp/hello2
setenforce 0
systemctl restart dbus
systemctl restart firewalld
firewall-cmd --permanent --add-port=6817-6818/tcp
firewall-cmd --add-port=6817-6818/tcp
touch /tmp/hello3
touch /tmp/hello4
systemctl start slurmd
touch /tmp/hello5
