---
title: Linux 下软件安装
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

通常 Linux 上的软件安装主要有四种方式

* 在线安装
* 从磁盘安装软件包
* 从二进制软件包安装
* 从源代码编译安装

在不同的 linux 发行版上面在线安装方式会有一些差异包括使用的命令及它们的包管理工具，因为我们的开发环境是基于 ubuntu 的，所以这里我们涉及的在线安装方式将只适用于 ubuntu 发行版，或其它基于 ubuntu 的发行版如国内的 ubuntukylin(优麒麟)，**ubuntu 又是基于 debian** 的发行版，它使用的是 debian 的包管理工具 dpkg，所以一些操作也适用与 debian。而在一些采用其它包管理工具的发行版如 redhat，centos, fedora 等将不适用(redhat 和 centos 使用 rpm)。

比如我们想安装一个软件，名字叫做 w3m(w3m 是一个命令行的简易网页浏览器)，那么输入如下命令：

```sh
sudo apt-get install w3m
```

APT 是 Advance Packaging Tool（高级包装工具）的缩写，是 Debian 及其派生发行版的软件包管理器，APT 可以自动下载，配置，安装二进制或者源代码格式的软件包，因此简化了 Unix 系统上管理软件的过程。APT 最早被设计成 dpkg 的前端，用来处理 deb 格式的软件包。现在经过 APT-RPM 组织修改，APT 已经可以安装在支持 RPM 的系统管理 RPM 包。这个包管理器包含以 apt- 开头的多个工具，如 apt-get apt-cache apt-cdrom 等，在 Debian 系列的发行版中使用。

当你在执行安装操作时，首先apt-get 工具会在本地的一个数据库中搜索关于 w3m 软件的相关信息，并根据这些信息在相关的服务器上下载软件安装，这里大家可能会一个疑问：既然是在线安装软件，为啥会在本地的数据库中搜索？要解释这个问题就得提到几个名词了：

软件源镜像服务器
软件源
我们需要定期从服务器上下载一个软件包列表，使用 sudo apt-get update 命令来保持本地的软件包列表是最新的（有时你也需要手动执行这个操作，比如更换了软件源），而这个表里会有软件依赖信息的记录，对于软件依赖，我举个例子：我们安装 w3m 软件的时候，而这个软件需要 libgc1c2 这个软件包才能正常工作，这个时候 apt-get 在安装软件的时候会一并替我们安装了，以保证 w3m 能正常的工作。

apt-get 是用于处理 apt 包的公用程序集，我们可以用它来在线安装、卸载和升级软件包等，下面列出一些apt-get包含的常用的一些工具：

工具 说明
install 其后加上软件包名，用于安装一个软件包
update 从软件源镜像服务器上下载/更新用于更新本地软件源的软件包列表
upgrade 升级本地可更新的全部软件包，但存在依赖问题时将不会升级，通常会在更新之前执行一次update
dist-upgrade 解决依赖关系并升级(存在一定危险性)
remove 移除已安装的软件包，包括与被移除软件包有依赖关系的软件包，但不包含软件包的配置文件
autoremove 移除之前被其他软件包依赖，但现在不再被使用的软件包
purge 与 remove 相同，但会完全移除软件包，包含其配置文件
clean 移除下载到本地的已经安装的软件包，默认保存在/var/cache/apt/archives/
autoclean 移除已安装的软件的旧版本软件包
下面是一些 apt-get 常用的参数：

参数 说明
-y 自动回应是否安装软件包的选项，在一些自动化安装脚本中使用这个参数将十分有用
-s	模拟安装
-q	静默安装方式，指定多个q或者-q=#,#表示数字，用于设定静默级别，这在你不想要在安装软件包时屏幕输出过多时很有用
-f	修复损坏的依赖关系
-d 只下载不安装
--reinstall 重新安装已经安装但可能存在问题的软件包
--install-suggests  同时安装 APT 给出的建议安装的软件包

关于安装，如前面演示的一样你只需要执行`apt-get install <软件包名>`即可，除了这一点，你还应该掌握的是如何重新安装软件包。 很多时候我们需要重新安装一个软件包，比如你的系统被破坏，或者一些错误的配置导致软件无法正常工作。

你可以使用如下方式重新安装：

```sh
sudo apt-get --reinstall install w3m
```

另一个你需要掌握的是，如何在不知道软件包完整名的时候进行安装。通常我们是使用`Tab`键补全软件包名，后面会介绍更好的方法来搜索软件包。有时候你需要同时安装多个软件包，你还可以使用正则表达式匹配软件包名进行批量安装。

## 卸载软件

如果你现在觉得 `w3m` 这个软件不合自己的胃口，或者是找到了更好的，你需要卸载它，那么简单！同样是一个命令加回车 `sudo apt-get remove w3m` ，系统会有一个确认的操作，之后这个软件便“滚蛋了”。

![](https://upload-images.jianshu.io/upload_images/1662509-cdf44d1f753a5804?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

或者，你可以执行

```sh
# 不保留配置文件的移除
sudo apt-get purge w3m
# 或者 sudo apt-get --purge remove
# 移除不再需要的被依赖的软件包
sudo apt-get autoremove
```

## 软件搜索

当自己刚知道了一个软件，想下载使用，需要确认软件仓库里面有没有，就需要用到搜索功能了，命令如下：

```sh
sudo apt-cache search softname1 softname2 softname3……
```

`apt-cache` 命令则是针对本地数据进行相关操作的工具，`search` 顾名思义在本地的数据库中寻找有关`softname1``softname2` …… 相关软件的信息。现在我们试试搜索一下之前我们安装的软件 `w3m` ，如图：

![](https://upload-images.jianshu.io/upload_images/1662509-6a989b000d57f301?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

结果显示了 4 个 `w3m` 相关的软件，并且有相关软件的简介。

关于在线安装的的内容我们就介绍这么多，想了解更多关于 APT 的内容，你可以参考：

* [APT HowTo](http://www.debian.org/doc/manuals/apt-howto/index.zh-cn.html#contents)

## 三、使用 dpkg

dpkg 是 Debian 软件包管理器的基础，它被伊恩·默多克创建于 1993 年。dpkg 与 RPM 十分相似，同样被用于安装、卸载和供给和 .deb 软件包相关的信息。

dpkg 本身是一个底层的工具。上层的工具，像是 APT，被用于从远程获取软件包以及处理复杂的软件包关系。"dpkg"是"Debian Package"的简写。

我们经常可以在网络上见到以 deb 形式打包的软件包，就需要使用 dpkg 命令来安装。

dpkg 常用参数介绍：

参数 说明
-i	安装指定 deb 包
-R	后面加上目录名，用于安装该目录下的所有 deb 安装包
-r	remove，移除某个已安装的软件包
-I	显示deb包文件的信息
-s	显示已安装软件的信息
-S	搜索已安装的软件包
-L	显示已安装软件包的目录信息

我们先使用`apt-get`加上`-d`参数只下载不安装，下载 emacs 编辑器的 deb 包：

```sh
sudo apt-get update
sudo apt-get -d install -y emacs
```

下载完成后，我们可以查看 /var/cache/apt/archives/ 目录下的内容，如下图：

![](https://upload-images.jianshu.io/upload_images/1662509-23d1c4df6249664f?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后我们将第一个 `deb` 拷贝到 /home/shiyanlou 目录下，并使用`dpkg`安装

```sh
$ cp /var/cache/apt/archives/emacs24_24.5+1-6ubuntu1.1_amd64.deb ~
# 安装之前参看deb包的信息
$ sudo dpkg -I emacs24_24.5+1-6ubuntu1.1_amd64.deb
```

如你所见，这个包还额外依赖了一些软件包，这意味着，如果主机目前没有这些被依赖的软件包，直接使用 dpkg 安装可能会存在一些问题，因为`dpkg`并不能为你解决依赖关系。

```sh
# 使用dpkg安装
$ sudo dpkg -i emacs24_24.5+1-6ubuntu1.1_amd64.deb
```

跟前面预料的一样，这里你可能出现了一些错误：

![](https://upload-images.jianshu.io/upload_images/1662509-3c99f477657a2830?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们将如何解决这个错误呢？这就要用到 `apt-get` 了，使用它的 `-f` 参数了，修复依赖关系的安装

```sh
sudo apt-get update
sudo apt-get -f install -y
```

没有任何错误，这样我们就安装成功了，然后你可以运行 emacs 程序

## 从二进制包安装包

二进制包的安装比较简单，我们需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进 PATH 环境变量即可，如果你不知道该放到什么位置，请重新复习关于 Linux 目录结构的内容。
