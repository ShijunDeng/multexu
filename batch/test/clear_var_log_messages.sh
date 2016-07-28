#!/bin/bash
# POSIX
#
#description:    clear logs
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-19
#


VAR_LOG_DIR="/var/log"
count=0
count_limit=$1
if [ ! -n ${count_limit} ]; then 
	count_limit=48
fi

while [[ count -lt ${count_limit} ]]
do
        echo '' > ${VAR_LOG_DIR}/messages
	echo "the ${count} time clear ${VAR_LOG_DIR}/messages"
        let count+=1
        sleep 3600s
done

