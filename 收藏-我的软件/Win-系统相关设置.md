## 更改 terminal / cmd 命令行工具的外观

<https://github.com/microsoft/terminal/releases/tag/1904.29002>

```bat
colortool.exe -b OneHalfDark.itermcolors
```

当然还可以手动修改字体样式

![手动修改字体样式](./Win-系统相关设置/手动修改字体样式.png)

## 修改 host 文件

hosts 文件是 Windows 系统中一个负责 IP 地址与域名快递解析的文件，以 ASCLL 格式保存。计算机在键入域名的时候，首先会去看看 hosts 文件汇总有没有关于此域名IP地址的记录。为了提高计算机访问某一网站的速度，修改hosts文件是很好的办法。这里直接编辑即可。

```text
C:\Windows\System32\drivers\etc\HOSTS
```

## 设置环境变量

建议能设置系统的环境变量，就不设置单用户的环境变量。右击我的电脑->系统属性->高级->环境变量

## 一些微软官方软件

GitHub - **microsoft/terminal**: The new Windows Terminal and the original Windows console host, all in the same place!
<https://github.com/microsoft/terminal>

微软 **PowerToys** 小工具合集 - 免费给 Win10 加装各种增强新功能的效率利器 - 异次元软件下载
<https://www.iplaysoft.com/powertoys.html>

### NetSpeedMonitor - 一款监控 windows 的网速监控软件

我一直想找一款可以搜寻所有 wifi 接入设备的软件, 用于替代 mac 平台的 LanScan for mac. 就找到这个了。

> NetSpeedMonitor 是一个免费的实用工具，你可以使用它来观察你的网络连接速度。在它的帮助下，您可以跟踪网络问题，分析传输的数据量，并查看每月的流量统计数据。Florian Gilles 开发的轻量级 Windows 软件易于使用，并允许您直接从任务栏查看下载和上传速度。

NetSpeedMonitor
<https://netspeedmonitor64.en.softonic.com/>
