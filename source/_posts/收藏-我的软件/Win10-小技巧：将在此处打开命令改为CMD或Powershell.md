---
title: Win10-小技巧：将在此处打开命令改为 CMD 或 Powershell
date: 2018.04.07 15:30:24
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 我的软件
---

微软的 CMD 也就是命令提示符已经伴随了我们很多年了，这些年来 CMD 已经勤勤恳恳地默默工作着，虽然没有图形化的界面，但是其干净整洁的操作环境仍然受到了大家的欢迎。

随着微软 Win10 系统的流行，更加强大的 PowerShell 崭露头角，采用.net 架构编写的Powershell性能更加强大，实现的功能也丰富。此时略显老迈的 CMD 心有力而力不足。而微软也尝试使用各种方法使 PowerShell 取代目前的 CMD。

从 Win10 Build 14971 开始，用户已经无法通过按住 Shift、右击资源管理器空白处来选择“在此处打开命令提示符”了，那么对于这些用户来说，究竟有没有办法将 CMD 找回来呢？当然办法还是有的，这时候就要用到万能的注册表了。

1、用 “Windows+R” 打开运行窗口输入 “regedit” 并按回车。或直接在 Cortana 栏中输入 “regedit”，单击打开注册表管理器；

2、定位到以下位置：

> “计算机\HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command”

补充：因为 Win10 创新者版本（Win10 Creators）提供了[注册表路径的简化](http://www.ithome.com/html/win10/272872.htm)，所以，“HKEY_CLASSES_ROOT”完全可以用“HKCR”取代，以上地址可以精简为“HKCR\Directory\Background\shell\Powershell\command”

![image](http://upload-images.jianshu.io/upload_images/1662509-00f6f15a622c0897.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10 小技巧：如何将在此处打开命令改为CMD或Powershell？")

3、在左侧 command 项上点击鼠标右键，选择“权限”，在出现的窗口中再选择下方的“高级”。

![image](http://upload-images.jianshu.io/upload_images/1662509-62970a651308d9fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为 CMD 或 Powershell？")

4、如果你的所有者为 TrustedInstaller，那么首先点击上方“更改”，将当前用户账户名添加进去，例如“xxxxxx@live.cn”（见下方图二），然后点击后方“检查名称”——“确定”。完成后，再在下方将当前用户的权限从读取改为“完全控制”即可。这样就可以正常修改注册表键值了。

![image](http://upload-images.jianshu.io/upload_images/1662509-30fe79515eb8281c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为CMD或Powershell？")

5、将右侧默认字符串值改为 “cmd.exe /s /k pushd "%V"”，确定保存即可。

![image](http://upload-images.jianshu.io/upload_images/1662509-cbaf565e29939a65.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为CMD或Powershell？")

6、这样处理之后，在资源管理器空白处按住 Shift 按键右击鼠标，出现的选项仍然是“在此处打开Powershell 窗口”，但点击后实际开启的功能确实已经变成了“在此处打开命令提示符”。

7、要改回去，只要把以上键值改回以下键值即可，注意不含两侧引号。

> “powershell.exe -noexit -command Set-Location -literalPath '%V'”

从Win10 Build 14971 开始，微软就开始将 Powershell 取代 CMD 成为主命令Shell，取代的决心非常显著，但微软也提供了折衷的解决方案，通过“设置——个性化——任务栏”，关闭以下功能即可回到此前状态。但在最新的版本中，目前该选项只能控制右击开始按钮的功能选项，无法还原右键菜单，所以感到不习惯的朋友不妨参照以上方法设置下。

![image](http://upload-images.jianshu.io/upload_images/1662509-e34c7a669740a461.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "Win10小技巧：如何将在此处打开命令改为 CMD 或 Powershell？")

另外，本文并不是在否定基于 .net 架构 Powershell 本身的强大，感兴趣的朋友不妨参阅以下文章进一步了解。

## 参考

文章来源: IT之家(<https://www.ithome.com/html/win10/282909.htm>)
