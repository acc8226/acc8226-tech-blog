---
title: 华为云耀L实例使用
date: 2023-10-07 22:14:28
updated: 2023-10-07 22:14:28
---

## 华为云耀云服务器 L 介绍

华为云耀云服务器 L 实例是一款面向中小企业和开发者的轻量级云服务器，提供了丰富的应用镜像和多种技术支持，可以帮助客户在云端快速构建各种应用。

云耀云服务器L实例采用了多种技术，包括计算、存储、镜像安装、备份等，可以在不同区域中部署，一个区域发生故障不会影响其他区域的云服务器。此外，它还可以通过虚拟私有云（VPC）建立专属的网络环境，设置子网、安全组，并通过弹性公网 IP 实现外网链接。通过云硬盘（EVS）服务实现数据存储，并通过云硬盘备份服务实现云耀云服务器 L 实例数据的备份和恢复。

云服务器备份（CBR）提供对云耀云服务器L实例的备份保护服务。支持对云耀云服务器L实例中的所有云硬盘（系统盘和数据盘）进行备份，并利用备份数据恢复云耀云服务器L实例数据。主机安全（HSS）则可以提升云耀云服务器L实例的整体安全性，通过入侵检测、漏洞管理、基线检查功能，可识别并管理云服务器中的信息资产，实时监测云服务器中的风险，降低服务器被入侵的风险。

云耀负载均衡（HCES ELB）是将访问流量根据分配策略分发到后端多台云耀云服务器L实例的流量分发控制服务。它可以通过流量分发扩展应用系统对外的服务能力，同时通过消除单点故障提升应用系统的可用性。

## 购买实例

### 准备工作

在创建云耀云服务器L实例之前，需要先注册华为帐号并开通华为云，并为帐号充值。请保证帐号有足够的资金，以免创建云耀云服务器L实例失败。

由于云耀云服务器 L 可自由选择系统和应用镜像，所以我们可以轻松做到开箱即用。本次选择云耀云服务器 L + 宝塔面版的经典组合。

### 操作步骤

1. 登录[华为云耀云服务器 L 实例控制台](https://www.huaweicloud.com/product/hecs-light.html)。
2. 单击“购买资源”，在下拉列表中选择“购买 云耀服务组合”或者“购买 云耀云服务器L实例”。
3. 镜像可以选择默认的宝塔。宝塔面版是流行的 PHP 集成环境管理及服务器运维管理工具。支持 Web 端管理，一键创建网站、FTP、数据库、SSL。

![](https://img-blog.csdnimg.cn/98ef108a0a914dde99856e11e01c8615.png)

## 初始化宝塔面板

登录宝塔管理页面并安装基础组合软件。

1\. 获取宝塔管理页面的管理员用户名及密码

登录云服务器，运行

```sh
sudo cat /credentials/password.txt
```

命令行获取宝塔管理页面用户名及密码并记录。

```sh
========= credentials for bt =========
bt_user: administrator
bt_password: 80TwmwxIsiOnbW!
```

2\. 登录宝塔面板

在服务器“概览”页“镜像信息”中，左击“管理”登录管理页面。

![在这里插入图片描述](https://img-blog.csdnimg.cn/ad72029678914403af9cac2631fdbec0.png)

3\. 获取的用户名密码，单击“登录”。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2867e91bfede4a03ad45fdb2de07f0f6.png)

注：登录后如果出现需要绑定宝塔账号才能使用完整功能的提示后，可单击“未有账号，免费注册”在宝塔官网注册。

4\. 安装基础组合软件。

一般而言，可以选择 LNMP（推荐）“一键安装”。

![在这里插入图片描述](https://img-blog.csdnimg.cn/41f1a50f83be458a943652f5eb8e537c.png)
当然，您后续也可以在“软件商店”中自行选择并安装其他软件。

## 宝塔面板使用

### 安装软件

在“软件商城”菜单中，可以对软件进行安装、卸载等管理操作。

### 管理文件

在“文件”菜单中，您可以对文件进行复制、粘贴、剪切、删除、重命名、压缩、刷新、新建文件、新建目录等操作。

### 管理日志

在“日志”菜单中，根据不同的日志类型将日志做了分类，您可以单击不同类型的日志页签查看、清空日志。

## 使用云耀 L 搭建博客

借助华为云耀服务器L，可以轻松搭建网站。这里我将介绍使用 hugo 搭建静态博客并发布到 apache 站点。

### 安装并启用 apache2

![](https://img-blog.csdnimg.cn/1a5dc0d6b6594370842a5c4aa4198c8d.png)

![](https://img-blog.csdnimg.cn/86538e711a7d4c8d98de5674bc9d88cf.png)

安装完之后，输入华为服务器外网 ip 应该看到“没有找到站点”页。

![](https://img-blog.csdnimg.cn/c0e692e837e64f3d85ba6e2e0e58e2ed.png)

### 安装 hugo 并构建网站

安装 hugo

```sh
sudo snap install hugo
```

安装后可以在终端查看 hugo 版本

```sh
hugo version
```

初始化 hexo 站点

```sh
cd ~
mkdir mysite
cd mysite
hugo new site quickstart
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo "theme = 'ananke'" >> hugo.toml
```

新建文章

```sh
hugo new content posts/my-first-post.md
```

找到该 md 文件，可用 vim 打开

```sh
vim /root/mysite/quickstart/content/posts/my-first-post.md 
```

并替换文章的主体内容。

```md
+++
title = '我的第一篇博客'
date = 2023-10-05T22:09:30+08:00
draft = true
+++
## 介绍

This is **bold** text, and this is *emphasized* text.

Visit the [Hugo](https://gohugo.io) website!

-- 来自华为云耀云服务器L
```

发布站点

```sh
hugo --buildDrafts    # or -D
```

这将构建您的站点，并将文件发布到 public 目录。

最后一步，我们拷贝生成内容到 apache 的默认站点目录。

```sh
cp -r /root/mysite/quickstart/public/* /www/server/apache/htdocs
```

至此，打开浏览器，在地址栏中键入公网 ip ，例如我这里是 <http://121.36.6.192/> 即可看到最新网站内容。

--博客主页--

![列表页](https://img-blog.csdnimg.cn/871e53ab7a144892b6e6ecedee3cf564.png)

--文章详情页--

![详情页](https://img-blog.csdnimg.cn/b6c7f4244f074bb08a4faf76a4614605.png)

## 注意事项

### 安全组配置

配置安全组的入方向访问规则，确保可以正常访问网站。

单击云耀云服务器 L 实例卡片，进入资源页面。在左侧列表中单击“云耀云服务器L实例”，单击云服务器名称，进入云服务器详情页面。然后可选择“安全组”页签，单击“添加规则”。

### 注意计费方式

云耀云服务器L实例套餐内包含每月固定免费流量包，固定流量使用完后将产生超额流量。超额流量以按流量计费的方式收取费用。

## 华为云耀 L 使用感受

### 优点

* 按需付费，按需定制项设置合理。
* 专注应用使用，很多方面做到了开箱即用。从而避免了繁琐的配置。
* 性能较为稳定，官网说数据传输时延低，满足了游戏、音视频等低网络时延场景的高要求。
* 云耀云服务器 L 功能持续更新，不仅 2023 年 8 月有内容更新，9 月份又新增了“支持增配数据盘”和“支持数据盘、云备份支持扩容”等内容。

新用户现在开通有特价优惠，V0 新用户专享优惠，2核2G3M 89元/年！建议一次性开通 3 年的版本。

### 槽点

* 网页终端不太好用，建议使用本地终端软件进行体验，我推荐使用跨平台的 Termius。
* 当前云耀云服务器L实例暂时不支持切换系统。官方说系统切换功能在后续版本中已规划。
  
## 参考资料

1\. 云耀云服务器 L 实例 _【最新】_轻量云服务器_轻量服务器_轻量应用服务器-华为云
<https://www.huaweicloud.com/product/hecs-light.html>

2\. 部署宝塔面板_云耀云服务器 L 实例_最佳实践_使用宝塔面板管理服务器_华为云
<https://support.huaweicloud.com/bestpractice-hcss/practice_bt_0004.html>