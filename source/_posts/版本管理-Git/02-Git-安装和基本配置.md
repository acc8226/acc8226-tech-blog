## Git 安装

### Linux 上安装 Git

首先，你可以试着输入 Git，看看系统有没有安装 Git。有很多 Linux 系统会友好地告诉你 Git 没有安装，还会告诉你如何安装 Git。如果你碰巧用 Debian 或 Ubuntu，通过一条 `sudo apt-get install git`
就可以直接完成 Git 的安装。

如果使用的是 centos 或 reahat, 通过这条命令

```sh
sudo yum install git
```

可以完成安装。

老一点的 Debian 或 Ubuntu Linux，要把命令改为`sudo apt-get install git-core`，因为以前有个软件也叫 GIT（GNU Interactive Tools），结果 Git 就只能叫 git-core 了。由于 Git 名气实在太大，后来就把 GNU Interactive Tools 改成 gnuit，git-core 正式改为 git。

如果是其他 Linux 版本，可以直接通过源码安装。先从 Git 官网下载源码，然后解压，依次输入：

```sh
./config
make
sudo make install
```

这几个命令安装就好了。

### mac 上安装 Git

推荐使用 homebrew 进行安装

### Windows上安装 Git

msysgit 是 Windows 版的 Git，

* git-for-windows Mirror 镜像下载 <https://npm.taobao.org/mirrors/git-for-windows/>
* 官网下载 <https://git-scm.com/downloads>

安装完成后，在开始菜单里找到 “Git”->“Git Bash”，蹦出一个类似命令行窗口的东西，就说明 Git 安装成功！

> windows 环境下可以进一步配置环境变量为 `C:\Program Files\Git\bin`

#### Win 系统下 TortoiseGit 软件和 git 搭配使用

TortoiseGit 和 windows 资源管理器有很好的集成, 推荐使用.
[Download – TortoiseGit – Windows Shell Interface to Git](https://tortoisegit.org/download/)

![TortoiseGit 技巧 之 导出变更后的文件](https://upload-images.jianshu.io/upload_images/1662509-4bf5ccfaf3cb4115.gif?imageMogr2/auto-orient/strip)

## Git GUI 推荐

windows 环境下已经自带了 gitk，如果觉得还是不好使的话。一般 Java 开发者使用的 ide 也有相应的支持，足矣支持使用。

* TortoiseGit（windows 独享）
* SourceTree (免费，跨平台)

## Git 最小化配置和基本配置

首先得了解三个级别(作用域由低到高，优先级则是由高到低)：

* --local 默认级别: 只影响本仓库 `.git/config`
* --global 影响到当前用户下 git 配置   `~/gitconfig` 或 `%USERPROFILE%\.gitconfig`
* --system 最高级别 影响全系统的 git 配置 `/etc/gitconfig`

直接查阅某个环境变量的设定，只要把特定的名字跟在后面即可， 例如

```sh
git config user.name
git config --global user.name
git config --system user.name
```

打开配置文件

```sh
git config -e
git config -e --global
git config -e --system
```

**配置用户名和邮箱**
因为 Git 是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email 地址。

最小化配置

```sh
# 一般配置到用户级别即可
git config --global user.name "Mona Lisa"
git config --global user.email "YourEmail@example.com"
```

推荐的增强配置
提交检出均不转换，防止 git 自动将 lf 和 crlf 互转。

```sh
git config --global core.autocrlf false
```

拒绝提交包含混合换行符的文件

```sh
git config --global core.safecrlf true
```

让 Git 显示颜色，使命令输出看起来更醒目

```sh
git config --global color.ui true
```

设置 alias, 命令为 git config alias.[别名] [原命令]，使用别名简化常用命令。如果原命令有空格， 需要加引号引起来。

```sh
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br branch
```

log 美化日志输出

```sh
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

> * 当前用户的 Git 配置文件放在用户主目录下的一个隐藏文件 .gitconfig 中
> * 每个仓库的 Git 配置文件都放在.git/config 文件中。也可以单独配置它

## 创建 SSH 密钥

Git 使用的传输协议中最常见的可能就是 SSH 了。这是因为大多数环境已经支持通过 SSH 对服务器的访问。使用 SSH 协议主要有两个好处， 第一是认证后不再需要输入用户名和密码， 第二就是提高了数据传输速度。

因此可以提前配置一对密钥供给后续使用。生成公钥的过程在所有操作系统上都差不多。首先先确认一下是否已经有一个公钥了。SSH 公钥默认储存在账户的主目录下的 ~/.ssh 目录。进去看看：

**check to see if you have any existing SSH keys.**
`ls -al ~/.ssh`

**获取公钥内容**
`cat ~/.ssh/id_rsa.pub`

获取私钥内容同理也是使用 cat 文件名
`cat ~/.ssh/id_rsa`

如果没有则需要手动创建：

```sh
ssh-keygen -t rsa -C "youremail@example.com"
```

你需要把邮件地址换成你自己的邮件地址，然后一路回车，使用默认值即可，由于这个Key也不是用于军事目的，所以也无需设置密码。

如果一切顺利的话，可以在用户主目录里找到 .ssh目录，里面有 id_rsa 和 id_rsa.pub 两个文件，这两个就是 SSH Key 的秘钥对，**id_rsa 是私钥**，不能泄露出去，id_rsa.pub是公钥，可以放心地告诉任何人。

为什么 GitHub 需要 SSH Key呢？因为 GitHub 需要识别出你推送的提交确实是你推送的，而不是别人冒充的，而 Git 支持 SSH 协议，所以，GitHub 只要知道了你的公钥，就可以确认只有你自己才能推送。

当然，GitHub 允许你添加多个 Key。假定你有若干电脑，你一会儿在公司提交，一会儿在家里提交，只要把每台电脑的 Key 都添加到 GitHub，就可以在每台电脑上往 GitHub 推送了。

## 激活 cat 命令

由于我是使用的是绿色版，则加入以下路径到 Path 中。
D:\exec\PortableGit\usr\bin
