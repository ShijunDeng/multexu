# vim ClientAuthorize.sh
#!/bin/bash
#
#description:   a simple uniform tools for authorization
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-07-20
#

#声明环境变量
export PATH="/usr/lib/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
export LANG="en_US.UTF-8"

#检查所需目录及文件,如果没有就创建一个
if [ ! -d /root/.ssh ];then
	mkdir /root/.ssh
fi

if [ ! -f /root/.ssh/authorized_keys ];then
	touch /root/.ssh/authorizedzz_keys
fi

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config;
echo "MULTEXU INFO:set SELINUX=disabled"

#设置被管理机的相关目录文件权限
chmod go-w /root
chmod 700 /root/.ssh
chmod 600 /root/.ssh/*
 
#set authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFUStU49g/F3LDYVilLXwwmtafq3bX6i8/ZQWPLEgZOVNM4iJaETS7PrjxLMsbCGRGDmikaa4LMKApHaNFPmPHmz8lJbPmriskFQsK+T9GqFWDRoqx80CB8Tn98AlxBx7yqJfxdkAmbfASmjICbB616CBy3+n5g3sYhfoARYBiKCZfW1QHq1XN1G5MC6pSOCe9U0q7E/0pRP5UMYZzoqtY9SL+0cei2QHNZ3aTMZdCAPquCfp/4ICLEO51ghPUV6QdVh2wqdEK3s5OszdpOVtrpiDi4xAcfDeCjHM+3kaOrQDHuCLLNukX2Vv9G+hVntmT3gC3n8Ap4nBa6lYWRJzx root@localhost.localdomain" >> /root/.ssh/authorized_keys
