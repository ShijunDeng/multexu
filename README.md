<p align="center">
    <img src="https://github.com/ShijunDeng/multexu/blob/master/private/images/logo.png">
</p>

multexu - A muxmulti-node execution tool
=========================
[![TeamCity CodeBetter](https://img.shields.io/teamcity/codebetter/bt428.svg?maxAge=2592000)]()
[![Packagist](https://img.shields.io/packagist/v/symfony/symfony.svg?maxAge=2592000)]()
[![Yii2](https://img.shields.io/badge/Powered_by-multexu Framework-green.svg?style=flat)]()
![Progress](http://progressed.io/bar/40?title=completed )

**multexu** is an open source, fault-tolerant, and highly scalable cluster control and execution system for large and small Linux clusters,ie. muxmulti-node execution tool. With multexu,the work of development and managine in multi-node environment will be much more easily.

---
##usage
We assume that one master node as controller, the tool will run in master node.

(1).Configuring the file batch/config/nodes_authorize.out,note that one host ip occur on a single line.For example:
      192.168.122.101
      192.168.122.102
      192.168.122.103
(2).Runing the file authorize/start_authorize.sh.command:

      sh file authorize/start_authorize.sh
  then you will see these as bellow:
  
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

then wait for rebooting (nodes 192.168.122.101-192.168.122.103)

(3)now you can use mutlexu,run:

      sh ctrl/multexu.sh -h  sh ctrl/multexu.sh --help
  to get help document

##Feedback and Suggestions
- Any questions,contact <dengshijun1992@gmail.com>.please click here and send
  
***
Thank you for reading this document.
