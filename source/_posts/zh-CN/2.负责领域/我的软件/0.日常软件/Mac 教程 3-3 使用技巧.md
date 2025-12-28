---
title: Mac 教程 3-3 使用技巧
date: 2019-10-01 12:34:26
updated: 2022-11-05 13:45:00
categories:
  - 收藏
  - 日常软件
---

## 记录

### 如何在当前文件夹下打开终端:  finder -> 服务 -> 服务偏好设置

![](https://upload-images.jianshu.io/upload_images/1662509-bd2e4f32af695326.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 压缩文件的时候不想要带 .DS_Store

我的方法很简单, 压缩软件下载安装第三方工具. 例如我使用的 eZip，按住 command 选中后右键 -> 服务 -> eZip 压缩即可

### 如何在 Mac 上启用 root 用户或更改 root 密码

启用或停用 root 用户

1. 选取苹果菜单 > “系统偏好设置”，然后点按“用户与群组”（或“帐户”）。
1. 点按锁形图标，然后输入管理员名称和密码。
1. 点按 “登录选项”。
1. 点按 “加入”（或“编辑”）。
1. 点按“打开目录实用工具”。
1. 点按“目录实用工具”窗口中的锁形图标，然后输入管理员名称和密码。
1. 从“目录实用工具”的菜单栏中：

* 选取“编辑” > “启用 Root 用户”，然后输入要用于 root 用户的密码。
* 或者选取“编辑”>“停用 Root 用户”。

<!-- more -->

![](https://upload-images.jianshu.io/upload_images/1662509-fe39046c1543ff67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> root 用户帐户不适合日常使用。它的权限允许更改 Mac 所必需的文件。要撤销此类更改，您可能需要[重新安装系统软件](https://support.apple.com/zh-cn/HT204904)。您应在完成任务后停用 root 用户。

### 修改 host 文件

1. 打开 finder(访达) 后前往 `/private/etc/hosts`
2. 并将其拉到桌面上，也就是复制一份 hosts 文件到桌面上，修改此文件
3. 编辑完后就可以把桌面上的 hosts 文件拉回到 /private/etc 文件夹中”，会弹出询问框点击“确认”，并“取代”即可

### 升级了 macOS Sierra 后，command line tools 报错

```sh
xcrun: error: invalid active developer path
 (/Library/Developer/CommandLineTools), missing xcrun at:
 /Library/Developer/CommandLineTools/usr/bin/xcrun
```

敲入 `xcode-select  --install` 终端输入完美解决
