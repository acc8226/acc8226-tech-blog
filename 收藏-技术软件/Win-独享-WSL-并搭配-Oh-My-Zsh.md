> Windows Subsystem for Linux（简称 WSL）是一个在 Windows 10/11 上能够运行原生 Linux 二进制[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6/2885816)（ELF 格式）的兼容层。

## 入门

适用于 Linux 的 Windows 子系统随 Windows 操作系统一起提供，但必须先启用它并安装 Linux 发行版，然后才能开始使用它。

若要使用简化的 --install 命令，必须运行最新版本的 Windows。 

如果希望安装除 Ubuntu 以外的 Linux 发行版，或者希望手动完成这些步骤，请参阅 [WSL 安装页](https://docs.microsoft.com/zh-cn/windows/wsl/install)了解更多详细信息。

打开 PowerShell（或 Windows 命令提示符）并输入：

```
wsl --install
```

--install 命令执行以下操作：

*   启用可选的 WSL 和虚拟机平台组件
*   下载并安装最新 Linux 内核
*   将 WSL 2 设置为默认值
*   下载并安装 Ubuntu Linux 发行版（可能需要重新启动）

列出可用的 Linux 发行版
```
>wsl --list --online
以下是可安装的有效分发的列表。
请使用“wsl --install -d <分发>”安装。

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
或者 `wsl.exe -l -o`

这里我们选择安装 20.04 LTS 版
```
 wsl --install -d Ubuntu-20.04
```
或者 `wsl --install --distribution <Distribution Name>`

也可去微软应用商店搜索并下载, 这里我装的是 Ubuntu。

### 注销或卸载 Linux 发行版

尽管可以通过 Microsoft Store 安装 Linux 发行版，但无法通过 Store 将其卸载。

注销并卸载 WSL 发行版：
```
wsl --unregister <DistributionName>
```

### WSL 文件位置

一个重要的注意事项：启用 WSL 并安装 Linux 发行版时，将安装与计算机上的 Windows NTFS C:\ 驱动器分离的新文件系统。 在 Linux 中，驱动器没有字母。 将为它们提供装入点。 在 WSL 的情况下，文件系统 / 的根是根分区或文件夹的装入点。 并非 / 下的所有内容都是相同的驱动器。

| Linux 发行版       | Windows 访问主文件夹的路径          |
| :----------------- | :---------------------------------- |
| Ubuntu 20.04       | `\\wsl$\Ubuntu-20.04\home\username` |
| Ubuntu 18.04       | `\\wsl$\Ubuntu-18.04\home\username` |
| Debian             | `\\wsl$\Debian\home\username`       |
| Windows PowerShell | `C:\Users\username`   |

> 如果想从 WSL 发行版命令行访问 Windows 文件目录，而不是使用 C:\Users\username，则需使用 /mnt/c/Users/username 访问该目录，因为 Linux 发行版将 Windows 文件系统视为已装载的驱动器。

## ubuntu 常用命令

**更新和升级包**
```
sudo apt update && sudo apt upgrade
```

**查看版本和代码名称**  
```
lsb_release -dc
```
查看版本信息则 -c 即可。



**修改默认源**
首先将原配置文件备份
```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.2021
```
然后 VIM 打开`sudo vim /etc/apt/sources.list`，替换
```
:%s/security.ubuntu/mirrors.aliyun/g
:%s/archive.ubuntu/mirrors.aliyun/g
```

更新并升级
```
sudo apt update
sudo apt-get upgrade
```

这样再使用 apt install 速度就快多了

**WSL ubuntu18.04 忘记密码 后怎么办**
ubuntu1804 config --default-user root
进入ubuntu控制台, 之后执行 passwd 输入新密码即可。

### 搭配 Visual Studio Code 

Visual Studio Code 以及 Remote - WSL 扩展使你能够直接从 VS Code 使用 WSL 作为实时开发环境。 可以：

*   在基于 Linux 的环境中进行开发
*   使用特定于 Linux 的工具链和实用程序
*   从 Windows 轻松地运行和调试基于 Linux 的应用程序，同时保持对 Outlook 和 Office 等生产力工具的访问
*   使用 VS Code 内置终端来运行选择的 Linux 发行版
*   利用 VS Code 功能，例如[Intellisense 代码完成](https://code.visualstudio.com/docs/editor/intellisense)、[linting](https://code.visualstudio.com/docs/python/linting)、[调试支持](https://code.visualstudio.com/docs/nodejs/nodejs-debugging)、[代码片段](https://code.visualstudio.com/docs/editor/userdefinedsnippets)和[单元测试](https://code.visualstudio.com/docs/python/testing)
*   使用 VS Code 的内置 [Git 支持](https://code.visualstudio.com/docs/editor/versioncontrol#_git-support)轻松管理版本控制
*   直接在 WSL 项目上运行命令和 VS Code 扩展
*   在 Linux 或已装载的 Windows 文件系统（例如 /mnt/c）中编辑文件，而无需担心路径问题、二进制兼容性或其他跨 OS 难题

#### [安装 VS Code 和远程 WSL 扩展](https://docs.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-vscode#install-vs-code-and-the-remote-wsl-extension)

*   访问 [VS Code 安装页](https://code.visualstudio.com/download)，选择 32 位或 64 位安装程序。 在 Windows 上（不是在 WSL 文件系统中）安装 Visual Studio Code。

*   当在安装过程中系统提示“选择其他任务”时，请务必选中“添加到 PATH”选项，以便可以使用代码命令在 WSL 中轻松打开文件夹。

*   安装[远程开发扩展包](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)。 除了 Remote - SSH 和 Remote - Containers 扩展之外，此扩展包还包含 Remote - WSL 扩展，使你能够打开容器中、远程计算机上或 WSL 中的任何文件夹。

#### 在 Visual Studio Code 中打开 WSL 项目

从命令行中
若要从 WSL 发行版打开项目，请打开发行版的命令行并输入：`code .`

从 VS Code 中

还可以通过使用 VS Code 中的快捷方式 `CTRL+SHIFT+P` 调出命令面板，以访问更多 VS Code 远程选项。 如果随后键入 `Remote-WSL`，将看到可用的 VS Code 远程选项列表，使你可以在远程会话中重新打开文件夹，指定要在哪个发行版中打开，等等。

## 开始安装 zsh
```
sudo apt-get install zsh
```

设置默认 shell 为 zsh
```
chsh -s $(which zsh)
```

设置完成后使用下列命令检查是否设置成功
```
echo $SHELL
```

#### 安装 oh-my-zsh
```
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### 设置 ys 主题
打开 oh-my-zsh 配置文件
```
sudo vim ~/.zshrc
```
修改主题配色为 ys
```
ZSH_THEME="ys"  
```
