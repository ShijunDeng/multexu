#!/bin/sh
# POSIX
#
#description:    install the slurm automaticlly
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-19
#
#initialization
cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f ../ctrl/__init.sh ]; then
	echo "MULTEXU Error:initialization failure:cannot find the file __init.sh... "
	exit 1
else
	source ../ctrl/__init.sh
	echo 'MULTEXU INFO:initialization completed...'
	`${PAUSE_CMD}`
fi

print_message "MULTEXU_INFO" "### Now begin the installation procedure###"

print_message "MULTEXU_INFO" "Entering directory '${MULTEXU_SOURCE_DIR}'"
cd ${MULTEXU_SOURCE_DIR}

print_message "MULTEXU_INFO" "installing dependencies..."
`${PAUSE_CMD}`
yum install wget gcc gcc-c++ make kernel-devel kernel-headers perl rpm-build -y
yum install hwloc hwloc-devel numactl readline-devel mysql-devel pam-devel perl-ExtUtils-MakeMaker rrdtool freeipmi lua-devel gtk2-devel redhat-lsb redhat-rpm-config flex-devel bzip2-devel -y
yum install bison flex expect -y

print_message "MULTEXU_INFO" "installing blcr..."
`${PAUSE_CMD}`
rpmbuild -tb --define 'with_multilib 0' blcr*
print_message "MULTEXU_INFO" "Entering directory '/root/rpmbuild/RPMS/x86_64/'"
`${PAUSE_CMD}`
cd /root/rpmbuild/RPMS/x86_64/
yum install blcr* --nogpgcheck -y

print_message "MULTEXU_INFO" "Entering directory '${MULTEXU_SOURCE_DIR}'"
cd ${MULTEXU_SOURCE_DIR}
print_message "MULTEXU_INFO" "installing munge..."
`${PAUSE_CMD}`
rpmbuild -tb --clean munge*
print_message "MULTEXU_INFO" "Entering directory '/root/rpmbuild/RPMS/x86_64/'"
cd /root/rpmbuild/RPMS/x86_64/
`${PAUSE_CMD}`
yum install munge* -y

print_message "MULTEXU_INFO" "produce munge.key,it may take a long time,please wait patiently...."
dd if=/dev/random bs=1 count=1024 > /etc/munge/munge.key

print_message "MULTEXU_INFO" "Entering directory '${MULTEXU_SOURCE_DIR}'"
cd ${MULTEXU_SOURCE_DIR}

print_message "MULTEXU_INFO" "installing slurm..."
`${PAUSE_CMD}`
rpmbuild -tb --with mysql --with blcr slurm*
print_message "MULTEXU_INFO" "'Entering directory '/root/rpmbuild/RPMS/x86_64/'"
cd /root/rpmbuild/RPMS/x86_64/
`${PAUSE_CMD}`
yum install slurm* -y

print_message "MULTEXU_INFO" "Entering directory '${MULTEXU_SOURCE_DIR}'"
cd ${MULTEXU_SOURCE_DIR}

print_message "MULTEXU_INFO" "installing IO-Watchdog..."
`${PAUSE_CMD}`
rpmbuild -tb io-watchdog*
print_message "MULTEXU_INFO" "Entering directory '/root/rpmbuild/RPMS/x86_64/'"
cd /root/rpmbuild/RPMS/x86_64/
`${PAUSE_CMD}`
yum install io* -y

print_message "MULTEXU_INFO" "### finished installation procedure###"
