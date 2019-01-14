Library level - MPI
===================

In order to test the scalability of the system, OpenMPI
support was added to the cluster. OpenMPI is a library for
message passing that allows running tasks across multiple
nodes. OpenMPI was installed on the shared file system and
the configuration steps for creating new nodes were changed
to add OpenMPI to the PATH and LD LIBRARY PATH.

Because OpenMPI uses random port numbers for all its
communication, a new policy was added to the virtual
cloud network that allows all nodes on that subnetwork to
communicate with each other through any port. Moreover, the
firewall configuration for the nodes was edited to open up all
ports.cCommands added to initialization script::

    firewall-cmd --permanent --add-port=0-65535/tcp
    firewall-cmd --add-port=0-65535/tcp


Example running MPI program::

    [codrin@mgmt example1]$ sbatch mpi_submit
    Submitted batch job 73
    #After some time#
    [codrin@mgmt example1]$ cat slurm-73.out
    start
    end
    Hello, world; from host compute006: process 1 of 8
    Hello, world; from host compute006: process 0 of 8
    Hello, world; from host compute008: process 5 of 8
    Hello, world; from host compute008: process 4 of 8
    Hello, world; from host compute009: process 7 of 8
    Hello, world; from host compute009: process 6 of 8
    Hello, world; from host compute007: process 3 of 8
    Hello, world; from host compute007: process 2 of 8
