---
title: 11-CentOS下-Git和Gitlab搭建
categories:
  - 版本管理
  - Git
tags:
- git
---

## Git 的搭建

Git 是一款免费、开源的分布式版本控制系统，用于敏捷高效地处理任何或小或大的项目。
此实验以 `CentOS 7.2 x64` 的系统为环境，搭建 git 服务器

`yum -y install git`

### 安装依赖库和编译工具

```sh
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install gcc perl-ExtUtils-MakeMaker
```

### 下载 git

选一个目录，用来放下载下来的安装包，这里将安装包放在` /usr/local/src `目录里`cd /usr/local/src`

到官网找一个新版稳定的源码包下载到 /usr/local/src 文件夹里 `wget https://www.kernel.org/pub/software/scm/git/git-2.10.0.tar.gz`

### 解压和编译

解压下载的源码包
`tar -zvxf git-2.10.0.tar.gz`
解压后进入 git-2.10.0 文件夹
`cd git-2.10.0`
执行编译
`make all prefix=/usr/local/git`
编译完成后, 安装到 /usr/local/git 目录下
`make install prefix=/usr/local/git`

### 配置环境变量

将 git 目录加入 PATH
将原来的 PATH 指向目录修改为现在的目录
`echo 'export PATH=$PATH:/usr/local/git/bin' >> /etc/bashrc`
生效环境变量
`source /etc/bashrc`
此时我们能查看 git 版本号，说明我们已经安装成功了。
`git --version`

## 创建 git 账号密码

为我们刚刚搭建好的 git 创建一个账号 `useradd -m gituser`

设置密码 `passwd gituser`

## 创建 git 仓库并初始化

我们创建 /data/git-repositories 目录用于存放 git 仓库

```sh
mkdir -p /data/git-repositories
```

创建好后，初始化这个仓库

```sh
cd /data/git-repositories/ && git init --bare helloWorld.git
```

给 git 仓库目录设置用户和用户组并设置权限

```sh
chown -R gituser:gituser /data/git-repositories
chmod 755 /data/git-repositories
```

### 使用搭建好的 Git 服务

克隆仓库到本地

```sh
git clone gituser@<您的 CVM IP 地址>:/data/git-repositories/helloWorld.git
```

## Gitlab 搭建

1\. 安装依赖包。

```sh
sudo yum install -y curl policycoreutils-python openssh-server
```

2\. 设置SSH开机自启动并启动SSH服务。

```sh
sudo systemctl enable sshd
sudo systemctl start sshd
```

3\. 安装 Postfix 来发送通知邮件。

```sh
sudo yum install postfix
```

4\. 设置 Postfix 开机自启动。

```sh
sudo systemctl enable postfix
```

5\. 启动 Postfix 服务。

输入命令`vim /etc/postfix/main.cf`打开 main.cf 文件并找到如下内容 `inet_interfaces = localhost` 将这行代码改为 `inet_interfaces = all`，然后按`Esc`键，然后输入`:wq`并回车以保存并关闭main.cf文件。输入命令 `sudo systemctl start postfix` 启动 Postfix 服务。

6\. 添加 GitLab 软件包仓库。

```sh
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
```

7\. 安装 GitLab。

```sh
sudo EXTERNAL_URL="GitLab服务器的公网IP地址" yum install -y gitlab-ce
```

**说明** 您可从 ECS 管理控制台的实例列表页找到GitLab服务器的公网IP地址。

8\. 使用浏览器访问 GitLab 服务器的公网IP地址，显示如下页面，说明环境搭建成功。
