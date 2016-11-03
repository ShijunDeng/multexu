# ASCAR TOOL
@(ASCAR TOOL)[ASCAR TOOL|HELP|ASCAR]

**ASCAR TOOL**是特别针对ASCAR设计的自动安装、部署、测试和控制的工具套件，包括以下功能：
 
- **认证** ：在一个局域网,在其中指定一台主机做为管理机,其它主机做为被管理机,为以后维护的便利性,要求实现管理机无需密码,直接登录被管理机；
- **安装** ：安装lustre文件系统，包括进行改进的补丁；
- **部署** ：部署lustre文件系统；
- **统一控制** ：采用MULTEXU基础套件进行统一管理控制的工具；
- **测试** ：自动测试；

-------------------

[DOCUMENT]

# AutoLustre2.4.0 TOOL设计

> AutoLustre2.4.0 TOOL 主要是采用shell script编写的自动化控制套件
## 架构

	AutoLustre2.4.0
	├── batch
	│   ├── authorize
	│   │   ├── distribute.sh
	│   │   ├── execuse.sh
	│   │   ├── nodes_authorize.sh
	│   │   ├── nodes_authorize.sh.origin
	│   │   └── start_authorize.sh
	│   ├── build
	│   │   ├── auto_lustre2.4.0_install.sh
	│   │   ├── auto_slurm_install.sh
	│   │   ├── lustre_install_client.sh
	│   │   ├── lustre_install_newkernel.sh
	│   │   ├── lustre_install_pre.sh 禁用SELinux、关闭防火墙等预操作
	│   │   ├── lustre_install_server.sh
	│   │   └── munge_cfg.sh
	│   ├── config
	│   │   ├── nodes_all.out
	│   │   ├── nodes_authorize.out
	│   │   ├── nodes_client.out
	│   │   ├── nodes_oss.out
	│   │   └── nodes_server.out
	│   ├── ctrl
	│   │   ├── help_doc.txt
	│   │   ├── __init.sh
	│   │   ├── multexu_lib.sh
	│   │   ├── multexu.sh
	│   │   └── multexu_ssh.sh
	│   ├── deploy
	│   │   ├── auto_lustre2.4.0_deploy.sh
	│   │   ├── __auto_parted.sh
	│   │   ├── __configure_clientnode.sh
	│   │   ├── __configure_mdsnode.sh
	│   │   ├── __configure_ossnode.sh
	│   │   └── _configure_ossnode.sh
	│   └── test
	│       ├── auto_test_fio.sh
	│       ├── clear_var_log_messages.sh
	│       ├── fio_install.sh
	│       ├── _test_exe.sh
	│       └── testResult
	└── source
## 功能说明
	AutoLustre2.4.0
	├── batch：脚本
	│   ├── authorize：认证
	│   ├── build：安装
	│   ├── config：ip配置文件
	│   ├── ctrl：MULTEXU工具套件，统一控制
	│   ├── deploy：部署
	│   └── test：测试
	└── source：AutoLustre2.4.0 tool用到的rpm包、资源文件


# AutoLustre2.4.0 TOOL使用

##使用authorize认证
>说明：在一个局域网,在其中指定一台主机做为管理机,其它主机做为被管理机,为以后维护的便利性,要求实现管理机无需密码,直接登录被管理机；假设指定controller作为控制节点，通过shell脚本,实现一次执行,批量配置管理机与被管理机的信任关系,实现管理机免密码登录被管理机。
使用步骤：


    1. 在config文件的nodes_authorize.out中配置好要管理的主机的ip地址，一个ip占据一行，不要包括其它任何无关信息；
    2. 运行 sh start_authorize.sh，根据提示操作
		[root@CentOS1 authorize]# sh ClientAuthorize.sh
		Generating public/private rsa key pair.
		#type Enter directly
		Enter file in which to save the key (/root/.ssh/id_rsa):
		Created directory '/root/.ssh'.
		#type Enter directly,make empty passward
		Enter passphrase (empty for no passphrase):
		Enter same passphrase again:
		Your identification has been saved in /root/.ssh/id_rsa.
		Your public key has been saved in /root/.ssh/id_rsa.pub.
		The key fingerprint is:
		6d:bc:5c:f8:32:bf:ee:4a:fe:bf:be:76:8d:29:38:aa root@CentOS1
		The key's randomart image is:
		|                 |
		|                 |
		|                 |
		|         o .     |
		|        S = .    |
		|         o +     |
		|          *..  o.|
		|         oo+. + o|
		|      E...o***=+ |
		#the warning occurs because of the option StrictHostKeyChecking=no,just ignore it
		Warning: Permanently added '192.168.10.3' (RSA) to the list of known hosts.
		#Because trust has not yet been established, so still need a password
		root@192.168.122.101's password:
		ServerAuthorize.sh                                                                            100%  664     0.7KB/s   00:00
		Warning: Permanently added '192.168.10.4' (RSA) to the list of known hosts.
		root@192.168.122.102's password:
		ServerAuthorize.sh                                                                            100%  664     0.7KB/s   00:00
		Warning: Permanently added '192.168.10.5' (RSA) to the list of known hosts.
		root@192.168.122.103's password:
		ServerAuthorize.sh                                                                            100%  664     0.7KB/s   00:00
		#Start, after the completion of distribution in each managed machine configuration script execution
		root@192.168.122.101's password:
		root@192.168.122.102's password:
		root@192.168.122.103's password:

##使用build安装
>说明：build主要进行安装操作，只需要运行auto_lustre2.4.0_install.sh即可，其它脚本均为自动调用

    sh auto_lustre2.4.0_install.sh
##使用deploy安装
>说明：自动部署文件系统，用法实例

	sh deploy/auto_lustre2.4.0_deploy.sh --mdsnode=192.168.122.140 --devname=/dev/sda

- mdsnode为mdsnode服务器的ip地址
- devname设备名称，将在该设备上格式化进行文件系统安装
- 另外，还需要在config文件夹下进行相关的ip地址配置

	nodes_client.out:所有client端的ip地址，一个ip占据一行
	nodes_oss.out：所有oss端的ip地址，一个ip占据一行
	nodes_server.out：oss && mdsnode一起的ip地址，一个ip占据一行
##使用test测试
>说明：进行测试，可以根据需要修改auto_test_fio.sh中的参数配置，详细见auto_test_fio.sh中的注释

	sh auto_test_fio.sh
##使用MULTEXU进行统一控制
>说明：为便于测试过程中的管理中的管理，使用MULTEXU进行统一控制，具体使用方法见[MULTEXU](https://github.com/ShijunDeng/multexu)

## 反馈与建议
- QQ：946057490
- 邮箱：<dengshijun1992@gmail.com>

---------
感谢阅读这份帮助文档。