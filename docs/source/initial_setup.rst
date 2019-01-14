Initial Setup
=============

The Cluster in the Cloud platform is used to first set-up
a cluster with one management node and no compute nodes.
This uses a Terraform script to create and provision the nodes,
file system and virtual cloud network. Next, the login node is set-up using an Ansible
script. Ansible automates the process of installing software,
connecting the node to the file system, opening up ports and
starting processes.
