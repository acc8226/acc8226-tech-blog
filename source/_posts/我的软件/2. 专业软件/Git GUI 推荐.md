---
title: Git GUI 推荐
date: 2022-12-13 14:16:00
updated: 2022-12-13 14:16:00
categories:
  - 收藏
  - 软件专题
  - 专业软件
---

windows 环境下已经自带了 gitk，如果觉得还是不好使的话。一般 Java 开发者使用的 ide 也有相应的支持，足矣支持使用。

## SourceTree（跨平台）

Sourcetree | Free Git GUI for Mac and Windows
<https://www.sourcetreeapp.com/>

## TortoiseGit（windows 独享）

TortoiseGit 和 windows 资源管理器有很好的集成, 推荐使用.
[Download – TortoiseGit – Windows Shell Interface to Git](https://tortoisegit.org/download/)

### 使用 ppk 密钥

默认安装 tortoisegit，会使用 PuTTY（plink）作为默认的 ssh 方式，声称对windows集成更好。

如果不想改这种方式的话，就只能让 git 的 ssh.exe 使用 PuTTY 的密钥了，tortoisegit 继续使用 PuTTY。

因此可以使用 PuTTY key generator 进行生成/转换。

plink 介绍：plink可以让我们直接在命令行制定好命令，然后执行，完成后自动关闭session。对于自动化的执行命令和工作非常有好处。

### 将 pageant 设置为开机自启且自动加载 SSH Key

1. 在“启动”菜单中打开“启动”目录
2. 右键空白处，选择新建快捷方式
3. 选择 pageant 的位置，并按填入 ppk 的位置，例如 `"C:\Program Files\TortoiseGit\bin\pageant.exe" C:\Users\hairong\.ssh\id_rsa.ppk`

这样系统每次启动后就会自动加载 ppk 了

### TortoiseGit 技巧 之 导出变更后的文件

![TortoiseGit 技巧 之 导出变更后的文件](https://upload-images.jianshu.io/upload_images/1662509-4bf5ccfaf3cb4115.gif?imageMogr2/auto-orient/strip)
