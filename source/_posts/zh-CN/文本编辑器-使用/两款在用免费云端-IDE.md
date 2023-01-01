---
title: 两款在用免费云端-IDE
date: 2020-05-01 16:28:33
updated: 2020-05-01 16:28:33
categories: 文本编辑器-使用
---

优点: 无需手动安装；预设常见 Java , Python, JS 等环境, 支持创建网页预览，在线开发调试。

## 实验楼内置 IDE (1小时短期使用)

搭载 Ubuntu 系统, 这好像是个 bug, 非会员使用该课程也提供外网环境. 可用于一些简单实验, 每次可申请 1 个小时使用时长, 可续期。此 [Spring 框架课程](https://www.shiyanlou.com/courses/578)可连外网

预装 mysql, 以下命令可直接启用数据库

```sh
sudo service mysql start
mysql -u root
```

已预装 c 语言环境, 可运行 c 语言

```sh
gcc -o hello hello.c
./hello
```

## 腾讯云 Cloud Studio (可长期使用)

> Cloud Studio 是基于浏览器的集成式开发环境（IDE），您可以使用它进行代码编写和编译运行。
> Cloud Studio 和本地 IDE 相比具有以下优势：无需安装，跨平台，只要有浏览器就可以使用；预置常用环境，无需手动安装；支持创建网页预览，在线开发调试。

* 数量限制：目前每个用户最多可以创建 5 个工作空间，并且只能同时运行一个工作空间，如果您需要打开另一个工作空间需要先关闭当前运行中的工作空间。

* 时间限制：每个用户每日可以使用工作空间共四小时，超出时间将不可使用（连接云主机的工作空间无此限制）。

目前 Cloud Studio 使用 Coding.net 账号登录，您可以先免费注册一个 CODING 团队。注册完成后，点击右上角导航中的图标就可以回到 Cloud Studio 中进行云端开发了。

新版登陆地址(每天畅享4小时)
<https://e.coding.net/signin>

### 腾讯 cloud studio 简单入门

项目所在路径

```sh
/root/RemoteWorking
```

如果选择了 spring boot 模板，则可用运行该项目

```sh
mvn spring-boot:run
```

启动预览窗口
现在让我们来启动预览窗口。再次按下 Command + Shift + P 或 Ctrl + Shift + P，打开命令面板，输入 preview，在命令列表中点击 Preview: Open Preview Tab。
