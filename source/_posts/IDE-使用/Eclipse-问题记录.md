---
title: Eclipse-问题记录
date: 2017-05-21 10:56:21
updated: 2022-11-09 13:56:00
categories: IDE-使用
---

## Java 相关

**如何删除 eclipse 自动生成的 TODO 标签**
![英文版](https://upload-images.jianshu.io/upload_images/1662509-cb293aab1b48af67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![中文版](https://upload-images.jianshu.io/upload_images/1662509-af2daba4c6dcbb49.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
注意这里删除的是构造方法的 todo 标记

## ~~安卓 ADT 相关~~

 [**eclipse 无法导出 android 签名包的问题**](http://blog.csdn.net/wojuedezhehenmafanya/article/details/8115066)

Export aborted because fatal lint errors were found.These are listed in the Problems view.Either fix these before running Export again,or turn off "Run full error check when exporting app" in the [Android](http://lib.csdn.net/base/android) > Lint Error checking preference page.

解决：

![](http://upload-images.jianshu.io/upload_images/1662509-a2bf64399ff544a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**升级了 sdk 之后运行出错**
Failed to load D:\Android-Studio\sdk\build-tools\26.0.1\lib\dx.jar
 Unable to build: the file dx.jar was not loaded from the SDK folder

解决：
查看可用 sdk 可用的 buildtools 并设置即可。

## 参考

* 删除 eclipse 自动生成的 //TODO Auto-generated - 黄彪博客 - CSDN博客
<https://blog.csdn.net/hbiao68/article/details/52682823>
