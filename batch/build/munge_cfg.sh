#!/bin/sh
# POSIX
#
#description:    set the permissions
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-19
#

echo "Now start to configure munge..."

#useradd munge

mkdir /etc/munge
mkdir /var/run/munge
mkdir /var/lib/munge
mkdir /var/log/munge

chmod -Rf 700 /etc/munge
chmod -Rf 711 /var/lib/munge
chmod -Rf 700 /var/log/munge
chmod -Rf 0755 /var/run/munge

chown slurm:slurm /etc/munge
chown slurm:slurm  /var/run/munge
chown slurm:slurm  /var/lib/munge
chown slurm:slurm  /var/log/munge

chown slurm:slurm /etc/munge/munge.key

#scp /etc/munge/munge.key root@192.168.122.102:/etc/munge/
#scp /etc/munge/munge.key root@192.168.122.103:/etc/munge/

echo "finished configuring munge..."
