---
title: Eclipse 常用插件
date: 2017-06-08 13:32:55
updated: 2022-11-09 13:56:00
categories: IDE-使用
---

## 生成类图工具(ModelGoon)插件

一个 Eclipse 插件，能将 Eclipse 中现有的 java 类生成类图，可以进行 Java 包的依赖分析，基于 UML 图进行模型设计，以及逆向工程（即从已有源代码生成类图）。

1. 下载 ModelGoon 到本地；
2. 打开 Eclipse，点击 Help，选择 Install new software；
3. 点击 add 按钮，选择 archive，在找到 ModelGoon 所在的位置，确定安装。

## 使用方法

1\. 新建所需图, 一般放到所在项目根目录

![](http://upload-images.jianshu.io/upload_images/1662509-1762de3d71e25490.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2\. 把关联的类拖进生成的 mg* 文件中，将自动生成关联关系.

## 打开文件/文件夹位置插件

Download the latest version of the plugin on the ["Release" page](https://github.com/samsonw/OpenExplorer/releases), then put it into your Eclipse plugin directory "ECLIPSE_HOME/plugins" (or "ECLIPSE_HOME/dropins" for 3.3+ eclipse)

On Mac OS X, you can find the "plugins/dropins" folder by right click on "/Applications/Eclipse" (or the Eclipse executable), then "Show Package Contents".

Restart Eclipse workbench.

To uninstall, just remove the jar.

## 下载地址

<https://www.jianguoyun.com/p/DSy7_58Q2o7zBxjb-NAEIAA>
