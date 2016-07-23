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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMgahnqfjK4CJhYEUDBcinDgxiDvpr0FNZfixLQQipYo9kq1LLABaq4IbnHLjWKM9/IBvvvf8GpknhldoJ2edD1gHxCzpFXBwOTr+lLXlR+hZrq7OyDFsjKcsc2f5/9YUoB7AKgvW4Kp9AqTiYXKMZrwZfAWTNNHZKWzDxemEF9xVZfXFHCOULnB+SF9b6d6pzkDMgGFqaOrFKu7nyJRNKndG2tvnB7eyub6+Szci27KEiqKpo9bCPixD2EbdzsK9LDV+4TfT9wDwycLu6qGIspNdwoTVXnzXI+yXNZB3Lmutf287yFo2BX0Aj4YKmA0AJLG73o7jATl6aKqJrIoDZ root@localhost.localdomain" >> /root/.ssh/authorized_keys
