## 前言

受制于 Xshell 的收费，因此总在寻思构建一套免费的 ssh 方案。

## putty 终端

双击即可直接使用

用它来远程管理 Linux 十分好用，其主要优点如下:
◆ 完全免费;
◆ 在 Windows 9x/NT/2000 下都能运行的非常好;
◆ 支持协议广

### 用快捷方式实现自动登录

首先创建 putty.exe 的快捷方式到桌面；然后运行 putty，输入 host name、port、saved session’s name，点击保存，假设 session 名为“qa server”，随后关闭窗口；最后右击 putty 快捷方式，属性，目标，加上如下参数
` -load "qa server" -ssh -l {username} -pw {password}`。

或者这么整也行

```sh
"C:\Program Files\PuTTY\putty.exe" -load YOUR_SESSNAME -P YOUR_PORT -pw YOUR_PASSWORD -ssh YOUR_USERNAME@YOUR_HOST_NAME
```

-m 选项的释义：-m file   read remote command(s) from file

于是乎就有了自动登录后执行默认的命令：

```sh
putty [-pw password] [-m file] user@ip_addr
```

### 对 putty 乱码的处理

1\. 一般为 gbk 和 utf-8 这两种格式常见. 可以先行尝试设置为 utf-8。
2\. 如若不生效后. 可再次尝试改为中文字体（GB中文编码）。
3\. 打开的配置窗口左边选择 Appearance，在右边点 Font settings 里面的 Change 按钮，选择好中文字体，比如：宋体、新宋体之类。
4\. 然后设置 Translation

![Translation](./imgs/%E5%8D%95%E5%B9%B3%E5%8F%B0-Win-putty-kitty-pscp-%E4%BD%BF%E7%94%A8/1.png)

5\. 最后保存下配置，几乎就能 解决 99% 编码问题了

### 调整 putty 窗口的宽高

![调整宽高](./imgs/%E5%8D%95%E5%B9%B3%E5%8F%B0-Win-putty-kitty-pscp-%E4%BD%BF%E7%94%A8/2.png)

## pscp 用于传文件

pscp.exe - PuTTY Secure Copy client
PSCP (PuTTY Secure Copy client)是 PuTTY 提供的文件传输工具，通过 SSH 连接，在两台机器之间安全的传输文件，可以用于任何 SSH（包括 SSH v1、SSH v2）服务器。

举例:

文件从本地上传到服务器, 格式为 pscp [源文件] [Linux用户名]@[Linux服务器IP地址]:[Linux服务器目标目录]

将文件从服务器下载到本地，格式为 pscp [Linux用户名]@[Linux服务器IP地址]:[Linux服务器源文件] [本地目标文件夹]

举例：

```sh
pscp -pw abcddeg YourUserName@YourHostName:/abc/my.log D:\my.log
```

```text
PuTTY Secure Copy client
Release 0.73
Usage: pscp [options] [user@]host:source target
       pscp [options] source [source...] [user@]host:target
       pscp [options] -ls [user@]host:filespec
Options:
  -V        print version information and exit
  -pgpfp    print PGP key fingerprints and exit
  -p        preserve file attributes
  -q        quiet, don't show statistics
  -r        copy directories recursively
  -v        show verbose messages
  -load sessname  Load settings from saved session
  -P port   connect to specified port
  -l user   connect with specified username
  -pw passw login with specified password
  -1 -2     force use of particular SSH protocol version
  -4 -6     force use of IPv4 or IPv6
  -C        enable compression
  -i key    private key file for user authentication
  -noagent  disable use of Pageant
  -agent    enable use of Pageant
  -hostkey aa:bb:cc:...
            manually specify a host key (may be repeated)
  -batch    disable all interactive prompts
  -no-sanitise-stderr  don't strip control chars from standard error
  -proxycmd command
            use 'command' as local proxy
  -unsafe   allow server-side wildcards (DANGEROUS)
  -sftp     force use of SFTP protocol
  -scp      force use of SCP protocol
  -sshlog file
  -sshrawlog file
            log protocol details to a file
```

## 高级方案：使用 KiTTY 并集成 WinSCP

1. KiTTY 全量包 <https://github.com/cyd01/KiTTY/releases>

KiTTY 是基于 Putty 的改进版，加入了一些实用特性，可以完美替代 putty。比如记住密码自动连接等，下面是几个常用的设置，记录一下：

* 编码设置: Window -> Translation -> Remote character set : UTF-8
* 自动登录设置: Connetcion -> Data -> Auto-login username : root
Connetcion -> Data -> Auto-login password : password，还可以在 Command 中输入自定义要执行的命令。

集成 PSCP
kitty.ini 填入

```ini
WinSCPPath=D:\xxxxx\kscp.exe
```

2\. WinSCP 下载绿色版 <https://winscp.net/eng/downloads.php>

集成 WinSCP
kitty.ini 填入

```ini
WinSCPPath=D:\xxxx\WinSCP.exe
```

## 相关网址

putty download
<https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html>

kitty download
<https://github.com/cyd01/KiTTY/releases>

27 Best SSH clients for Windows as of 2021 - Slant <https://www.slant.co/topics/149/~best-ssh-clients-for-windows#21>
