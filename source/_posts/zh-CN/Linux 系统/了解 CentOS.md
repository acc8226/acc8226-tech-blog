查看版本信息

```sh
cat /etc/centos-release
```

或者

```sh
cat /etc/redhat-release
```

## yum 命令

安装但是会检测依赖

```sh
sudo rpm -Uvh <rpm package name>
```

如果遇到“错误：依赖检测失败”的问题则可以在安装命令后加两个参数 --nodeps --force，即安装时不再分析包之间的依赖关系而直接安装。

查看 .rpm 依赖

```sh
rpm -qpR <rpm package name>
```

卸载包

```sh
yum remove tomcat
```

## rpm 命令

(01)安装一个包：# rpm -ivh
(02) 升级一个包：# rpm -Uvh
(03) 移走一个包：# rpm -e
(04) 安装参数：
      --force 即使覆盖属于其它包的文件也强迫安装
      --nodeps 如果该RPM包的安装依赖其它包，即使其它包没装，也强迫安装。
(05) 查询一个包是否被安装：# rpm -q < rpm package name>
(06) 得到被安装的包的信息：# rpm -qi < rpm package name>
(07) 列出该包中有哪些文件：# rpm -ql < rpm package name>
(08) 列出服务器上的一个文件属于哪一个 RPM 包：#rpm -qf
(09) 可综合好几个参数一起用：# rpm -qil < rpm package name>
(10) 列出所有被安装的 rpm package：# rpm -qa
(11) 列出一个未被安装进系统的RPM包文件中包含有哪些文件：# rpm -qilp < rpm package name>

查看 rpm 安装包列表：

```sh
rpm -qa | grep mysql
```

正常卸载：

```sh
rpm -e mysql-community-client-5.6.44-2.el7.x86_64
```

强制卸载：

```sh
rpm -e mysql-community-client-5.6.44-2.el7.x86_64 --nodeps
```

## service 命令

查看 service 服务启动日志

```sh
journalctl -xe
```
