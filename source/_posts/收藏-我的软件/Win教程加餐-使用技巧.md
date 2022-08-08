---
title: Win教程加餐-使用技巧
categories:
  - 收藏
  - 我的软件
---

## 效率：妙用快捷键

**Windows 快捷键**
文件重命名 F2
文件 / 内容 全选 Ctrl + A
Ctrl + C 复制
Ctrl + V 粘贴
剪切操作 Ctrl + X ，配合粘贴可完成移动操作
显示桌面 Win + D
切换程序 ALT + Tab

**chrome 谷歌浏览器系列常用快捷键**
Ctrl + J 打开下载窗口

## 显示优化：Clear Type 增强文字的显示清晰度

ClearType 是由微软公司在其 Windows 操作系统中提供的荧幕字体平滑工具，让Windows字体更加漂亮。ClearType主要是针对 **LCD 液晶显示器**设计，可提高文字的清晰度。基本原理是，将显示器的 R, G, B 各个次像素也发光，让其色调进行微妙调整，可以达到实际分辨率以上(横方向分辨率的三倍)的纤细文字的显示效果。

![1. 控制面板中找到字体选项](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-28ccec8ea72629a5.png)

![2. 下一步完成调节](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-fc5e0a3f1710a64d.png)

## 美化: 手动更换必应美图的壁纸

推荐一个每日推荐美图的网站
微软 Bing 搜索 - 国内版  <https://cn.bing.com/>

![动图](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-d10b44f7e29fde29.gif)

最后根据需要可以稍微裁剪一下到合适的屏幕分辨率, 在设置中找到更换锁屏图片选项即可。

![](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-909f4a26783fb8e5.png)

## 美化: 更换鼠标指针的样式

我一般会在[IT之家-鼠标指针频道](https://zhuti.ithome.com/cursor/ )直接浏览或搜索关键字找到你喜欢的鼠标指针样式并下载

下载完成后解压, 找到资源包中的 “install.inf” 文件，右键选择“安装”即可。
最后在传统桌面空白区域，右击个性化，打开“更改鼠标指针”；在鼠标“指针”方案中，选择你刚才安装的鼠标指针方案。

![](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-ce3833b33454c886.png)

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

## 适用于 Windows 10/11 的触摸板手势

* 选择项目：点击触摸板。
* 滚动：将两个手指放在触摸板上，然后以水平或垂直方向滑动。
* 放大或缩小：将两个手指放在触摸板上，然后收缩或拉伸。
* 显示更多命令（类似于右键单击）：使用两根手指点击触摸板，或按右下角。
* 查看所有打开的窗口：将三根手指放在触摸板上，然后朝外轻扫。
* 显示桌面：将三根手指放在触摸板上，然后朝里轻扫。
* 在打开的窗口之间切换：将三根手指放在触摸板上，然后向右或向左轻扫。
* 打开 Cortana：用三根手指点击触摸板。
* 打开操作中心：用四根手指点击触摸板。
* 切换虚拟桌面：将四根手指放在触摸板上，然后向右或向左轻扫。

> 部分手势仅适用于精确式触摸板，因此当你无法使用某个手势时不必过于担心。

## windows 设置-设备(蓝牙、打印机、鼠标)

根据需要添加设备即可。

![添加设备](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/1662509-3a1064b74bacb753.png)

## win11 底部任务栏靠左

![win11底部任务栏靠左](./imgs/Win%E6%95%99%E7%A8%8B%E5%8A%A0%E9%A4%90-%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7/win11%E5%BA%95%E9%83%A8%E4%BB%BB%E5%8A%A1%E6%A0%8F%E9%9D%A0%E5%B7%A6.png)
