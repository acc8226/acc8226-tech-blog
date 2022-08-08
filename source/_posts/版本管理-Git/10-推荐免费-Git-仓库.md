---
title: 10-推荐免费-Git-仓库
categories:
  - 版本管理
  - Git
tags:
- git
---

## Git 免费仓库

Gitee 开源中国-基于 Git 的代码托管和研发协作平台【推荐】
<https://gitee.com/>

CODING 代码托管 | 极速 Git 代码仓库服务
<https://coding.net/products/repo>

阿里云效 Codeup
<https://codeup.aliyun.com/>

腾讯工蜂
<https://git.code.tencent.com/>

## 国外三巨头

GitHub【国内访问不太稳定】
<https://www.github.com/>

GitLab
<https://gitlab.com/users/sign_in>

Bitbucket | Git solution for teams using Jira
<https://bitbucket.org/product/>

## Git 启用上传大文件功能

根据 2019 年的统计数据，如果简单使用 git 来上传大文件的话，也不是不可以。

* coding 30 MB
* 阿里云效 50 MB
* 码云 最大为100 MB

coding 提供了 文件网盘功能，普通用户提供了高达 30GB 的容量。

![](https://upload-images.jianshu.io/upload_images/1662509-0ba1972430126817.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 使用 Git LFS 上传大文件

### 下载和安装 Git LFS

* 下载：
  * Linux Debian 和 RPM packages：[https://packagecloud.io/github/git-lfs/install](https://packagecloud.io/github/git-lfs/install)

  * Mac: brew install git-lfs
  * Windows：目前lfs已经集成在了[Git for Windows](https://gitforwindows.org/)中，直接下载和使用最新版本的Windows Git即可。
  * 直接下载二进制包：[https://github.com/git-lfs/git-lfs/releases](https://github.com/git-lfs/git-lfs/releases)
  * 依据源码构建：[https://github.com/git-lfs/git-lfs](https://github.com/git-lfs/git-lfs)

* 安装：
  * 如果你选择使用二进制包下载后安装，直接执行解压后的*./install.sh*脚本即可，这个脚本会做两个事情：
    * 在*$PATH*中安装Git LFS的二进制可执行文件
    * 执行`git lfs install`命令，让当前环境支持全局的LFS配置

### 让本地新仓库支持 Git LFS

```sh
# 初始化一个仓库
$ mkdir big-repo
$ cd big-repo
$ git init
Initialized empty Git repository in /Users/dyrone/big-repo/.git/
# 让仓库支持LFS
$ git lfs install
Updated pre-push hook.
Git LFS initialized.
# install成功后，仓库的pre-push钩子将被替换和生效
```

想了解更多 Git Large File Storage 的内容，可以参考 <https://git-lfs.github.com/>
