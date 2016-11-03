#!/bin/bash
# POSIX
#
#description:    compile-->install-->deploy lustre 2.8.0 automaticlly
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-11-02
#
#initialization

sleeptime=60 #设置检测的睡眠时间
limit=10 #递减下限

cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f __init.sh ]; then
	echo "MULTEXU Error:initialization failure:cannot find the file __init.sh... "
	exit 1
else
	source ./__init.sh
	echo 'MULTEXU INFO:initialization completed...'
	`${PAUSE_CMD}`
fi

source "${MULTEXU_BATCH_CRTL_DIR}/multexu_lib.sh"

print_message "MULTEXU_INFO" "Now start to compile-->install-->deploy lustre 2.8.0 ..."

#基准目录
base_dir=${MULTEXU_BASE_DIR}
#编译节点
compile_node_ip=192.168.122.101
#当前节点ip
current_node_ip=192.168.122.181
#lustre部署信息
mdsnode=192.168.122.15
devname=/dev/vda 
devindex=7

print_message "MULTEXU_INFO" "Now start to prepare compiling files..."
virsh shutdown centos7.0-c1
virsh shutdown centos7.0-c2
virsh shutdown centos7.0-c3
virsh shutdown centos7.0-c4
virsh shutdown centos7.0-c5
virsh shutdown centos7.0-c6
virsh shutdown centos7.0-c7
sleep ${sleeptime}s
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c1.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c2.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c3.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c4.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c5.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c6.qcow2 /home/ca21/Downloads/
wait
echo yes | cp /home/ca21/DevelopmentFiles/centos7-c7.qcow2 /home/ca21/Downloads/
wait
virsh start  centos7.0-c1
virsh start  centos7.0-c2
virsh start  centos7.0-c3
virsh start  centos7.0-c4
virsh start  centos7.0-c5
virsh start  centos7.0-c6
virsh start  centos7.0-c7
sleep 120s

#删除旧文件
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="rm -rf ${base_dir}/Fdm-LustreQoS"
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd='rm -rf /root/kernel/rpmbuild/BUILD/lustre-2.8.0/*'
rm -f ${MULTEXU_SOURCE_DIR}/install/lustre-*
`${PAUSE_CMD}`
`${PAUSE_CMD}`

#传送新文件到编译节点上
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --sendfile=${base_dir} --location="$( cd "${base_dir}" && cd ../ && pwd )"
sleep ${sleeptime}s

#
#在编译节点上进行编译过程
#这里需要注意的是：不包括编译内核的过程
#编译lustre server
#清除信号量 避免干扰
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal"
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="sh ${MULTEXU_BATCH_BUILD_DIR}/build_lustre_server.sh --skip_install_dependency=1"
#等待server编译完成
ssh_check_singlenode_status ${compile_node_ip} "${MULTEXU_STATUS_EXECUTE}" ${sleeptime} ${limit}
print_message "MULTEXU_INFO" "the node ${compile_node_ip} finished to compile lustre-server..."


#复制编译生成的lustre server rpm包到指定目录
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="yes | cp /root/kernel/rpmbuild/BUILD/lustre-2.8.0/*.rpm ${MULTEXU_SOURCE_DIR}/install/ "
`${PAUSE_CMD}`
`${PAUSE_CMD}`

#编译lustre client
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal"
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="sh ${MULTEXU_BATCH_BUILD_DIR}/build_lustre_client.sh --skip_install_dependency=1"
#等待server编译完成
ssh_check_singlenode_status ${compile_node_ip} "${MULTEXU_STATUS_EXECUTE}" ${sleeptime} ${limit}
print_message "MULTEXU_INFO" "the node ${compile_node_ip} finished to compile lustre-client..."


#复制编译生成的lustre client rpm包到编译节点指定目录
print_message "MULTEXU_INFO" "Collecting files..."
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=${compile_node_ip} --cmd="yes | cp /root/kernel/rpmbuild/BUILD/lustre-2.8.0/*.rpm ${MULTEXU_SOURCE_DIR}/install/ "
print_message "MULTEXU_INFO" "Finished to collect files..."
`${PAUSE_CMD}`
`${PAUSE_CMD}`

#从编译节点compile_node_ip复制编译好的lustre rpm包回到当前节点 也即控制节点
scp root@${compile_node_ip}:${MULTEXU_SOURCE_DIR}/install/* ${MULTEXU_SOURCE_DIR}/install/
sleep ${sleeptime}s

#分发文件到各个节点
print_message "MULTEXU_INFO" "Distributing files to all nodes..."
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=nodes_all.out --sendfile=${base_dir} --location="$( cd "${base_dir}" && cd ../ && pwd )"
sleep 180s
print_message "MULTEXU_INFO" "Finished to distribute files..."

sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal
#安装lustre文件系统  不安装新内核
sh ${MULTEXU_BATCH_INSTALL_DIR}/auto_lustre2.8.0_install.sh --skip_install_kernel=1
#等待安装完成
while [[ $(cat ${EXECUTE_STATUS_SIGNAL}) != "${MULTEXU_STATUS_EXECUTE}" ]];
	do
		print_message "MULTEXU_INFO" "the current node is executing auto_lustre2.8.0_install.sh..."
		sleep ${sleeptime}s
done
print_message "MULTEXU_INFO" "the current node finished to execute auto_lustre2.8.0_install.sh..."

sleeptime=180
ssh_check_cluster_status "nodes_all.out" "${MULTEXU_STATUS_EXECUTE}" ${sleeptime} ${limit}
sleeptime=60

#设置printk级别 清除无用日志信息 方便输出调试信息
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=nodes_all.out --cmd='echo 8 > /proc/sys/kernel/printk'
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu.sh --iptable=nodes_all.out --cmd='dmesg --clear'

#部署文件系统
sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal
sh ${MULTEXU_BATCH_DEPLOY_DIR}/auto_lustre2.8.0_deploy.sh --mdsnode=${mdsnode} --devname=${devname} --devindex=${devindex}
#等待部署完成
while [[ $(cat ${EXECUTE_STATUS_SIGNAL}) != "${MULTEXU_STATUS_EXECUTE}" ]];
	do
		print_message "MULTEXU_INFO" "the current node is executing auto_lustre2.8.0_deploy.sh..."
		sleep ${sleeptime}s
done
print_message "MULTEXU_INFO" "the current node finished to execute auto_lustre2.8.0_deploy.sh..."

sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal
#安装lmt
sh ${MULTEXU_BATCH_LMT_DIR}/lmt_install.sh --mdsnode=${mdsnode}
while [[ $(cat ${EXECUTE_STATUS_SIGNAL}) != "${MULTEXU_STATUS_EXECUTE}" ]];
	do
		print_message "MULTEXU_INFO" "the current node is executing lmt_install.sh..."
		sleep ${sleeptime}s
done
print_message "MULTEXU_INFO" "the current node is finished to execute lmt_install.sh..."

sh ${MULTEXU_BATCH_CRTL_DIR}/multexu_ssh.sh  --clear_execute_statu_signal
print_message "MULTEXU_INFO" "Process compile-->install-->deploy lustre 2.8.0 finished..."

