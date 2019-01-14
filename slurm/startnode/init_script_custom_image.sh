#!/bin/sh

touch /tmp/hello
mount 10.1.0.56:/shared /mnt/shared
systemctl start munge

touch /tmp/hello1

useradd dan -u 1003 --home /mnt/shared/home/dan

touch /tmp/hello2
setenforce 0
systemctl restart dbus
systemctl restart firewalld
firewall-cmd --permanent --add-port=6817-6818/tcp
firewall-cmd --add-port=6817-6818/tcp
firewall-cmd --permanent --add-port=0-65535/tcp
firewall-cmd --add-port=0-65535/tcp
touch /tmp/hello3
touch /tmp/hello4
systemctl start slurmd
touch /tmp/hello5
