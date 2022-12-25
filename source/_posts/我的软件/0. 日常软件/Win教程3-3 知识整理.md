---
title: Win 教程 3-3 知识整理
date: 2021-06-03 21:27:25
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

## 记录

### 查看已知网络的密码

在资源管理器的地址栏输入：控制面板\网络和 Internet\网络和共享中心

选中已连接的网络 wlan 状态 -> 无线属性 -> 切换到安全标签页 -> 勾选显示字符

### Host 文件所在路径

```text
%WINDIR%\System32\drivers\etc
```

或者

```text
C:\Windows\System32\drivers\etc
```

> Hosts 文件存放的是一些网站主机的域名和对应的 IP 地址。当我们使用浏览器浏览一个网站时，系统会先检查本地 hosts 文件，看其中是否有对应域名和 IP 地址的对应关系，如果有就会直接采用，因此会节约大量时间。

### Windows 常用命令

CMD 命令：开始 -> 运行 -> 键入 cmd 或 command（在命令行里可以看到系统版本、文件系统版本）

appwiz.cpl：程序和功能
calc：启动计算器
cmd.exe：CMD 命令提示符

自动关机命令
　 Shutdown -s -t 600：表示600秒后自动关机
　 shutdown -a ：可取消定时关机
　 Shutdown -r -t 600：表示600秒后自动重启

control：控制面版
devmgmt.msc：设备管理器
desk.cpl：屏幕分辨率
diskmgmt.msc：磁盘管理
eventvwr：事件查看器
explorer：打开资源管理器
Firewall.cpl：Windows防火墙
hdwwiz.cpl：设备管理器
inetcpl.cpl：Internet属性
logoff：注销命令
main.cpl：鼠标属性
mmsys.cpl：声音
magnify：放大镜实用程序
mspaint：画图
Msra：Windows远程协助
mstsc：远程桌面连接
netstat : an(TC)命令检查接口
notepad：打开记事本
osk：打开屏幕键盘
powercfg.cpl：电源选项
winver：关于Windows
write：写字板

### 超酷的滑动关机

打开 C 盘，定位到 C:\Windows\System32 目录，查询是否有一个 SlideToShutDown.exe 应用程序。接着右键点击该应用程序，选择发送到桌面快捷方式，这样就在桌面建立了一个快捷方式。

选择刚刚创建的快捷方式，你可以重命名为自己喜欢的名字，这里我改为“滑动关机”。

### 你可能不知道的几种替代式 windows 快捷操作

相对于鼠标点点点，有时候用键盘快捷键操作在执行效率上会更高一些，网上关于 windows 快捷键相关的文章非常多，而且都是非常常用的一些快捷操作。虽然如此，但还是有一些快捷操作你可能不知道的，下面IT技术资料分享网小编就给大家分享几种替代式的 windows 快捷操作，进一步丰富大家对快捷键操作的认识。

Backspace
即“退格键”，在编辑内容时可通过 Backspace 键进行删除。不过，你知道吗？除此之外，在“我的电脑”或 “windows 资源管理器”中可以通过 Backspace 键查看上一级文件夹而不删除任何内容。

Ctrl + W
我们在浏览网页时，如果只想关闭当前标签页就可以通过按 Ctrl+W 组合键快速关闭。你知道吗？Ctrl+W 组合键不单单对于浏览器有效，对于其他的带有“标签页”功能的软件也基本有效，比如PS，WPS 都是有效的。对于部分不带标签页的单个软件，按 Ctrl + W 可以将其关闭，类似于 Alt + F4

Ctrl+Esc
除了常用的按 “win键” 打开开始菜单外，我们也可以通过 Ctrl+Esc 组合键打开开始菜单。Emmm... 感觉这个有点鸡肋。

Alt + Enter，Alt + 双击
两种操作方式实现的功能是一样的，查看文件属性。

Ctrl + insert，Shift + insert
我们都知道复制粘贴组合键是 Ctrl + C，Ctrl + V。但是，你知道吗？除此之外，在 Ctrl + C，Ctrl + V 能用的地方，Ctrl + insert，Shift + insert也可以使用。这个功能通常用在 Ctrl 键被锁定的情况下，比如 cmd ，Terminal 这类命令行终端中。

Ctrl + Shift + Esc
以往我们打开任务管理器窗口用的快捷组合键是 Ctrl + Alt + Delete，通过打开的“安全选项”来选择进入任务管理器，或者直接鼠标右键点击任务栏空白处选择打开任务管理器。其实，我们可以直接通过 Ctrl + Shift + Esc 打开，单手就可以操作，更加方便。

### 代理设置

**windows下 Dos 命令行设置代理**
按需设置对应的地址 + 端口信息，以下为举例：

```sh
set http_proxy=http://10.5.3.9:80
set https_proxy=http://192.168.88.17:8333
```

**windows 自动代理设置脚本**

若编写后存在了 D 盘名称为 proxy.pac 的文件。

则对应的地址为 file://d:\proxy.pac 或者使用 <http://10.1.212.135:8080/proxy.pac>

```js
// url 是正在访问的完整 URL 地址, host 指的是从该 URL 提取出的主机名称
function FindProxyForURL(url, host) {
    if (shExpMatch(host, "10.*") || shExpMatch(host, "127.*")) {
        return "DIRECT";
    } else {
        return "PROXY 10.5.3.9:80";
    }
}
```

### 查看系统版本信息

我的电脑 - 右键 - 属性

Win 10 之前的版本命名规则是：
1803 = 2018年3月版，1909 = 2019年9月版

Win 10 现在的版本命名规则是：
20H2 = 2020 年下半年版，2021H1 = 2021 年上半年版

### 如何快捷拼图

美图秀秀网页版
<https://xiuxiu.web.meitu.com/main.html>

![](https://upload-images.jianshu.io/upload_images/1662509-ad2c4a0781be7dc9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-8a909ed32b0c4dd1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 如何卸载 360 天擎

安装目录一般在
`C:\Program Files (x86)\360\360Safe`

![](https://upload-images.jianshu.io/upload_images/1662509-e55ab40a8eb7bef8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

没有装 360 的话使用重启电脑后选择安全模式, 将指定文件删除即可.

### 终端 相关

CHCP是一个计算机指令，能够显示或设置活动代码页编号。

代码页  描述
65001 UTF-8代码页
950 繁体中文
936 简体中文默认的GBK
437 MS-DOS 美国英语

在 cmd 中输入 CHCP 65001

#### Windows系统环境变量大全

环境变量 详细信息
%ALLUSERSPROFILE% 所有用户 Profile 文件位置
%APPDATA% 应用程序数据的默认存放位置
%CD% 当前目录
%CLIENTNAME% 联接到终端服务会话时客户端的 NETBIOS 名
%CMDCMDLINE% 启动当前 cmd.exe 所使用的命令行
%CMDEXTVERSION% 当前命令处理程序扩展版本号
%CommonProgramFiles% 常用文件的文件夹路径
%COMPUTERNAME% 计算机名
%COMSPEC% 可执行命令外壳（命令处理程序）的路径
%DATE% 当前日期
%ERRORLEVEL% 最近使用的命令的错误代码
**%HOMEDRIVE% 用户主目录所在的驱动器盘符**
%HOMEPATH% 用户主目录的完整路径
%HOMESHARE% 用户共享主目录的网络路径
%LOGONSEVER% 有效的当前登录会话的域名控制器名
%NUMBER_OF_PROCESSORS% 计算机安装的处理器数
%OS% 操作系统的名字（ Windows XP 和 Windows 2000 列为 Windows_NT ）
%Path% 可执行文件的搜索路径
%PATHEXT% 操作系统认为可被执行的文件扩展名
%PROCESSOR_ARCHITECTURE% 处理器的芯片架构
%PROCESSOR_IDENTIFIER% 处理器的描述
%PROCESSOR_LEVEL% 计算机的处理器的型号
%PROCESSOR_REVISION% 处理器的修订号
%ProgramFiles% Program Files 文件夹的路径
%PROMPT% 当前命令解释器的命令提示设置
%RANDOM% 界于 0 和 32767 之间的随机十进制数
%SESSIONNAME% 连接到终端服务会话时的连接和会话名
%SYSTEMDRIVE% Windows 启动目录所在驱动器
%SYSTEMROOT% Windows 启动目录的位置
%TEMP% and %TMP% 当前登录的用户可用应用程序的默认临时目录
%TIME% 当前时间
%USERDOMAIN% 包含用户帐号的域的名字
%USERNAME% 当前登录的用户的名字
%USERPROFILE% 当前用户 Profile 文件位置
%WINDIR% 操作系统目录的位置

## 遇到过的问题

### 系统提示：此应用无法在你的电脑上运行是怎么回事

请检查下载文件的完整性。

## 参考

你可能不知道的几种替代式 Windows 快捷操作 | IT 技术资料分享 <https://www.lmdouble.com/1424236155.html>
