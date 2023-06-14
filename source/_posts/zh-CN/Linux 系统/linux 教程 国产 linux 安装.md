---
title: linux 教程 国产 linux 安装
date: 2019-03-17 17:27:17
updated: 2022-11-05 13:45:00
categories: linux
---

## 优麒麟

优麒麟(英文名为 Ubuntu Kylin)是基于 Ubuntu 的一款官方衍生版。 它是一款专门为中国市场打造的免费操作系统，而且它已经被录入中国政府采购条例名单中。它包括 Ubuntu 用户期待的各种功能，并配有必备的中文软件及程序。

- 官方下载地址 <https://www.ubuntukylin.com/downloads/>
- 阿里云镜像地址 <https://mirrors.aliyun.com/ubuntukylin/>
- 华为云镜像地址 <https://mirrors.huaweicloud.com/ubuntukylin/>

### Win + 优麒麟双系统安装

下载镜像优麒麟 <https://www.ubuntukylin.com/downloads/>

准备一个 U 盘要求：U 盘内存大于 4G；

制作启动盘此处推荐 Ventoy，下载链接：<https://www.lanzoui.com/b01bd54gb>

分配空间磁盘分区是为了给优麒麟操作系统分配空间，默认选择分区尾部的磁盘（考虑到机械硬盘的读写特性，尽可能切靠前的分区）

重启电进入 BIOS 系统插入制作好的 U 盘启动盘，重启电脑，在开机时按 “F2” 进入 BIOS 系统直到出现选择安装方式界面，选择“自定义安装”。首先添加根分区，奇奇在此处分配的大小是 80 GB，大家可以根据自身需求进行分配，但一定要确保之后有充足的空间可供使用。之后，添加 data 和 backup 分区，作为数据分区和备份还原分区，此处分别分配 20G。全部分配完成后点击“下一步”，开始安装优麒麟开源操作系统。等待安装完成。

## 深度操作系统

致力于服务全球 Deepin 用户，系统具有极高的易用性、优秀的交互体验、多款自研应用、全面的生态体系、高效的优化反馈机制为用户提供最好的 Linux 开源体验环境。

- 最新版本 – 深度科技社区 <https://www.deepin.org/zh/download/>
- 阿里云镜像地址 <http://mirrors.aliyun.com/deepin-cd/>

### 统信 UOS

基于深度 Deepin 进行定制，个人用户推荐使用家庭版。

个人用户提供美观易用的国产操作系统。简化安装方式，一键安装，自动高效；同时支持 Linux 原生、Wine 和安卓应用，软件应用生态更加丰富；优化注册流程，支持微信扫码登陆 UOS ID；新增跨屏协同，电脑与手机互联，轻松管理手机文件，支持文档同步修改；对桌面视觉和交互体验进一步优化。统一桌面环境，统信 UOS 让您开机点亮美好新生活。

资源中心 | 统信 UOS 生态社区 <https://www.chinauos.com/resource/download-home>

### 分区注意

ext4 / 建议 20 G 以上
ext4 /home 建议 8 G 以上
swap 是可选项，如果内存大于 4 g 则可以不设置，否则设置为 2 g 为宜。

**如何为主机做备案** 通俗来讲，要开办网站必须先办理网站备案，备案成功后您的域名才可指向接入商处的服务器开通访问。ICP 备案号以工信部网站公共查询为准，查询入口：[http://www.beian.miit.gov.cn](http://www.beian.miit.gov.cn/ "http://www.beian.miit.gov.cn")。

## 多系统安装工具

VentoyRelease <https://www.lanzoui.com/b01bd54gb>
