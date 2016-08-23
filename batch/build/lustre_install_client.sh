#!/bin/bash
# POSIX
#
#description:    install lustre client
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
                                                                     
print_message "MULTEXU_INFO" "install dependencies..."                                       
cd "${MULTEXU_SOURCE_DIR}"
echo "MULTEXU INFO:enter directory ${MULTEXU_SOURCE_DIR}..."

yum install -y w3m
# download the server RPMs
##mkdir -p ~/lustre-rpm/server/RPMS; cd ~/lustre-rpm/server/RPMS
##w3m https://downloads.hpdd.intel.com/public/lustre/lustre-2.4.0/el6/server/RPMS/x86_64/ -dump | grep rpm | awk '{print $3}' | xargs -n 1 -I{} wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.4.0/el6/server/RPMS/x86_64/{}
# download the server SRPMs
##mkdir -p ~/lustre-rpm/server/SRPMS; cd ~/lustre-rpm/server/SRPMS
##w3m https://downloads.hpdd.intel.com/public/lustre/lustre-2.4.0/el6/server/SRPMS -dump | grep rpm | awk '{print $3}' | xargs -n 1 -I{} wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.4.0/el6/server/SRPMS/{}

#cd ~/lustre-rpm/server/RPMS

ls | grep -v zfs | xargs yum localinstall -y
yum -y install xmlto asciidoc elfutils-libelf-devel zlib-devel binutils-devel newt-devel python-devel hmaccalc perl-ExtUtils-Embed bison elfutils-devel audit-libs-devel
wait
rpm -ivh lustre-client-modules?*.rpm --nodeps --force
wait
rpm -ivh lustre-client-2.4?*.rpm --nodeps --force
wait
rpm -ivh lustre-modules* --nodeps --force
wait
#加载模块
modprobe lustre
wait
clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
print_message "MULTEXU_INFO" "leave directory $( dirname "${BASH_SOURCE[0]}" )..."
`${PAUSE_CMD}`
exit 0
###############################################################################################################
#
#这里直接采用已经编译好的包ascar-lustre-client rpm包安装client，下面的步骤是编译该rpm包的步骤
#注意，截至2016年07年27日，采用https://github.com/mlogic/ascar-lustre-2.4-client 上的步骤以及
#文件需要做以下修改，否则会报错:
#1.采用"./configure --disable-server"命令，其它的不要禁用，否则会因缺失一些需要的文件而报错;
#2.修改ascar-lustre-2.4-client/lustre/include/Makefile.am文件,EXTRA_DIST变量要包含 ascar.h文件
#  否则make rpms会报错;
#
###############################################################################################################

tar -jxv -f ascar-lustre-2.4-client.tar.bz2 -C ./
wait
cd ascar-lustre-2.4-client/

sh autogen.sh
wait
ln -s /usr/src/kernels/2.6.32-573.el6.x86_64/ /usr/src/linux
wait
#
#这里在官网的基础上做些修改才行  否则报错
#
./configure --disable-server 
wait
make -j4
wait
make rpms
wait

cd /root/rpmbuild/RPMS/x86_64/
print_message "MULTEXU_INFO" "enter directory /root/rpmbuild/RPMS/x86_64/..."
`${PAUSE_CMD}`
rpm -ivh lustre-client-modules?*.rpm --nodeps --force
wait
rpm -ivh lustre-client-2.4?*.rpm --nodeps --force
wait
rpm -ivh lustre-modules* --nodeps --force
wait
#加载模块
modprobe lustre
wait
clear_execute_statu_signal
send_execute_statu_signal "${MULTEXU_STATUS_EXECUTE}"
print_message "MULTEXU_INFO" "leave directory $( dirname "${BASH_SOURCE[0]}" )..."
`${PAUSE_CMD}`
