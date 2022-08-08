---
title: Windows-下-SVN-客户端使用
categories:
  - 版本管理
  - SVN
tags:
- SVN
---

## Windows 主推小乌龟 SVN

https://tortoisesvn.net/downloads.html (请选择正确的 32 / 64位版本)

SVN 安装
<https://www.runoob.com/svn/svn-install.html>

和 TortoiseSVN 使用教程
<https://www.runoob.com/svn/tortoisesvn-intro.html>

## Apache Subversion command line tools (可选)

这款(便携, 快速)SVN命令行的使用**Apache Subversion command line tools**，以下载该版本[Apache-Subversion-1.13.0](https://www.visualsvn.com/files/Apache-Subversion-1.13.0.zip) 为例.

注意这是一个可以在cmd下使用的命令行工具:
请解压后把里面bin目录这个路径添加到环境变量的path.  或者临时使用则键入:
`set path=YourSvnBinPath;`

对于命令行工具, 重点是掌握 import 和 export , 以及 checkout 和 commit 操作的使用.

例如

```sh
export yourSvnPath yourLocalPath [ --username someOne]
checkout yourSvnPath yourLocalPath [ --username someOne]
```

## Tortoise SVN 下遇到的问题

#### TortoiseSVN -无法查看log，提示Want to go offline，时间显示 1970 问题

![svn查看log时，提示“Want to go offline”错误](./imgs/Windows-%E4%B8%8B-SVN-%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8/1.png)

![关闭 或 cancel该提示对话框后，显示1970时间](./imgs/Windows-%E4%B8%8B-SVN-%E5%AE%A2%E6%88%B7%E7%AB%AF%E4%BD%BF%E7%94%A8/2.png)

**解决方法**

1. 试过很多方法，如：编辑svnserve.conf，设置“anon-access=none”；修改“passwd”、“authz”文档，都无效。
2. 无意看到一个方法，，**完美解决：右键 -> TortoiseSVN -> Revison graph**
3. 如果是最新版的svn可能也会存在这个问题，我就是这个装了新版本才发现这个问题

## 参考

SVN—Subversion Command-Line Client - SVN Book - VisualSVN Help Center
<https://www.visualsvn.com/support/svnbook/ref/svn/>

SVN-无法查看log，提示Want to go offline，时间显示1970问题 - zxingchao2009的专栏------用博客记录技术成长的点点滴滴 - CSDN博客
<https://blog.csdn.net/zxingchao2009/article/details/78780343>
