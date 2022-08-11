---
title: 15. GitHub 使用总结
date: 2022.03.31 14:52:43
categories:
  - 版本管理
  - Git
tags:
- git
---

## 使用 ssh 连接 git 仓库

生成 ssh 密钥

```sh
ssh-keygen -t rsa -C "你的邮箱地址"
```

验证是否可正常访问

```sh
ssh -T git@github.com
```

## GitHub 中的 Fork 工作流程

fork 的两种主要工作流程：

1\. fork 并且更新一个仓库

![fork1](http://likai.test.upcdn.net/%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86-Git/15-GitHub-%E4%BD%BF%E7%94%A8%E6%80%BB%E7%BB%93/fork1.png)

2\. 同步一个 fork

Joe 和其余贡献者已经对这个项目做了一些修改，而你将在他们的修改的基础上，还要再做一些修改。在你开始之前，你最好”同步你的 fork”，以确保在最新的复制版本里工作。下面是你要做的：

![fork2](http://likai.test.upcdn.net/%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86-Git/15-GitHub-%E4%BD%BF%E7%94%A8%E6%80%BB%E7%BB%93/fork2.png)

3\. 比较一下 fork 和同步工作流程的区别

当你最初 fork 一个仓库的时候，信息的流向是从 Joe 的仓库到你的仓库，然后再到你本地计算机。但是最初的过程之后，信息的流向是从 Joe 的仓库到你的本地计算机，之后再到你的仓库。

## 我对 fork 的理解

### git fork 项目更新原则

为保证 master 分支纯净，自己只在特性分支进行二次开发

1\. 配置当前 fork 的仓库的原仓库地址

```sh
git remote add upstream <原仓库git地址>
```

2\. 查看当前仓库的所有地址

```sh
git remote -v
```

3\. 使用 fetch 更新对于仓库

```sh
git fetch upstream
```

4\. 切换到 master 分支，合并 upstream/master 分支到本地 master

```sh
git merge upstream/master
```

5\. 如果需要自己 github 上的 fork 仓库保持同步更新，则执行 git push 操作

```sh
git push origin master
```

### 我的操作

1. 下载源码 `git clone -o gitee https://gitee.com/mirrors/ThingsBoard.git`
2. 添加仓库地址 `git remote add origin <原仓库git地址>`
3. 将 master 的追踪分支从 gitee/master 切换到 origin/master
4. git push 即可推送本地 master 到 origin 的 master 分支

## 遇到过的问题

### Git - Failed to connect to github.com port 443: Timed out 访问超时的解决方案

1\. 访问 [https://www.ipaddress.com/](https://www.ipaddress.com/) 网址查询下面所需的地址对应的 IP，输入 hostname 或 domain 查询，比如查询 github.com 的 IP。

2\. 修改 hosts 文件，在 `C:\Windows\System32\drivers\etc\hosts` 中添加单条记录

```host
140.82.114.3 github.com
```

3\. 刷新 DNS 缓存

```sh
ipconfig /flushdns
```

### The unauthenticated git protocol on port 9418 is no longer supported 解决方案

由于存在安全问题，git 协议 on 9418 端口不再提供支持，目前官网只提供 https 方式或者 ssh 方式。

方法一：手动去该项目地址的 github 网址，改成 https 方式或者 ssh 方式其中一种。
方法二：全局替换

```sh
git config --global url."https://github.com/".insteadOf git://github.com/
```

### 代码推送成功 github 不显示小绿格（贡献度）

原因
github 邮箱和 git push 邮箱不一致

解决方案
单项目设置 `git config user.email “你的邮件地址”`
或全局设置 `git config --global user.email “你的邮件地址”`

注：gitee 平台也是此类原因。

## 参考

浅谈 GIT 中的 Fork_撕裂石头的博客-CSDN 博客_git 中的 fork
<https://blog.csdn.net/qq_29947967/article/details/80519113>
