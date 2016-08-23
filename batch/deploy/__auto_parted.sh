#!/bin/bash
# POSIX
#
#description:    parted a dev automatically
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

devname=$1 #设备名称
start= #分区索引号

start=`parted ${devname} print free |awk '$0 ~ /Free Space/ {print $1}' | tail -1` #分区索引号

if [ ! -n "${start}" ]; then
	start="0G"
fi
#parted -s ${devname} mkpart primary ${start} 100%
parted -s ${devname} mkpart logical ${start} 100%
#获取本机ip 并安装一定格式处理
ip=`ifconfig | grep "inet addr:" | grep -v "127.0.0.1" | cut -d: -f2|awk '{print $1}'`
print_message "MULTEXU_INFO" "node[${ip}] executing command: parted -s ${devname} mkpart logical ${start} 100% ..."

clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
