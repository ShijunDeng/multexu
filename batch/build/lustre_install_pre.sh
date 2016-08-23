#!/bin/bash
# POSIX
#
#description:    pre-setting:selinux client-aliveinterval 
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-24
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

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config;
print_message "MULTEXU_INFO" "set SELINUX=disabled"

chkconfig iptables off;
print_message "MULTEXU_INFO" "disable iptables firewall... "
service iptables stop
print_message "MULTEXU_INFO" "service iptables stoped ..."

#yum clean metadata 
#yum clean dbcache  
#yum makecache

echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config

clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
print_message "MULTEXU_INFO" "leave directory $( dirname "${BASH_SOURCE[0]}" )"
