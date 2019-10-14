#!/bin/bash
#yum source
cd /etc/yum.repos.d/
 echo -e  "[localdisk]\nname=local disk Centos7\nbaseurl=file:///mnt\nenabled=1\ngapcheck=0 " > localdisk.repo 
echo -e "[epel]\nname=Extra Packages for Enterprise Linux 7 - \$basearch\nbaseurl=https://mirrors.aliyun.com/pub/epel/7/\$basearch\nmetalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=\$basearch\nfailovermethod=priority\nenabled=1\ngpgcheck=0" > epel.repo
echo -e "[base]\nname=tuna.tsinghua.disk\nbaseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/\ngpgcheck=0\n" > tuna.tsinghua.repo
#firewlld 
setenforce 0
systemctl stop firewalld 
systemctl disable firewalld
sed  -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config 
#IP
echo -e "TYPE=Ethernet\nBOOTPROTO=static\nNAME=ens33\nDEVICE=ens33\nONBOOT=yes\nIPADDR=192.168.193.$2\nGATEWAY=192.168.193.2\nDNS1=114.114.114.114 " > /etc/sysconfig/network-scripts/ifcfg-ens33
ifdown ens33;ifup ens33
hostname $1
hostnamectl set-hostname $1
#yum
yum -y install vim
yum -y install bash-completion
echo "set ts=4 " >> /etc/virmc
