---
title: Win 教程 3-3 使用技巧
date: 2021-06-03 21:27:25
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

再次强调用快捷键、鼠标手势等工具, 可极大提高学习工作效率。

记住安全永远是第一要务。下载软件也尽量从官网下载或者应用商店安装，这样更安全，也避免从其他渠道下载到恶意软件。

## 技巧

### 善用浏览器

目前浏览器也能做很多事儿。若用好浏览器，可以少装很多软件。例如：

* 订火车票可以选择 12306
* 携程 / 飞猪订个票
* 使用优爱腾看视频
* 听歌可选 [网易云音乐](https://music.163.com)
* 看个新闻可选 今日头条 或者 网易新闻，[腾讯网](https://www.qq.com/)

### 浏览器技巧

强制刷新页面：按下 Ctrl + F5（Windows）或 Cmd + Shift + R（Mac）来强制刷新页面。这会清除浏览器缓存，确保页面加载最新的文件。

<!-- more -->

### 超酷的滑动关机

打开 C 盘，定位到 C:\Windows\System32 目录，查询是否有一个 SlideToShutDown.exe 应用程序。接着右键点击该应用程序，选择发送到桌面快捷方式，这样就在桌面建立了一个快捷方式。

选择刚刚创建的快捷方式，你可以重命名为自己喜欢的名字，这里我改为“滑动关机”。

### 学会盲打

**为了更好的进行录入，一定要学会盲打。**

打字通 2016 官方免费下载_打字练习软件下载_金山打字通官方网站
<https://www.51dzt.com/>

## 记录

### 按键的英文

` backtick
~ tilde

`! exclamation mark`
`@ at`
`# pound / hash / hashtag`
`$ dollar sign`
`% percent`

^ caret
& ampersand, and, reference, ref
`*` asterisk, multiply, star, pointer 星号
() brakets, parenthesis 单数形式 parentheses 复数形式 圆括号
( open parenthesis, open paren，open bracket 左圆括号
) close parenthesis, close paren，close bracket 右圆括号

`- hyphen` 连字符
`_ underscore` 下划线

`= equals`
`+ plus sign`

[] square brackets
[ open bracket 左方括号
] close bracket 右方括号

{}
{ open brace, open curly 左花括号
} close brace, close curly 右花括号

\ backslash / backward slash反斜线
| vertical bar, vertical virgule

; semicolon
: colon

' single quote
" double quote

, comma 逗号
< less than

. dot / period 句号
`> greater than`

/ slash, divide, oblique 斜线，斜杠，除号
? question mark

### 修改 host 文件

hosts 文件是操作系统中一个负责 IP 地址与域名快递解析的文件。计算机在键入域名的时候，首先会去看看 hosts 文件汇总有没有关于此域名 IP 地址的记录。

Host 文件所在路径

```text
%WINDIR%\System32\drivers\etc
```

或者

```text
C:\Windows\System32\drivers\etc
```

修改 hosts 有什么作用？

* 强制指定域名的 IP，加快域名解析 (省略了联网查询 DNS 的步骤)，也能绕过 DNS 污染与劫持。
* 为局域网某些 IP 的机器配置一个“网址别名”，方便自己记忆和访问。比如配置一个 nas.com 访问局域网里的 NAS；gongsi 访问公司网站等等。
* 将域名指向到不可访问的 IP 地址，达到屏蔽不健康网站、屏蔽垃圾广告网址的效果；同理也能禁止系统、软件、网站访问* 某些指定的网址；
* 开发或测试应用时，利用 hosts 将域名临时指向到测试服务器IP，可以方便自己测试，同时又不影响他人和线上的应用。

怎样修改 hosts？

不同的操作系统修改 hosts 文件的方法不一样，它所在的路径也不一样。常见操作系统的 hosts 文件的位置路径为：

* Windows 系统 Hosts 文件路径：C:\Windows\System32\drivers\etc\hosts
* Mac 系统 hosts 文件路径：/etc/hosts
* Linux 系统的 hosts 文件一般也是在：/etc/hosts
* Android 系统的 hosts 文件路径：/system/etc/hosts (需要Root权限修改)

怎样清空 DNS 缓存？

* 在 Windows 下命令行执行：ipconfig /flushdns
* 在 macOS 下执行命令：sudo killall -HUP mDNSResponder
* 如果你使用 Chrome 浏览器，那么可以访问：chrome://net-internals/#dns，然后点击「Clear host cache」按钮来清空浏览器里的 DNS 缓存。

### 设置代理

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

### 设置环境变量

在哪进行设置：右击我的电脑->系统属性->高级->环境变量

有的软件只认可系统的环境变量，设置成用户的环境变量不适用。

set 设置临时环境变量
1、查看所有环境变量：cmd 输入 set
2、查看环境变量：set path
3、修改/添加环境变量：set 变量名=变量内容

setx 可以永久设置环境变量

1\. 永久设置环境变量
setx /m name "value"

2\. 永久追加环境变量
setx -m name "%name%;value"

### 设置软件开机启动

同样也可以用系统命令来打开“启动文件夹”。

在运行里面输入 `shell:startup`，打开之后把要启动的快捷方式放进窗口即可。

### win11 打开文件夹卡顿 win11 打开文件夹很慢的解决办法

1. 双击打开此电脑
2. 点击此电脑顶部的更多
3. 点击查看，在下面找到”在单独的进程中打开文件夹窗口，点击确定即可。

### Windows 系统环境变量大全

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

### Win 10 设置选项命令大全

ms-settings 打开设置
ms-settings:batterysaver 节电模式
ms-settings:batterysaver-settings 节电模式设置
ms-settings:batterysaver-usagedetails 电池用量
ms-settings:personalization 个性化
ms-settings:colors个性化-颜色
ms-settings:personalization-colors 个性化-颜色
ms-settings:personalization-background 个性化-背景
ms-settings:lockscreen个性化-锁屏
ms-settings:personalization-start 个性化-开始
ms-settings:taskbar 个性化-任务栏
ms-settings:themes 个性化-主题
ms-settings:network 网络和 Internet
ms-settings:datausage 数据使用量
ms-settings:network-mobilehotspot 移动热点
ms-settings:mobilehotspot移动热点
ms-settings:network-proxy 代理
ms-settings:network-vpn VPN
ms-settings:network-airplanemode飞行模式
ms-settings:airplanemode 飞行模式
ms-settings:network-dialup 拨号
ms-settings:network-ethernet 以太网
ms-settings:network-status 状态
ms-settings:network-wifi WiFi
ms-settings:wifiWiFi
ms-settings:network-wifisettings 管理已知网络
ms-settings:dateandtime 时间和语言-日期和时间
ms-settings:speech 语音
ms-settings:regionlanguage 区域和语言
ms-settings:easeofaccess-closedcaptioning 轻松使用-隐藏式字幕
ms-settings:easeofaccess-highcontrast 高对比度
ms-settings:easeofaccess-magnifier 放大镜
ms-settings:easeofaccess-narrator 讲述人
ms-settings:easeofaccess-otheroptions 其他选项
ms-settings:easeofaccess-keyboard键盘
ms-settings:easeofaccess-mouse鼠标
ms-settings:emailandaccounts 账户-电子邮件和应用账户
ms-settings:yourinfo 你的信息
ms-settings:sync同步你的设置
ms-settings:otherusers家庭和其他人员
ms-settings:signinoptions 登录选项
ms-settings:workplace访问工作单位或学校
ms-settings:privacy隐私
ms-settings:privacy-accountinfo 账户信息
ms-settings:privacy-backgroundapps 后台应用
ms-settings:privacy-calendar 日历
ms-settings:privacy-callhistory 通话记录
ms-settings:privacy-contacts 联系人
ms-settings:privacy-customdevices 其他设备
ms-settings:privacy-email 电子邮件
ms-settings:privacy-feedback 反馈
ms-settings:privacy-location 位置
ms-settings:privacy-messaging 消息传送
ms-settings:privacy-microphone麦克风
ms-settings:privacy-radios 无线电收发器
ms-settings:privacy-speechtyping 语音、墨迹书写和键入
ms-settings:privacy-webcam 相机
ms-settings:windowsinsider 更新和安全-获取 Insider Preview 版本
ms-settings:windowsupdateWindows 更新
ms-settings:windowsupdate-history 更新历史
ms-settings:windowsupdate-options 高级设置
ms-settings:windowsupdate-restartoptions 重启选项
ms-settings:windowsupdate-action 检查更新
ms-settings:backup 备份
ms-settings:activation激活
ms-settings:developers针对开发人员
ms-settings:recovery 恢复
ms-settings:windowsdefender Windows Defender
ms-settings:appsfeatures 系统-应用和功能
ms-settings:notifications 通知和操作
ms-settings:powersleep 电源和睡眠
ms-settings:defaultapps 默认应用
ms-settings:phone-defaultapps 默认应用(Win10 Mobile)
ms-settings:deviceencryption 关于
ms-settings:about 关于
ms-settings:display 显示
ms-settings:screenrotation 显示
ms-settings:multitasking 多任务
ms-settings:maps离线地图
ms-settings:maps-downloadmaps 下载地图
ms-settings:storagesense存储
ms-settings:optionalfeatures 管理可选功能
ms-settings:project投影到这台电脑
ms-settings:tabletmode平板模式
ms-settings:autoplay 自动播放
ms-settings:bluetooth 蓝牙
ms-settings:connecteddevices 已连接设备
ms-settings:mousetouchpad 鼠标和触摸板
ms-settings:usb USB
ms-settings:pen 笔
ms-settings:printers 打印机和扫描仪
ms-settings:typing 输入
ms-settings:wheel 滚轮

### 更改 cmd 命令行工具的外观【已废弃】

<https://github.com/microsoft/terminal/releases/tag/1904.29002>

```bat
colortool.exe -b OneHalfDark.itermcolors
```

当然还可以手动修改字体样式

![手动修改字体样式](/images/收藏-技术软件/Win-系统相关设置/手动修改字体样式.png)

### WSA 安卓子系统【已废弃】

教程 - Win 11 安装 wsa 安卓虚拟机 - 简书
<https://www.jianshu.com/p/5e07a0e97a27>

## 参考

你可能不知道的几种替代式 Windows 快捷操作 | IT 技术资料分享 <https://www.lmdouble.com/1424236155.html>
