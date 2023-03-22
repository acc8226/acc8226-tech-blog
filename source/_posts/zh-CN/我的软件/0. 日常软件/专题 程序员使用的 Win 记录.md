---
title: 专题 程序员使用的 Win 记录
date: 2018-04-07 15:30:24
updated: 2023-02-16 21:53:00
categories:
  - 收藏
  - 日常软件
---

## WAMP 80 端口被 Microsoft-HTTPAPI/2.0 占用的解决办法

好的，这意味着你的系统已经安装了 Microsoft IIS 或者其他一些 MS 技术来报告这个签名---- 出于某种原因，他们正在 Windows 的后续版本中这样做。如果你不打算使用它，你可以卸载它，它不是 windows 的一个组成部分，所以它被卸载不会影响窗口的正常操作，如果你需要稍后再安装它，它作为标准操作系统的一部分，所以你不需要做任何精心设计的聪明。

开始 -> 控制面板 -> 程序和功能点击左边菜单中的‘打开和关闭窗口功能’链接。等待列表加载，然后找到“ Internet 信息服务”

1. World Wide Web Publishing Service服务关闭
2. SQL Server Reporting Services（MSSQLSERVER)服务 服务关闭
3. IIS
4. Web Deploy 2.0 (Web Deployment Agent Service)
5. MS Sql Server Reporting service.
6. BranchCache ( Windows 8.1 )
7. SQL Server VSS Writer

## Windows 下查看端口占用

1\. Windows 平台
在 windows 命令行窗口下查看被占用端口对应的 PID

```bat
C:\>netstat -aon|findstr "80"
TCP     127.0.0.1:80         0.0.0.0:0               LISTENING       2448
```

2\. 可自行选择关掉程序或者杀掉进程

```bat
taskkill /T /F /PID 2448
```

3\. 【可选】查看端口被哪个程序给占用了
C:\>tasklist|findstr "2448"
thread.exe                    2016 Console                 0     16,064 K

### Windows 常用命令

CMD 命令：开始 -> 运行 -> 键入 cmd 或 command（在命令行里可以看到系统版本、文件系统版本）

appwiz.cpl：程序和功能
calc：启动计算器
cmd.exe：CMD 命令提示符

自动关机命令
　 Shutdown -s -t 600：表示 600 秒后自动关机
　 shutdown -a ：可取消定时关机
　 Shutdown -r -t 600：表示 600 秒后自动重启

control：控制面版
devmgmt.msc：设备管理器
desk.cpl：屏幕分辨率
diskmgmt.msc：磁盘管理
eventvwr：事件查看器
explorer：打开资源管理器
Firewall.cpl：Windows 防火墙
hdwwiz.cpl：设备管理器
inetcpl.cpl：Internet 属性
logoff：注销命令
main.cpl：鼠标属性
mmsys.cpl：声音
magnify：放大镜实用程序
mspaint：画图
Msra：Windows 远程协助
mstsc：远程桌面连接
netstat : an(TC)命令检查接口
notepad：打开记事本
osk：打开屏幕键盘
powercfg.cpl：电源选项
winver：关于Windows
write：写字板

## 终端 相关

CHCP 是一个计算机指令，能够显示或设置活动代码页编号。

代码页  描述
65001 UTF-8代码页
950 繁体中文
936 简体中文默认的GBK
437 MS-DOS 美国英语

在 cmd 中输入 CHCP 65001

## Windows 系统环境变量大全

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

## 将在此处打开命令改为 CMD 或 Powershell

微软的 CMD 也就是命令提示符已经伴随了我们很多年了，这些年来 CMD 已经勤勤恳恳地默默工作着，虽然没有图形化的界面，但是其干净整洁的操作环境仍然受到了大家的欢迎。

随着微软 Win10 系统的流行，更加强大的 PowerShell 崭露头角，采用 .net 架构编写的 Powershell 性能更加强大，实现的功能也丰富。此时略显老迈的 CMD 心有力而力不足。而微软也尝试使用各种方法使 PowerShell 取代目前的 CMD。

从 Win10 Build 14971 开始，用户已经无法通过按住 Shift、右击资源管理器空白处来选择“在此处打开命令提示符”了，那么对于这些用户来说，究竟有没有办法将 CMD 找回来呢？当然办法还是有的，这时候就要用到万能的注册表了。

1、用 “Windows+R” 打开运行窗口输入 “regedit” 并按回车。或直接在 Cortana 栏中输入 “regedit”，单击打开注册表管理器；

2、定位到以下位置：

> “计算机\HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command”

补充：因为 Win10 创新者版本（Win10 Creators）提供了[注册表路径的简化](http://www.ithome.com/html/win10/272872.htm)，所以，“HKEY_CLASSES_ROOT”完全可以用 “HKCR” 取代，以上地址可以精简为 “HKCR\Directory\Background\shell\Powershell\command”

![image](http://upload-images.jianshu.io/upload_images/1662509-00f6f15a622c0897.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10 小技巧：如何将在此处打开命令改为CMD或Powershell？")

3、在左侧 command 项上点击鼠标右键，选择“权限”，在出现的窗口中再选择下方的“高级”。

![image](http://upload-images.jianshu.io/upload_images/1662509-62970a651308d9fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为 CMD 或 Powershell？")

4、如果你的所有者为 TrustedInstaller，那么首先点击上方“更改”，将当前用户账户名添加进去，例如“xxxxxx@live.cn”（见下方图二），然后点击后方“检查名称”——“确定”。完成后，再在下方将当前用户的权限从读取改为“完全控制”即可。这样就可以正常修改注册表键值了。

![image](http://upload-images.jianshu.io/upload_images/1662509-30fe79515eb8281c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为CMD或Powershell？")

5、将右侧默认字符串值改为 “cmd.exe /s /k pushd "%V"”，确定保存即可。

![image](http://upload-images.jianshu.io/upload_images/1662509-cbaf565e29939a65.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为 CMD 或 Powershell？")

6、这样处理之后，在资源管理器空白处按住 Shift 按键右击鼠标，出现的选项仍然是“在此处打开 Powershell 窗口”，但点击后实际开启的功能确实已经变成了“在此处打开命令提示符”。

7、要改回去，只要把以上键值改回以下键值即可，注意不含两侧引号。

“powershell.exe -noexit -command Set-Location -literalPath '%V'”

从 Win10 Build 14971 开始，微软就开始将 Powershell 取代 CMD 成为主命令 Shell，取代的决心非常显著，但微软也提供了折衷的解决方案，通过“设置——个性化——任务栏”，关闭以下功能即可回到此前状态。但在最新的版本中，目前该选项只能控制右击开始按钮的功能选项，无法还原右键菜单，所以感到不习惯的朋友不妨参照以上方法设置下。

![image](http://upload-images.jianshu.io/upload_images/1662509-e34c7a669740a461.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为 CMD 或 Powershell？")

另外，本文并不是在否定基于 .net 架构 Powershell 本身的强大，感兴趣的朋友不妨参阅以下文章进一步了解。

## 参考

文章来源: IT 之家(<https://www.ithome.com/html/win10/282909.htm>)
