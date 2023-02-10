## Ubuntu 版本

* 20.04：focal；
* 18.04：bionic；
* 17.10：artful；
* 16.04：xenial；
* 14.04：trusty。

提示：使用 HTTPS 源可以有效避免国内运营商的缓存劫持。

## 更换源

中科大源、清华源或阿里源可任意选择一。

<https://mirrors.ustc.edu.cn/>
<https://mirrors.tuna.tsinghua.edu.cn/>
<https://mirrors.aliyun.com/ubuntu/>

Ubuntu 的软件源配置文件是 /etc/apt/sources.list。请将系统自带的该文件做个备份。

方式一：使用 sed 命令进行替换

将 <http://archive.ubuntu.com/> 替换为 <http://mirrors.ustc.edu.cn> 即可。可以使用如下命令：

```sh
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

方式二：直接覆盖

以 20.04 LTS 为例， copy 内容覆盖掉 /sources.list 即可。

然后请运行 `sudo apt-get update` 更新索引以生效。

### 启用 ssh

先通过 bash 进入子系统修改配置

```bash
Port = 22 # 默认是22端口，如果和windows端口冲突或你想换成其他的否则不用动
#ListenAddress 0.0.0.0 # 如果需要指定监听的IP则去除最左侧的井号，并配置对应IP，默认即监听PC所有IP
PermitRootLogin no # 如果你需要用 root 直接登录系统则此处改为 yes
PasswordAuthentication yes # 将 no 改为 yes 表示使用帐号密码方式登录
```

如果文件不存在说明尚未安装，则执行安装 `apt-get install openssh-server`

之后使用 `service ssh start` 即可。

然后客户端`ssh 用户名@localhost` 可进行登录即可。

**ssh 相关知识**

* 查看 ssh 服务状态
service ssh start
* 查看 ssh 服务状态
service ssh status
* 查看 ssh 服务状态
service ssh restart
* 查看 ssh 服务状态
service ssh stop
* 生成对应的 rsa,ecdsa,ed25519三种类型的秘钥：

### 启用 lrzsz

```sh
sudo apt-get install lrzsz
```

## 常用命令

查看当前系统版本

```sh
lsb_release -a
```

## dpkg 命令

linux 的包管理有多种，除了 rpm，apt 等还有优秀的 dpkg。

dpkg 命令的使用：
dpkg -l 查看当前系统中已经安装的软件包的信息
dpkg -L （软件包名称）查看系统中已经安装的软件文件的详细列表
dpkg -s 查看已经安装的指定软件包的详细信息
dpkg -S 查看系统中的某个文件属于那个软件包;
`dpkg -i *.deb` 文件的安装
`dpkg -r *.deb` 文件的卸载;
dpkg -P 彻底的卸载 包括软件的配置文件等等
查看没有安装的deb包命令
dpkg -c 查询deb包文件中所包含的文件 rpm -qlp
dpkg -I 查询deb包的详细信息
添加说明：
最常用的就是 -i，-r。简单，安装／卸载。不用说。

## 遇到过的问题

### "System has not been booted with systemd as init system"

原因是你想用 systemd 命令来管理 Linux 上的服务，但你的系统并没有使用 systemd，（很可能）使用的是经典的SysV init（sysvinit）系统。

答案很简单，就是不要使用 systemctl 命令，而是使用等同的 sysvinit 命令。相反，可以使用对应的 sysvinit 命令。

Systemd command | Sysvinit command
----  | ----
systemctl start service_name | service service_name start
systemctl stop service_name | service service_name stop
systemctl restart service_name | service service_name restart
systemctl status service_name | service service_name status
systemctl enable service_name | service service_name on
systemctl disable service_name | service service_name off

## 参考

dpkg 命令的详细使用教程_阿力 php 的博客-CSDN 博客_dpkg命令
<https://blog.csdn.net/qq_18839693/article/details/62229646>

dpkg 命令的用法_小绵羊的学习之路的博客-CSDN博客_dpkg命令
<https://blog.csdn.net/yang3572/article/details/80991108>
