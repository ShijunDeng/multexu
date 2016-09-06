#!/bin/bash
# POSIX
#
#description:    build lustre 2.8.0 automaticlly [lustre]
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-09-01
#
#initialization

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

source "${MULTEXU_BATCH_CRTL_DIR}/multexu_lib.sh"
#
#if you login in the system as root, after this command,then you will enter /root directory
#
cd $HOME

BUILD_BASE_DIR="$HOME""/kernel/rpmbuild"

#grep -Ri 'intel' /usr
#rpm -ivh $PKG_PATH/kernel-*.rpm

#/sbin/new-kernel-pkg --package kernel --mkinitrd --dracut --depmod --install 2.6.32.431.5.1.el6_lustre

#reboot

cd "${BUILD_BASE_DIR}"/BUILD/lustre-2.8.0/
#注意--with-linux指定的位置
./configure --with-linux="${BUILD_BASE_DIR}"/BUILD/kernel-3.10.0_3.10.0_327.3.1.el7_lustre.x86_64/
make rpms -j8
print_message "MULTEXU_INFO" "finished to make rpms (all) ..."


