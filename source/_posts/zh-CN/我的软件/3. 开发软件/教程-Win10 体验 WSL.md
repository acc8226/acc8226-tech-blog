---
title: 教程 Win10 体验 WSL
date: 2020-06-02 22:57:01
updated: 2022-11-16 13:28:02
categories:
  - 收藏
  - 开发软件
---

> Windows Subsystem for Linux（简称 WSL）是一个在 Windows 10/11 上能够运行原生 Linux 二进制[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6/2885816)（ELF 格式）的兼容层。

## WSL 入门

适用于 Linux 的 Windows 子系统随 Windows 操作系统一起提供，但必须先启用它并安装 Linux 发行版，然后才能开始使用它。

控制面板 ——> 程序 ——> 程序和功能 ——> 启用或关闭 Windows 功能 ——> 适用于 Linux 的 Windows 子系统 ——> 确定 （然后重启）

若要使用简化的 --install 命令，必须运行最新版本的 Windows。

### 列出可用的 Linux 发行版

`wsl --list --online` 或者 `wsl.exe -l -o`

```sh
wsl --list --online
以下是可安装的有效分发的列表。
请使用 “wsl --install -d <分发>” 安装。

NAME            FRIENDLY NAME
Ubuntu          Ubuntu
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS
```

### 安装 Linux 发行版

打开 PowerShell（或 Windows 命令提示符）并输入：

```bat
wsl --install
```

--install 命令执行以下操作：

* 启用可选的 WSL 和虚拟机平台组件
* 下载并安装最新 Linux 内核
* 将 WSL 2 设置为默认值
* **下载并将默认安装 Ubuntu Linux 发行版**（可能需要重新启动）

如果希望安装除 Ubuntu 以外的 Linux 发行版，或者希望手动完成这些步骤，请参阅 [WSL 安装页](https://docs.microsoft.com/zh-cn/windows/wsl/install)了解更多详细信息。

也可去微软应用商店搜索并下载, 这里我们选择安装 20.04 LTS 版。

```bat
wsl --install -d Ubuntu-20.04
```

或者

```bat
wsl --install --distribution <DistributionName>`
```

### 注销或卸载 Linux 发行版

尽管可以通过 Microsoft Store 安装 Linux 发行版，但无法通过 Store 将其卸载。

注销并卸载 WSL 发行版：

```bat
wsl --unregister <DistributionName>
```

### WSL 文件位置

一个重要的注意事项：启用 WSL 并安装 Linux 发行版时，将安装与计算机上的 Windows NTFS C:\ 驱动器分离的新文件系统。 在 Linux 中，驱动器没有字母。 将为它们提供装入点。 在 WSL 的情况下，文件系统 / 的根是根分区或文件夹的装入点。 并非 / 下的所有内容都是相同的驱动器。

| Linux 发行版       | Windows 访问主文件夹的路径          |
| :----------------- | :---------------------------------- |
| Ubuntu 20.04       | `\\wsl$\Ubuntu-20.04\home\username` |
| Ubuntu 18.04       | `\\wsl$\Ubuntu-18.04\home\username` |
| Debian             | `\\wsl$\Debian\home\username`       |
| Windows PowerShell | `C:\Users\username` |

> 如果想从 WSL 发行版命令行访问 Windows 文件目录，而不是使用 C:\Users\username，则需使用 /mnt/c/Users/username 访问该目录，因为 Linux 发行版将 Windows 文件系统视为已装载的驱动器。

windows 如何访问 wsl 系统下的文件，可以在 wsl 终端输入以下命令

```bat
explorer.exe .
```

### 子系统 Linux 重启

WSL 子系统是基于 LxssManager 服务运行的。只需要将 LxssManager 重启即可。也可以做成一个 bat 文件。

Using CMD (Administrator)

```bat
net stop LxssManager
net start LxssManager
```

## ubuntu 常用命令

**修改默认源**
首先将原配置文件备份

```sh
sudo cp /etc/apt/sources.list /etc/apt/sources.list.2021
```

然后 VIM 打开`sudo vim /etc/apt/sources.list`，替换

```sh
:%s/security.ubuntu/mirrors.aliyun/g
:%s/archive.ubuntu/mirrors.aliyun/g
```

更新并升级

```sh

sudo apt-get upgrade
```

这样再使用 apt install 速度就快多了

**WSL ubuntu18.04 忘记密码 后怎么办**
ubuntu1804 config --default-user root
进入 ubuntu 控制台, 之后执行 passwd 输入新密码即可。

### 搭配 Visual Studio Code

Visual Studio Code 以及 Remote - WSL 扩展使你能够直接从 VS Code 使用 WSL 作为实时开发环境。 可以：

* 在基于 Linux 的环境中进行开发
* 使用特定于 Linux 的工具链和实用程序
* 从 Windows 轻松地运行和调试基于 Linux 的应用程序，同时保持对 Outlook 和 Office 等生产力工具的访问
* 使用 VS Code 内置终端来运行选择的 Linux 发行版
* 利用 VS Code 功能，例如[Intellisense 代码完成](https://code.visualstudio.com/docs/editor/intellisense)、[linting](https://code.visualstudio.com/docs/python/linting)、[调试支持](https://code.visualstudio.com/docs/nodejs/nodejs-debugging)、[代码片段](https://code.visualstudio.com/docs/editor/userdefinedsnippets)和[单元测试](https://code.visualstudio.com/docs/python/testing)
* 使用 VS Code 的内置 [Git 支持](https://code.visualstudio.com/docs/editor/versioncontrol#_git-support)轻松管理版本控制
* 直接在 WSL 项目上运行命令和 VS Code 扩展
* 在 Linux 或已装载的 Windows 文件系统（例如 /mnt/c）中编辑文件，而无需担心路径问题、二进制兼容性或其他跨 OS 难题

#### [安装 VS Code 和远程 WSL 扩展](https://docs.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-vscode#install-vs-code-and-the-remote-wsl-extension)

* 访问 [VS Code 安装页](https://code.visualstudio.com/download)，选择 32 或 64 位安装程序。 在 Windows 上（不是在 WSL 文件系统中）安装 Visual Studio Code。

* 当在安装过程中系统提示“选择其他任务”时，请务必选中“添加到 PATH”选项，以便可以使用代码命令在 WSL 中轻松打开文件夹。

* 安装[远程开发扩展包](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)。 除了 Remote - SSH 和 Remote - Containers 扩展之外，此扩展包还包含 Remote - WSL 扩展，使你能够打开容器中、远程计算机上或 WSL 中的任何文件夹。

#### 在 Visual Studio Code 中打开 WSL 项目

从命令行中
若要从 WSL 发行版打开项目，请打开发行版的命令行并输入：`code .`

从 VS Code 中

还可以通过使用 VS Code 中的快捷方式 `CTRL+SHIFT+P` 调出命令面板，以访问更多 VS Code 远程选项。 如果随后键入 `Remote-WSL`，将看到可用的 VS Code 远程选项列表，使你可以在远程会话中重新打开文件夹，指定要在哪个发行版中打开，等等。

### WSL 常见用法

wsl 启动 ssh

```sh
sudo service ssh start
```

wsl 修改用户名密码

```sh
# 进入poweshell
wsl -u root
passwd # 输入密码
exit
```

### 同一局域网下 windows 主机和 wsl 子系统相互网络服务访问

#### 从主机访问 wsl 的服务

在 wsl 子系统中，使用以下命令，获取 wsl 的 ip

```sh
ip addr | grep eth0
```

我这里的显示是：

```sh
eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 172.30.64.232/20 brd 172.30.79.255 scope global eth0
```

wsl 的 ip 即为 inet 后面的一串，也就是 172.30.64.232。

#### 从 wsl 访问主机的服务

输入命令

```powershell
New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL)" -Action Allow
```

然后在 wsl 中输入命令：

```sh
cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'
```

就会出现一个 ip，这个 ip 可以用 ping + ip 测试一下，应该可以连通。

## wslg 支持

WSLg 是 Linux GUI 的 Windows 子系统的缩写，该项目的目的是支持在 Windows 上运行 Linux GUI 应用程序(X11 and Wayland) ，提供完全集成的桌面体验。

**先决条件**
Windows 11(build 22000.*) 或 Windows 11 Insider Preview (builds 21362+)

将会随着即将发布的 Windows 一起普及。要访问 WSLg 的预览版，您需要从 Microsoft Store 安装 Linux 预览版 Windows 子系统。

建议在为 WSL 启用虚拟 GPU (vGPU)的系统上运行 WSLg，这样您就可以受益于硬件加速的 OpenGL 渲染。您可以在下面找到支持 WSL 的预览驱动程序。

* [AMD GPU driver for WSL](https://community.amd.com/community/radeon-pro-graphics/blog/2020/06/17/announcing-amd-support-for-gpu-accelerated-machine-learning-training-on-windows-10)
* [Intel GPU driver for WSL](https://downloadcenter.intel.com/download/30579/Intel-Graphics-Windows-DCH-Drivers)
* [NVIDIA GPU driver for WSL](https://developer.nvidia.com/cuda/wsl)

**安装和运行 GUI 应用程序**
如果您想要开始使用一些 GUI 应用程序，您可以从您的 Linux 终端运行以下命令来下载和安装一些流行的应用程序。如果你使用的是不同于 Ubuntu 的发行版，那么它可能使用的是不同的软件包管理器。

```sh
## Update list of available packages
sudo apt update

## Gedit
sudo apt install gedit -y

## GIMP
sudo apt install gimp -y

## Nautilus
sudo apt install nautilus -y

## VLC
sudo apt install vlc -y

## X11 apps
sudo apt install x11-apps -y
```

## 安装 zsh

```sh
sudo apt-get install zsh
```

设置默认 shell 为 zsh

```sh
chsh -s $(which zsh)
```

设置完成后使用下列命令检查是否设置成功

```sh
echo $SHELL
```

### 安装 oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 设置 ys 主题

打开 oh-my-zsh 配置文件

```sh
sudo vim ~/.zshrc
```

修改主题配色为 ys

```text
ZSH_THEME="ys"
```

## 参考

同一局域网下 windows 主机和 wsl 子系统相互网络服务访问_薛钦亮的博客-CSDN 博客_局域网访问 wsl
<https://blog.csdn.net/weixin_43997331/article/details/122593312>
