---
title: Win 教程 3-2 高级使用
date: 2021-06-03 21:27:25
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

## 更改 terminal / cmd 命令行工具的外观

<https://github.com/microsoft/terminal/releases/tag/1904.29002>

```bat
colortool.exe -b OneHalfDark.itermcolors
```

当然还可以手动修改字体样式

![手动修改字体样式](/images/收藏-技术软件/Win-系统相关设置/手动修改字体样式.png)

## 修改 host 文件

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

## 设置环境变量

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

## 设置软件开机启动

同样也可以用系统命令来打开“启动文件夹”。

在运行里面输入 `shell:startup`，打开之后把要启动的快捷方式放进窗口即可。

## 参考

你可能不知道的几种替代式 Windows 快捷操作 | IT 技术资料分享 <https://www.lmdouble.com/1424236155.html>
