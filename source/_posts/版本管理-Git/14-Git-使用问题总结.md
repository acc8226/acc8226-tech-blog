---
title: 14-Git-使用问题总结
categories:
  - 版本管理
  - Git
tags:
- git
---
---

## 问题分析 : could not lock config file

%HOMEDRIVE%%HOMEPATH%/.gitconfig 的问题

在我的电脑上 HOME 的值是 `%HOMEDRIVE%%HOMEPATH%` 竟然不识别。已知 %homedrive% 指操作系统所在盘默认为`C:`，`%HOMEPATH%` 指的是用户所在目录，举例说明`\Users\zhangsan`。

所以手动改成 `C:\Users\hp` 即可。

```text
C:\Users\hp>echo %HOMEDRIVE%%HOMEPATH%
C:\Users\hp
```

设置 HOME 环境变量为自己的用户目录

![](https://upload-images.jianshu.io/upload_images/1662509-4bd31644e369a6d6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Git pull 失败

提示 refusing to merge unrelated histories

解决方案：添加 --allow-unrelated-histories

```sh
git merge origin/master --allow-unrelated-histories
```

## [Git 中的 AutoCRLF 换行符问题](https://www.cnblogs.com/flying_bat/p/3324769.html)

建议把 autocrlf 设置为 false，并且把所有文件转换为 Linux 编码（即LF\n)

```sh
# 提交检出均不转换
git config --global core.autocrlf false`
```

三种取值 true, input, false 的解释

![](https://upload-images.jianshu.io/upload_images/1662509-65a7a820b77dd9b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## git clone 时，提示 warning: remote HEAD refers to nonexistent ref, unable to checkout.

原因是 .git 目录下 .git/refs/heads 不存在 HEAD 指向的文件。

键入

```sh
git branch -a
```

将展示所有分支，如果你看到了 remotes/origin/oneplus/QC8998_N_7.1 分支可用的话，然后 `git checkout remotes/origin/oneplus/QC8998_N_7.1 -b NameYouWant` 即可解决。

## git 查看某个分支是从哪个分支拉出来的

git reflog --date=local | grep 分支名

## fatal: remote origin already exists

```sh
git remote add origin**************
fatal: remote origin already exists.（报错远程起源已经存在。）
```

解决方法

1、先输入 git remote rm origin
2、再输入 git remote add origin**************

或者直接更新 url

```sh
git remote set-url origin https://github.com/yourname/learngit.git (这个是你的复制的仓库地址)
```
