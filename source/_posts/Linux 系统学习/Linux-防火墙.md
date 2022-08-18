1.redhat7 中使用了 firewalld 代替了原来的 iptables

查看防火墙状态：systemctl status firewalld
启动防火墙：systemctl start firewalld
停止防火墙：systemctl stop firewalld

2.防火墙常用命令：
  设置黑/白名单
  firewall-cmd --permanent --zone=trusted --add-source=ip  执行结果success
  重新加载配置
  firewall-cmd --reload  执行结果success
  列出白名单
  firewall-cmd --permanent --zone=trusted --list-sources  执行结果所有的ip
  删除所有
  firewall-cmd --zone=drop --list-all  需要重新加载配置
  删除指定
  firewall-cmd --permanent --zone=drop --remove-source=ip 需要重新加载配置

1、在 RHEL7 之前的版本中关闭防火墙等服务的命令是

service iptables stop

/etc/init.d/iptables stop

2、RHEL7开始，使用systemctl工具来管理服务程序，包括了service和chkconfig

systemctl list-unit-files|grep enabled
