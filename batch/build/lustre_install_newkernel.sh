#!/bin/bash
# POSIX
#
#description:    install lustre new kernel
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-24
#initialization
cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f ../ctrl/__init.sh ]; then
        echo "MULTEXU Error:multexu initialization failure:cannot find the file __init.sh... "
        exit 1
else
        source ../ctrl/__init.sh
fi

source "${MULTEXU_BATCH_CRTL_DIR}/multexu_lib.sh"                                                                     

echo "MULTEXU INFO:install dependencies..."                                       
echo "MULTEXU INFO:enter directory $( dirname "${BASH_SOURCE[0]}" )..."

`${PAUSE_CMD}`

yum -y groupinstall "Development Tools"
wait
yum -y install xmlto asciidoc elfutils-libelf-devel zlib-devel binutils-devel newt-devel python-devel hmaccalc perl-ExtUtils-Embed bison elfutils-devel audit-libs-devel  kernel-devel
wait
echo "MULTEXU INFO:finished installing dependencies..."

`${PAUSE_CMD}`

cd "${MULTEXU_SOURCE_DIR}"
echo "MULTEXU INFO:enter directory ${MULTEXU_SOURCE_DIR}..."
rpm -e --nodeps `rpm -qa | grep  kernel-firmware`
wait
rpm -Uvh kernel-firmware-2.6.32?*lustre?*
wait

rpm -e --nodeps `rpm -qa | grep  bfa-firmware`
wait
rpm -Uvh bfa-firmware?*noarch?*
wait

echo "MULTEXU INFO:install kernel,it may take a long time,please wait patiently..."
rpm -ivh kernel-2.6.32-358.6.2.el6_lustre?*.rpm -f --oldpackage
wait

clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
echo "MULTEXU INFO:leave directory $( dirname "${BASH_SOURCE[0]}" )"

`${PAUSE_CMD}`

