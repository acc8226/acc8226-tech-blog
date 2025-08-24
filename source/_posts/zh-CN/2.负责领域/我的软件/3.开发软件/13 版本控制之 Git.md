---
title: 版本控制之 Git 软件推荐
date: 2022-12-13 14:16:00
updated: 2023-02-16 20:31:00
categories:
  - 收藏
  - 专业软件
---

## 终端软件

<https://git-scm.com/downloads> | [Git-for-windows 阿里源地址](https://registry.npmmirror.com/binary.html?path=git-for-windows/)

windows 平台我一般会下载便捷版。

## 图形化软件

windows 环境下已经自带了 gitk，如果觉得还是不好使的话。Java 开发者使用的 ide 也有相应的支持，一般足够使用。

### 【windows 推荐】TortoiseGit

[TortoiseGit](https://tortoisegit.org/download/) 和 windows 资源管理器有很好的集成

<!-- more -->

#### 使用 ppk 密钥

默认安装 tortoisegit，会使用 PuTTY（plink）作为默认的 ssh 方式，声称对 windows 集成更好。

如果不想改这种方式的话，就只能让 git 的 ssh.exe 使用 PuTTY 的密钥了，tortoisegit 继续使用 PuTTY。

因此可以使用 PuTTY key generator 进行生成/转换。

plink 介绍：plink 可以让我们直接在命令行制定好命令，然后执行，完成后自动关闭 session。对于自动化的执行命令和工作非常有好处。

#### 将 pageant 设置为开机自启且自动加载 SSH Key

1. 在 “启动” 菜单中打开“启动”目录
2. 右键空白处，选择新建快捷方式
3. 选择 pageant 的位置，并按填入 ppk 的位置，例如 `"C:\Program Files\TortoiseGit\bin\pageant.exe" C:\Users\zhangsan\.ssh\id_rsa.ppk`

这样系统每次启动就会自动加载 ppk 了

#### TortoiseGit 技巧 之 导出变更后的文件

![TortoiseGit 技巧 之 导出变更后的文件](https://upload-images.jianshu.io/upload_images/1662509-4bf5ccfaf3cb4115.gif?imageMogr2/auto-orient/strip)

### GitHub Desktop【全平台】

GitHub 官方客户端工具，可管理 git。

### SourceTree【全平台】

[Sourcetree](https://www.sourcetreeapp.com) | Free Git GUI for Mac and Windows

not

* 【win mac 付费】[Fork](https://fork.dev/) 自从用了小乌龟，还是不喜欢这种风格
* 【全平台 付费】[GitKraken](https://www.gitkraken.com/) 付费才好用
* 【全平台 付费】[SmartGit](https://www.syntevo.com/smartgit/) 付费不推荐
* 【全平台】[Sublime Merge](https://www.sublimemerge.com/) 感觉不好用
