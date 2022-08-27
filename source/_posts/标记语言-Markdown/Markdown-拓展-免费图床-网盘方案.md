---
title: Markdown-拓展-免费图床-网盘方案
date: 2019.11.17 18:18:44
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 前言

最近时常在 gitee.io 上写一些 markdown 格式的文章，特别是对于后端小伙伴对前端不太熟，如果不太需要主题美化，纯粹是拿 md 写个接口文档，md 是再合适不过了，md 格式可再通过 Mkdocs 这种 python 工具渲染出最终的页面。

本文我主要讨论的是在如何获取好用免费的图床方案，最好还能自定义文件名。

## 【排除】自己的服务器放置图床

服务器到期后迁出太麻烦, 不考虑。

## 【排除】使用阿里云, 腾讯云等其他品牌的云存储

用法：新建存储桶，需要把存储桶的访问权限设置为公有读私有写。

对象存储是一种存储海量文件的分布式存储服务，用户可通过网络随时存储和查看数据。服务虽好, 付费就不考虑。

<!-- more -->

## 【排除】七牛图床

存储服务创建完成后，需要配置一个融合 CDN 域名，融合CDN域名简单来说就是指资源对象的外链域名，七牛云提供了融合 CDN 的测试域名，官方提示为：七牛融合 CDN 测试域名，每个域名每日限总流量 10GB，每个测试域名自创建起 **30 个自然日后系统会自动回收**，仅供测试使用并且不支持 Https 访问。

**七牛测试域名 1 个月失效的问题(网友提供的解决方法)**
七牛提供的测试域名 1 个月就失效了，通常是够用的 。 如果失效了，也不用担心，找到原始的 markdown 文件，用下面的命令对文件做个替换即可（new.bkt.clouddn 域名需要按照实际进行替换）。

```sh
 sed -i "s#//.*bkt.clouddn#//new.bkt.clouddn#g" file.md
```

目前七牛不再提供测试域名了, 只能挥手告别。

## 【其他方案】又拍云存储空间+流量

[又拍云图床](https://www.upyun.com/league)提供了每月 10GB 免费存储空间 + 15GB 免费 CDN 流量(HTTP/HTTPS 均可用)

要求： 需要在申请的网站 / 应用底部添加又拍云 LOGO 及链接，然后填写申请表进行申请。一般而言在提交审核后几个工作日就会完成审核并发放资源。这里注意不能篇数太少。

## (最终方案一)尝试使用 gitee 图床

开源中国旗下的码云仓库，在国内比较靠谱。

使用方式：创建一个新的公开代码仓库，貌似现在私有也行。

举例上传一图片，原始地址为 `https://gitee.com/kaiLee/html-nav/blob/master/snipaste.png`,则将 blob 改为 raw 则是图片的原始地址了：`https://gitee.com/kaiLee/html-nav/raw/master/snipaste.png`

## (最终方案二)使用 Github Page + jsdelivr + picgo 的搭配

github 服务器在国外, 直接访问肯定太慢. 直到看到了 **[PicGo](https://github.com/Molunerfinn/PicGo), [jsdelivr](https://www.jsdelivr.com/), [github](https://github.com/)** 的三剑客组合。

教程：[-----请参考这里的视频教程-----](https://www.bilibili.com/video/av65336062?from=search&seid=4753922999762898690)

### jsdelivr 的使用

使用 CDN 加速来优化 github 资源打开速度，jsDelivr + Github 便是免费且好用的 CDN。

> CDN 释义：全称是 Content Delivery Network，即内容分发网络。CDN 是构建在网络之上的内容分发网络，依靠部署在各地的边缘服务器，通过中心平台的负载均衡、内容分发、调度等功能模块，使用户就近获取所需内容，降低网络拥塞，提高用户访问响应速度和命中率。CDN 的关键技术主要有内容存储和分发技术。——百度百科

图片地址示例：
<https://cdn.jsdelivr.net/gh/acc8226/JsDelivrCDN/img/20191117180214.jpg>

### PicGo 的使用

PicGo 是一款开源跨平台的免费图片上传工具以及图床相册管理软件，它能帮你快速地将图片上传到微博、又拍云、阿里云 OSS、腾讯云 COS、七牛、GitHub、sm.ms、Imgur 等常见的免费图床网站或云存储服务上，并自动复制图片的链接到剪贴板里。

#### PicGo 配置说明

* 设定仓库名：按照【用户名 / 图床仓库名】的格式填写
* 设定分支名：【master】
* 设定Token：粘贴之前生成的【Token】
* 指定存储路径：填写想要储存的路径，如【images/】，这样就会在仓库下创建一个名为 images 的文件夹，图片将会储存在此文件夹中
* 设定自定义域名：它的的作用是，在图片上传后，PicGo 会按照【自定义域名+上传的图片名】的方式生成访问链接，放到粘贴板上，因为我们要使用jsDelivr加速访问，所以可以设置为【https://cdn.jsdelivr.net/gh/用户名/图床仓库名 】

jsDelivr 参考格式: The URL structure is /gh/user/repo@version/file.js

#### PicGo 的自定义配置

![](https://upload-images.jianshu.io/upload_images/1662509-63eb930b124b85ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于追求效率的键盘党而言，你还可以使用键盘快捷键 `CTRL+SHIFT+P` (Win / Linux) 或者 `Command+SHIFT+P` (macOS) 来快速上传剪贴板里的 (第一张) 图片。

#### PicGo 问题总结

**由于 PicGo release  包总是下载不下来的问题。**
目前找到比较好的方式是用 **Free Download Manager** 直接下载 [http://github.com](https://link.zhihu.com/?target=http%3A//github.com) 开头的**原链接**, 可以自动跳转并多线程下载. 如果中途中断, 可在右键菜单里选择"更改 URL"然后之间点确定就会重新跳转新的临时下载地址并续传。

## (最终方案三)不使用任何图床

了解自己为啥使用图床，就是一种外部链接而已。方便对方在有网络的环境下完整展示用到的图片。

如果是对外暴露展示自己的本机项目或者部署到自己的网站，完全可以使用相对路径。这样就不使用任何图床。

用法：使用 `./xxx.png` 这种写法。不要小看了前面的 `./`, 这种写法目前在 vuePress兼容性比较好。另外我在 docsify 和 Mkdocs 中试了也没问题。

## 相关资源

Github 官网
<https://github.com/>

jsdelivr 官网
<https://www.jsdelivr.com/>

PigGo 下载
<https://github.com/Molunerfinn/PicGo/releases>

## 参考

[活动作品](https://www.bilibili.com/blackboard/activity-newstar4.html?msource=caitiao "叮！你的笔记本电脑和季度大会员等待领取中！")关于博客的最稳定的图床方案
<https://www.bilibili.com/video/av65336062?from=search&seid=4753922999762898690>

目前最稳定的免费图床方案 - 301技术-HuanHao
<https://301technology.cn/2019/08/03/picgojsdelivrgithub/>

Github+jsDelivr+PicGo 打造稳定快速、高效免费图床
<https://blog.csdn.net/qq_36759224/article/details/98058240>

PicGo - 免费开源的图片上传与管理工具 (Markdown写作贴图 / 跨平台图床应用)
<https://www.iplaysoft.com/picgo.html>
