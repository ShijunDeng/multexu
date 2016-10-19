#!/bin/bash
# POSIX
#
#description:    configure Lustre Monitoring Tool management node automaticlly
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-10-19
#
#initialization

sleeptime=60 #设置检测的睡眠时间
limit=10 #递减下限
limit=10 #递减下限


sleeptime=60 #设置检测的睡眠时间
limit=10 #递减下限

cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f ../ctrl/__init.sh ]; then
	echo "MULTEXU Error:initialization failure:cannot find the file __init.sh... "
	exit 1
else
	source ../ctrl/__init.sh
	echo 'MULTEXU INFO:initialization completed...'
	`${PAUSE_CMD}`
fi
source "${MULTEXU_BATCH_CRTL_DIR}"/multexu_lib.sh #调入multexu库

cd "${MULTEXU_SOURCE_DIR}"/lmt
print_message "MULTEXU_INFO" "enter directory ${MULTEXU_SOURCE_DIR}/lmt..."

