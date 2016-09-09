#!/bin/bash
# POSIX
#
#description:    configure client node automatically
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-25
#
#initialization
cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f ../ctrl/__init.sh ]; then
        echo "MULTEXU Error:multexu initialization failure:cannot find the file __init.sh... "
        exit 1
else
        source ../ctrl/__init.sh
fi

source "${MULTEXU_BATCH_CRTL_DIR}"/multexu_lib.sh #调入multexu库
mnt_position=
mgsnode=

while getopts 's:m:' opt;
do
    case $opt in
        s)
                mgsnode=$OPTARG;;
        m)
                mnt_position=$OPTARG;;
    esac
done

if [ ! -d "/mnt/${mnt_position}" ]; then
    mkdir /mnt/${mnt_position}
fi

ip=`ifconfig|grep "inet addr:"|grep -v "127.0.0.1"|cut -d: -f2|awk '{print $1}'`
print_message "MULTEXU_INFO" "client [${ip}] mount -t lustre ${mgsnode}@tcp:/lustrefs /mnt/${mnt_position}"
mount -t lustre ${mgsnode}@tcp:/lustrefs /mnt/${mnt_position}
wait
clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
exit 0

