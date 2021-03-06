#!/bin/bash
# POSIX
#
#description:    install lustre server
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

source "${MULTEXU_BATCH_CRTL_DIR}"/multexu_lib.sh #调入multexu库
                                                                     
echo "MULTEXU INFO:install dependencies..."                                       
cd "${MULTEXU_SOURCE_DIR}"
echo "MULTEXU INFO:enter directory ${MULTEXU_SOURCE_DIR}..."

rpm -ivh lustre-modules*
wait
rpm -e --nodeps `rpm -qa | grep  libcom_err`
wait
rpm -Uvh libcom_err*
wait

rpm -e --nodeps `rpm -qa | grep   e2fsprogs-libs`
wait
rpm -Uvh  e2fsprogs-libs*
wait

rpm -e --nodeps `rpm -qa | grep  e2fsprogs-[^lib]*`
wait
rpm -Uvh e2fsprogs-[^lib]*
wait

rpm -ivh lustre-ldiskfs*
wait
rpm -ivh lustre-osd-ldiskfs-2.4.0*
wait

rpm -ivh lustre-2.4.0*
wait
clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
echo "MULTEXU INFO:leave directory $( dirname "${BASH_SOURCE[0]}" )..."

`${PAUSE_CMD}`
