---
title: Markdown-客户端选择
date: 2020.02.06 11:58:16
updated: 2022-08-14 22:54:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 网页端

**stackedit (推荐)**
开箱即用, 在主流 markdown 语法支持的基础上, 还支持数学公式, 各种流程图。
<https://stackedit.io/app>

## 客户端

* VS Code
* marktext【免费、推荐】
* Typora【付费】

上面推荐的这 3 款都是跨平台的应用。

另外 Mac 独享 的 MWeb4(付费)，因为我看中的的是自动导出为博客和图片上传服务(图床)。

## 最终选择

优先考虑到跨平台的优势，当然我选择 **VS Code**  + 插件 markdownlint。再搭配 **marktext** 复制表格，预览和导出。

**不推荐产品**

* 马克飞象: 付费, 且对图床的实现方式有待商榷。
* 为知笔记: 之后收费了。

## 遇到的问题

问题：Typora 过期解决方法，Typora 打不开了怎么办，提示 The beta version of typora is expired, please download and install a newer version

解决：
按 Windows + R 打开运行窗口，输入 regedit，点确定
打开注册表，依次展开计算机\HKEY_CURRENT_USER\Software\Typora
然后在Typora上右键，点权限，选中Administrtors，把权限全部设置为拒绝

## 参考

stackedit 在线 markdown 编辑
<https://stackedit.io/app>

使用 GitHub 搭建免费图床/网盘(CDN加速)
<https://www.jianshu.com/p/2097bef17cbe>
