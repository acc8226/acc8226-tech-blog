---
title: 合集-PC用日常软件
date: 2023-03-22 21:02:00
updated: 2024-01-30 22:50:00
categories: 我的创作
---

安全永远是第一要务。下载软件也尽量从官网下载，这样更安全，也避免从其他渠道下载到恶意软件。

注：
以下内容谨代表个人观点。
软件上尽量选择跨平台在搭配特定系统特有软件即可满足大部分使用场景。

## 日常

### 必备

#### 1. 电脑管家

win 7/8：[【win 安装版】腾讯电脑管家](https://guanjia.qq.com/) 或 [【win 安装版】360 安全卫士极速版](https://weishi.360.cn/)

win 10/11：普通 windows 用户依旧可以选择安装管家或者卫士，且由于现在最新版 win 10 自带了[【win 安装版】微软电脑管家](https://pcmanager.microsoft.com/zh-cn)，再搭配[【win 安装版】火绒安全软件](https://www.huorong.cn/)即可。

- - -

【mac】腾讯柠檬清理<https://lemon.qq.com/>

主打清理电脑垃圾文件，一键释放磁盘空间。因 App Store 审核限制，完整版内部分功能无法上架（例如应用卸载等）。建议去官网下载完整版。

- - -

【linux】 是否需要

#### 2. 浏览器

* [【win 安装版】360 极速浏览器X](https://browser.360.cn/ee/) 安全防护永远要放在第一位，鼠标悬停切换标签功能值得点赞 或者 火狐 
* [【mac】360 极速浏览器](https://browser.360.cn/ee/mac/index.html) 或者 火狐
* 【linux】360 安全浏览器

Firefox 可作为有效补充，由于其出色的播放视频的稳定性。且对 win 7 依旧有支持的 ESR 版本。

#### 3. 压缩解压

* [【win 安装版】Bandizip](https://www.bandisoft.com/) 智能解压和压缩文件预览功能特别好用
* [【mac】The Unarchiver【App Store版】](https://theunarchiver.com/)或者官网直装版
* linux 系统一般自带 tar 和 zip 命令。

#### 4. 输入法

如果你是 Win11 用户，那么自带的微软输入法非常不错，如果趁手的话不需要安装额外输入法。

额外的，我会推荐【win mac】[微信输入法](https://z.weixin.qq.com/)，特有云粘贴板功能，现已支持跨设备粘贴文字和图片，但如果是老系统我会选择体积更小的小狼毫输入法。

or

* QQ 输入法 几年没更新了但依旧非常的清爽。注意：打出的字没有在屏幕
* [RIME 小狼毫输入法](https://rime.im/) 不到 10M 的体积非常清爽，但是偶有 bug 谨慎使用

not

* 手心输入法  已经几年没有再更新了且对 4G 内存的 win 7 而言有点卡
* 紫光华宇输入法 对 4G 内存的 win 7 而言有点卡
* 百度输入法 不想用新版本但我找不到旧版本差评
* [搜狗输入法智慧版](https://pinyin.sogou.com/zhihui/) 臃肿

- - -

mac 平台

【mac win】[微信输入法](https://z.weixin.qq.com/) 特有云粘贴板功能。

not

* [mac 版搜狗输入法](https://pinyin.sogou.com/mac/) 和微信输入法比起来没啥优势
* mac 版百度输入法，曾经卡过一次，体验不太好，颜值不过可以

- - -

linux 平台

搜狗 <https://shurufa.sogou.com/linux>

百度和讯飞都有支持，据说还有个 ibus。

### 1. 工具类

#### 1. 鼠标手势

首推【绿色版】的 [FastGestures 鼠标/触控板/屏手势](https://fg.zhaokeli.com/)，如果提示 dll 缺失，则可以换成 【win 免费 安装版】WGestures 1 或者【收费 安装版 win mac】WGestures 2 鼠标手势 <https://www.yingdev.com/projects/wgestures2>

这绝对是效率神器。

- - -

mac 平台

【mac】betterAndBetter 免费且比目前付费的 wg 2 功能更加强大，还自带 mac 上需要的翻转鼠标功能，于是我卸载了 Scroll Reverser。

- - -

linux 平台据说 easystroke 还能用。

```sh
apt install easystroke
```

#### 2. 键盘增强

【win】【自制】捷键

or

【win】MyKeymap-2.0 <https://xianyukang.com/MyKeymap.html> | GitHub 地址 <https://github.com/xianyukang/MyKeymap>

槽点是 win 7 用不了

- - -

mac 平台

【mac】hammerspoon + 自制脚本

#### 3. 截图

[【win】PixPin](https://pixpinapp.com/) 顺便期待 mac 版的推出

or

[sharex](https://getsharex.com/) 留存，可以截图和简单编辑图还有 OCR 识别

not

* 【win mac】Snipaste <https://zh.snipaste.com/> 免费版不支持长截图
* 【win】【新版收费】 FSCapture
* 【win】picpick_portable 说不上哪不好

- - -

mac 平台

我目前一直 Snipaste。其实我一直在等待 PixPin mac 版发布。

not

* 单独的 ishot 免费版有水印，且免费版不能贴图
* 单独的 Snipaste 免费版功能有限

#### 4. 护眼

1. 【win mac】【安装版】flux <https://justgetflux.com/>
2. EyesGuard 定时提醒眼睛休息 ~~由于作者说微软商店不再提供更新~~，所以还是去 github 下载最新版本
<https://github.com/avestura/EyesGuard/releases/>

EyesGuard 需要 .Net 4.8 以上，老款 win 7 只能选择 [FadeTop](http://www.fadetop.com/) 或者 eyerelax

- - -

mac 平台

1. 【mac win】依旧 flux <https://justgetflux.com/>
2. 【appstore】一休 定时提醒

not

stretchly 图标每次突然弹出很突兀且选项太多了

#### 5. 下载

【全平台】motrix【首选】 <https://motrix.app/zh-CN/> | [下载页](https://motrix.app/zh-CN/download) 颜值高。支持下载 HTTP、FTP、BT、磁力链接等资源。即使 Github 资源也不在话下

或者

【win linux】文件蜈蚣 <http://www.filecxx.com/zh_CN/index.html> 免费版功能也够，提供插件可以嗅探网页中的视频

maybe

【全平台】视频下载工具 lux
<https://github.com/iawia002/lux/releases/download/v0.22.0/lux_0.22.0_Windows_x86_64.zip>

搭配 ffmpeg
<https://www.gyan.dev/ffmpeg/builds/packages/ffmpeg-6.1.1-essentials_build.7z>

maybe

【浏览器拓展】猫抓(cat catch) - 猫抓(cat catch)文档
<https://o2bmm.gitbook.io/cat-catch/>

maybe

[Free Download Manager](https://www.freedownloadmanager.org/zh/) (**FDM**) 是一款[经典](https://www.iplaysoft.com/tag/%E7%BB%8F%E5%85%B8)免费纯粹的下载软件，它[开源](https://www.iplaysoft.com/tag/%E5%BC%80%E6%BA%90)无广告，界面简洁清爽，支持 [BT](https://www.iplaysoft.com/tag/bt)、[FTP](https://www.iplaysoft.com/tag/ftp) 下载，支持批量下载、断点续传、捕获 HTTP 链接、FTP 目录浏览等功能，还跨平台支持 Windows 与 macOS，可以说是一款相当优秀的免费全能型下载工具。

not

* 【win】VidJuice UniTube 可以图形化下载视频和音频很好用，就是付费啦
* 【win mac】迅雷<https://dl.xunlei.com/> 有广告，但是很多资源都挂在迅雷上了，只有它才有加速效果。
* 【win】qbittorrent_4.5.5 不好用
* [IDM](https://www.internetdownloadmanager.com/), 功能还行但收费。
* neat download manager 虽然体积小，但是外观不如 fdm。也不支持磁力。

- - -

mac 平台

motrix

not

* downie 收费
* vdown 暂时不完善

#### 6. 看图

[菠萝看图 BLumia/pineapple-pictures: A homebrew lightweight image viewer](https://github.com/BLumia/pineapple-pictures)

or

[ImageGlass](https://github.com/d2phap/ImageGlass) 界面很现代

not

* acdsee 免费版都需要注册，差评
* Honeyview <https://www.bandisoft.com/honeyview/> 页面太丑了，已过时
* Bandiview <https://www.bandisoft.com/bandiview/> Honeyview 的升级版
* jpegview 特点是小巧，但操作不顺手 <https://github.com/sylikc/jpegview/> 下载链接 <https://github.com/sylikc/jpegview/releases/download/v1.3.46/JPEGView32_1.3.46.7z>
* XnView 界面不那么现代 <https://www.xnview.com/en/xnview/#downloads>

- - -

mac 平台

[Picture View](https://wl879.github.io/apps/picview/index.html)

#### 7. 图像处理

[【win】【轻量】ShareX](https://getsharex.com/) 也可以贴图，不过我更当是一个图片编辑器，还可以录屏
[ShareX-15.0.0-portable 下载](https://github.com/ShareX/ShareX/releases/download/v15.0.0/ShareX-15.0.0-portable.zip)

【全平台】【重量】GIMP 【PS 的替代品且免费】 <https://www.gimp.org/>

or

【免费】【网页版】美图秀秀在线版

not

* 【win】光影魔术手 不维护了
* 【win mac】eagle 感觉不好用
* PS 【收费软件】

- - -

mac 平台

依旧【全平台】【重量】GIMP

#### 8. 网盘

1. [【win mac】阿里云盘](https://www.aliyundrive.com/drive/) 主打大容量 + 同步功能，高峰时段限速但一般没感觉。 然后再搭配猫头鹰文件。看视频搭配搜狐视频也不错，可以读取阿里网盘的视频文件。
2. [【全平台】坚果云](https://www.jianguoyun.com/s/downloads) 主要用于存少量文档

- - -

linux 平台

暂时没找到好用的

- - -

mac 平台

依旧阿里云 + 坚果云的组合。

#### 9. 密码管理

【全平台】[BitWarden](https://bitwarden.com/)  一款全平台的密码管理软件。轻度使用安装浏览器插件即可，重度使用可以安装该软件。


### 2. 办公类

#### 1. 【常用】Office

一般品牌笔记本都会赠送微软 Office 套件。否则我会选择免费的 wps 加 LibreOffice 的组合。

【全平台】LibreOffice <https://zh-cn.libreoffice.org/download/libreoffice/> [libreoffice 源1 - 清华源](https://mirrors.tuna.tsinghua.edu.cn/libreoffice/libreoffice/stable/) | [libreoffice 源2 - 腾讯源](<https://mirrors.cloud.tencent.com/libreoffice/libreoffice/stable/>)

or

【全平台】WPS <https://www.wps.cn/>

- - -

mac 平台

除了 office 和 iWork 系列外我还是会选择 libreoffice 加 WPS 的组合

#### 2. 【常用】PDF 文档

阅读器 [【win 绿色版】SumatraPDF](https://www.sumatrapdfreader.org/)

编辑器 [【win 安装版】PDFgear](https://www.pdfgear.com/download/)

or

* [【win】极速 PDF 阅读器](https://jisupdf.com/zh-cn/)

中规中矩

* 【win】Right PDF Reader
* 【win】迅读 PDF
* 【win】福昕 PDF 编辑器

not

* 【win】PDF XChangeViewer 貌似免费版只能查看
* 【win】金山 PDF 独立版 ctrl + n 快捷键不好使，差评
* 【win mac】UPDF ctrl + w 又是不好用，差评
* 【win】迅捷 PDF 阅读器 体验极差，快捷键几乎不支持

- - -

mac 平台

【mac】PDF 如果站在简单读取的角度直接用浏览器即可。否则可以选择付费的 pdf expert

- - -

【linux】PDF 如果站在简单读取的角度直接用浏览器即可

#### 3. mail 收发

【win mac】网易邮箱大师 <https://dashi.163.com/>

or

【win】 windows 上建议选择 foxmail <https://www.foxmail.com/> 。但我感觉该软件对 mac 用户不够重视，经常不更新。

not

[thunderbird](https://www.thunderbird.net/zh-CN/)

- - -

[【mac win】网易邮箱大师](https://dashi.163.com/)

#### 4. 办公通讯

防诈骗！！！一定不要开启屏幕共享！！！

飞书——先进企业协作与管理平台，一站式无缝办公协作，团队上下对齐目标，全面激活组织和个人。先进团队，先用飞书。
<https://www.feishu.cn/>

[钉钉](https://page.dingtalk.com/wow/z/dingtalk/simple/ddhomedownload#/)
个人版不好用，有点卡

企业微信
<https://work.weixin.qq.com/>

腾讯会议
<https://meeting.tencent.com/>

[网易会议](https://meeting.163.com/)

#### 5. 思维导图

[Xmind 思维导图](https://xmind.cn/)

### 3. 【常用】音频类

普通用户推荐在线播放推荐 【win mac】QQ 音乐 <https://y.qq.com/download/index.html>，而我更喜欢 lx-music-desktop 但是需要自行找资源

可选

本地播放可以安装一个 【win】MusicPlayer2 <https://github.com/zhongyang219/MusicPlayer2>

远端播放 【win】普听音乐。在阿里云盘的加持下很好用，用于打造自己的曲库

not

* 【win mac】汽水音乐推荐算法很优秀，不过 vip 的体验更好
* 方格音乐 由于可以下载歌曲 <http://morin.vin/> 但偶尔好用
* 【win mac】网易云音乐【在线】 网易云音乐 <https://music.163.com/#/download>
* 酷狗音乐 没落的不行了
* 千千音乐 快捷键都不支持，体验极差
* Spotube 开了魔法也不好用
* Spotify PC 版 曲库很全，但是非会员稍有限制，需要魔法

- - -

mac 平台

本地音乐播放器 可能是 [foobar2000](https://www.foobar2000.org/) 吧，但是歌词搜索呢，差很多意思
在线选 QQ 音乐

### 4. 【常用】视频类

本地 + 网络流播放 [【本地 首选 win 官方安装版】PotPlayer](https://potplayer.tv/?lang=zh_CN) 高清影音播放器 或者开源的 VLC 也很不错

在线平台  2. [【win】荐片播放器官网](https://www.jianpian6.co/) - 最新电影，播放器

本地 +  在线通吃 [【win mac】哔哩哔哩](https://app.bilibili.com/)在线【本地】【首选】，播放效果比网页好很多，特别是 win
bili 的 mac 版的本地播放能力也挺强的

or

西瓜视频 PC 版 比较软件比网站要流畅些

not

* 【win mac】爱奇艺【在线】 在线视频网站 <https://www.iqiyi.com/>
* 【win mac】优酷【在线】客户端下载 <https://youku.com/product/index>
* 【win mac】腾讯视频【在线】中国领先的在线视频媒体平台 https://v.qq.com/
* 【win mac】芒果 TV【在线】 <https://www.mgtv.com/app/>
* 【win mac linux】【本地】VLC 官方网站 颜值不够 - VideoLAN <https://www.videolan.org/>
* 【win】【本地】kmplayer 没有便携版
* 【win】【本地】恒星播放器 广告太多
* 【win】【本地】mpv 足够清爽，可是功能太单一
* 【win】【本地】暴风影音 5 不太好用

- - -

mac 平台

1. 哔哩哔哩
2. vidhub
3. 优酷 可以免费看很多剧

### 5. 【常用】社交类

[【win mac】微信](https://weixin.qq.com/)

[【全平台】QQ](https://im.qq.com/index)

[【win】Tim](https://tim.qq.com/download.html)

not

阿里旺旺的 mac 版不好用

- - -

mac 平台

依旧 QQ 和 微信

### 6. 教育类

1. [【全平台】每日英语听力 ](https://www.eudic.net/v4/en/app/ting)
2. [【全平台】欧路词典](https://www.eudic.net/v4/en/app/download)

### 7. 远程类

【全平台】RustDesk – The Open Source Remote Desktop Access Software
<https://rustdesk.com/index.html>

or

ToDesk <https://www.todesk.com/download.html>

or

[【win】DBAdmin](https://www.slser.com/)

not

向日葵远程控制

- - -

mac 平台

【全平台】RustDesk

or

todesk

or

vnc viewer 用于连接树莓派

微软远程桌面 用户连接 windows 电脑

not

【云桌面】阿里无影云桌面 mac 版有点卡

### 8. 启动器

【Win】自制的捷键

not

utools【win, mac】 总感觉美中不足，让我弃用了它

- - -

[【mac】Raycast](https://www.raycast.com/)

not

rubick 还不够完整

### 9. 阅读类

[【win】Fluent Reader 一款 rss 阅读器](https://github.com/yang991178/fluent-reader/releases/)

- - -

mac 平台

1. kindle
2. Reeder 用于 rss
3. 杂志天下

## 拓展

### 0. 驱动运行库硬件检测

理论上安装鲁大师一个就够用了，驱动可以认准主板官网或者用 dism++ 备份原有驱动，如果不能连接网络我通常会安装 [驱动总裁万能网卡绿色版](https://www.sysceo.com/Software)

硬件检测
* [CPU-Z | Softwares | CPUID](https://www.cpuid.com/softwares/cpu-z.html)
* [GUP-Z](https://www.techpowerup.com/download/techpowerup-gpu-z/)
* [鲁大师](https://www.ludashi.com/) 驱动管理+硬件检测，可解决未安装任何音频输出设备的问题

运行库
[Download Visual C++ Redistributable Runtimes All-in-One Feb 2024 | TechPowerUp](https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/)

WirelessMon 4.0 用于监控无线适配器和 WiFi 接入点的 Windows 软件

not

* Speccy 虽说是 ccleaner 出品但是没有便携版
* [驱动精灵](http://www.drivergenius.com/)
* [驱动人生](https://www.160.com/) 下载驱动限速严重

### 1. 激活类

[GitHub - zbezj/HEU_KMS_Activator](https://dl.lancdn.com/landian/soft/heu/) | [备份站](https://dl.lancdn.com/landian/soft/heu/)

[云萌 Windows 激活工具](https://cmwtat.cloudmoe.com/cn.html)

### 2. OCR 软件

【win】[Umi-OCR-OCR](https://github.com/hiroi-sora/Umi-OCR) 图片转文字识别软件

【win mac 已购】[极度扫描-文字识别-OCR](https://jidusm.wrste.com/)

### 3. 录屏软件

视频录制

【win 安装版 免费】[EV 录屏](https://www.ieway.cn/evcapture.html) 选项中规中矩，足够正常使用，可以单独录制声音，录制时鼠标有黄色光晕标识。美中不足没有绿色版。

动图录制

[ScreenToGif](https://www.screentogif.com/) 录屏可导出为 gif、apng 或 webp 动图

or

* 【win mac】[LICEcap](https://www.cockos.com/licecap/) 没 ScreenToGif 强大，但是也非常有特色
* 【win】Gif123

录制辅助工具

1. [keyviz](https://github.com/mulaRahul/keyviz) 免费开源，能够可视化键盘击键和鼠标实时动作
2. 【win】[ClickShow](https://github.com/cuiliang/ClickShow/releases) 用于提示鼠标点击、鼠标位置

not

* 【win】Bandicam 班迪录屏 10 分种内免费，不过体验很好
* 【全平台】obs 有点卡
* 【win】Captura 已过时
* 【win】KeyCastOW 颜值差点意思

- - -

mac

视频录制

Omi 录屏专家 基本够用

动图录制

【mac win】[LICEcap](https://www.cockos.com/licecap/) 用于录制 gif

录制辅助工具

键盘显示用 【mac】[KeyCastr](https://github.com/keycastr/keycastr/releases)

not

* 国产 ishot 的录屏
* ev 录屏 由于很久都没更新了，然后鼠标点击也不体现点击效果，差评
* FocuSee 需要登录账号

### 4. TTS 文字转语音软件

[【win】tts-vue: 🎤 微软语音合成工具](https://gitee.com/LGW_space/tts-vue)，使用 Electron + Vue + ElementPlus + Vite 构建，将文字转为语音 MP3。

### 5. 文件搜索

【win】[WizFile](https://antibody-software.com/wizfile/download) 颜值比 Everything 高不少

or

【绿色版 win】[Everything](https://www.voidtools.com/zh-cn/downloads/)

and

文档中搜索关键字 【win】工具 FileSearchEX_v1.1.0.6

### 6. 显示网速

【win】[TrafficMonitor](https://github.com/zhongyang219/TrafficMonitor)

- - -

mac 的腾讯柠檬清理已经自带了该功能

### 7. DNS 相关【win】

**DNS 优选**

【win】[Dns Jumper v2.3 - A Free DNS Changer](https://www.sordum.org/7952/dns-jumper-v2-3/)

or

[GRC's | DNS Nameserver Performance Benchmark](https://www.grc.com/dns/benchmark.htm)

**DNS 切换**

[【win】YogaDNS](https://yogadns.com)  但免费版只允许设置一个 dns，可能有用

**DNS server**

1\. [SmartDNS](https://pymumu.github.io/smartdns/)

2\. AdGuard Home | 适用于任何操作系统（Windows，macOS，Linux）的网络软件

[AdGuard Home 官网 ](https://adguard.com/zh_cn/adguard-home/overview.html) | [github AdguardHome](https://github.com/AdguardTeam/AdguardHome)

### 8. markdown 编辑

[marktext](https://github.com/marktext/marktext/releases 'markdown 编辑')

not

* typora 虽然功能强大，且适合初学者，收费有条件支持下
* [【win】MarkdownPad2](http://markdownpad.com/) 感觉差点意思

- - -

mac 平台据说 ulysses 评价很高，但收费就算了

### 9. 大文件分析

[【win】【推荐】】wiztree](https://www.diskanalyzer.com/)

or

[【win】【备用】SpaceSniffer](http://www.uderzo.it/main_products/space_sniffer/index.html)

### 10. 【常用】清理卸载

[【win】极客卸载 Geek Uninstaller](https://geekuninstaller.com/download) 简单清爽

or

[【win】HiBitUninstaller](https://www.hibitsoft.ir/Uninstaller.html) 卸载功能更强大

not

ccleaner 只有安装版差评

- - -

mac 的腾讯柠檬清理已带了该功能

not

* CCleaner mac 版目前免费版功能有限
* cleanmymac x 付费
* app cleaner & unstall 付费

### 11. 内网通讯

[内网通【安装版】【win】](http://www.51nwt.com/index.htm) 有广告但是没招，目前较为好用的软件

- - -

mac 平台暂时没找到好用的

### 12. 手机助手

Android 用户可选择 [腾讯应用宝 PC 版](https://sj.qq.com/) / [360 手机助手 PC 版](http://sj.360.cn/index.html)

iOS 用户可下载 iTunes 或者某国产助手

### 13. 光驱镜像

如果要刻录的话，win 11 自带一般够用，现在光驱都淘汰了。

虚拟光驱可用于加载 iso 文件到我的电脑，这里我推荐软媒魔方套件。

### 14. 磁盘工具

* [【win】傲梅分区助手](https://www.disktool.cn/download.html)
* 【win】diskgenius

### 15. U 盘引导

[Ventoy](https://www.ventoy.net/cn/index.html) linux 和 windows 二合一，且不妨碍 U 盘正常使用

【win】【备用】微 PE 工具箱 - 装机维护工具。无广主打纯净 <https://www.wepe.com.cn/>

### 16. 微软 buff

* [【win】【备用】微软 Sysinternals](https://learn.microsoft.com/zh-cn/sysinternals/)
* [Microsoft PowerToys](https://learn.microsoft.com/zh-cn/windows/powertoys/)

### 17. 效率工具

* [【跨平台】Espanso](https://espanso.org/)文字输入增强

not

* Listary 虽说效率神器但是不好用
* quicker 虽说是效率神器，但是我用不习惯

### 18. mac 特有

#### 鼠标翻转

bab 可以开启该功能
 
【备用】[【mac】scrollreverser](https://pilotmoon.com/scrollreverser/)

#### 电源管理

[【mac】AlDente - 负载限制器](https://apphousekitchen.com/)

### 19. windows 也要有

#### 空格预览文件

[【win】quicklook](https://github.com/QL-Win/QuickLook/releases)

not

Seer 收费就算了

#### WizMouse

[【win】WizMouse](https://antibody-software.com/wizmouse) 一款鼠标增强工具

特点：

1. win 8, 7, Vista 缺失的非激活的窗口下使用滚轮
2. 反转鼠标滚动方向，类似苹果的自然滚动

#### windows 系统优化

【win】[dism++](https://github.com/Chuyu-Team/Dism-Multi-language) 优化功能挺强，能注入驱动还能辅助装系统。适合高级用户。

## 专业

### 00. 虚拟机

* 【mac】Fusion【首选】<https://www.vmware.com/products/fusion.html>
* 【win】VMware Workstation Player【首选】 <https://www.vmware.com/products/workstation-player.html>
* 【全平台】VirtualBox【备选】<https://www.virtualbox.org/wiki/Downloads>

not

* [【mac 付费】Parallels](https://www.parallels.cn/) 买断只能买一个大版本

### 01. 网盘搭建

[AList](https://alist.nn.ci/zh/)

### 02. 网络代理

* 【server】shadowsocks-shadowsocks-rust- A Rust port of shadowsocks <https://github.com/* shadowsocks/shadowsocks-rust>
* 【win】shadowsocks-shadowsocks-windows- A C# port of shadowsocks <https://github.com/* shadowsocks/shadowsocks-windows>
* 【mac】shadowsocks-ShadowsocksX-NG- Next Generation of ShadowsocksX <https://github.com/* shadowsocks/ShadowsocksX-NG>
* 【android】shadowsocks-shadowsocks-android- A shadowsocks client for Android <https://github.com/shadowsocks/shadowsocks-android>

not

ClearVPN 免费版基本废了

### 03. 内网转发

[frp](https://github.com/fatedier/frp/releases)

### 04. 投屏显示

提醒：不听不信，谨防陌生人诈骗！！！

工具 同步显示 [scrcpy](https://github.com/Genymobile/scrcpy/releases)

【备用】乐播投屏

### 05. 文档转换

[pandoc 文档转换利器](https://github.com/jgm/pandoc/releases)

### 06. 包管理器

[【mac】Homebrew](https://brew.sh/index_zh-cn)

[【linux】AppImage](https://appimage.org)

* 【win】Scoop <https://scoop.sh/#/>
* 【win】微软 winget
* choco
* sdkman
* scoop

## 游戏

[战网 | Battle.net](https://download.battle.net/zh-tw/desktop)

[雷神网游加速器](https://www.leigod.com) 按分钟计费可暂停 4600 小时才 139 元，虽然事后又搞活动是 139 元 5200 小时
<https://www.leigod.com/>

not

* 奇游加速器 太贵
* uu 太贵
* [迅游网游加速器](https://www.xunyou.com/index.shtml) 太贵了

## 留观中

一些用过的软件但主观关键明显不好用的记录，说不定下版会优化，所以仅供参考

* 暴雪战网【mac】 在苹果上玩炉石风扇狂转，临时卸载，继续用 windows 玩
* 北京云法庭当事人端 涉案需要，哎，一次性卸了得了
* 抖音【mac appstore】该版本我用不习惯且电扇呼呼的，可能西瓜视频更好但是 mac 平台上目前没有
* 方格音乐 2023.9.28 1.0 版本暂时不成熟
* 火绒应用商店 体验一般。对于高级玩家，感觉官网下载比较好
* 芒果壁纸 时间长了会白屏
* 汽水音乐 2023.9.28 PC 版暂不完善
* 图吧工具箱 中规中矩，功能挺强大
* 网易云音乐 windows 版的非会员不能跳过付费歌曲，卸载之
* 迅雷影音 貌似会挂载后台默默上传资源，不太好，卸载了吧，即使字幕功能貌似还算好用
* 央视影音【mac】 看直播还能一用，但是感觉有点卡
* 猿如意 不让人满意
* [Advanced IP Scanner](https://www.advanced-ip-scanner.com/cn/) – 免费下载网络扫描程序 我不太喜欢安装版的
* cursor 一款智能提示编写代码片段，现阶段暂时不好用
* DisplayFusion【win】 可以管理拓展屏幕，留存吧。<https://www.displayfusion.com/>
* es 文件浏览器【mac】貌似只有压缩和解压功能，功能严重不足，留观
* Fantastical【mac】Fantastical 拥有和系统自带日历应用类似界面布局，但界面信息更加直观自然。软件支持苹果各个平台，除了可以与 iCloud / Google / Yahoo 日历无缝整合同步外，它还解决了系统自带日历 APP 功能的诸多不足。
* finalshell 只有安装版，不好用
* JupyterLab 感觉不好用
* [Lively Wallpaper - Microsoft Store 应用程序](https://apps.microsoft.com/store/detail/lively-wallpaper/) 占用 CPU 资源太大
* monica 很好用的 ai 回答助手，不过每天才 30 次免费查询
* paint.net.4.3.11.install.anycpu.web 一般般，貌似不跨平台
* picpick 一般般
* Raspberry Pi Imager 用于制作 U 盘系统镜像。
* starUML 一个画 uml 的工具，还行，可能不够通用吧
* Thunderbird 很强大，识别日历文件，还支持 rss，可能我用不习惯
* updf 中规中矩，如果编辑要钱，虽说是跨平台，卸之
* uu 加速器 免费学术资源没有 github 加速，差评
* verycapture【win】 一款截图软件，感觉界面和操作不太适合我
* webviewdebug
* [flowlauncher](https://www.flowlauncher.com/docs/) 作为一款启动器 有点儿卡

## 已出局

* 网易炉石官方插件 随之国服没了已经落幕
* 录猎 不好用
* 芒果加速 啥玩意，也是此类，只能体验 2 小时
* 万彩录屏大师 太复杂了
* 万兴喵影 2023 需要登录才能录屏，差评，不过这个公司的产品还行
* 星星加速 可以访问谷歌，但是一来界面不好看，限时体验 3 天已经是很良心了
* adguard 免费体验 2 天太少了
* AuTool-0.1.15-win-x64 暂时不好用
* CleanMy PC 软件都不更新
* Cursor Setup 0.1.3-x64 净化的不太完善吧，淘汰
* Dawn Launcher 不好用
* EncryptoforWin 厂商专注 mac 已经不更新了
* listen1【mac】 2023 年初好多歌曲都不能播放了，无奈放弃
* LocalSend-1.8.0-windows 搜不到设备，不好用
* MQTT.FX 很久没更新了，淘汰
* OfficeBox 官方绿色版v_3.1.2 颜值太低且功能不强大，差评
* OneAuth 【Win 商店版】需要先登录的二步验证，差评
* Parallels desktop 属于买断制，新版本不能用，啥玩意，再也不买了
* Parallels Toolbox 收费就算了，功能还行
* PDF Shaper Professional v13.3 只有些页面功能而已
* QOwnNotes【win mac linux】 不好用，淘汰
* StrokesPlus.net_Portable_0.5.7.4【win】 不好用，太复杂了
* Transmission【win mac linux】 只能下载 bt 种子，淘汰
* Typora 没有想象中强大，的导出 pdf 带目录功能，且还有有同类免费软件可以替代，但是不更新了，不如 vscode + 插件
* UGit 腾讯 git 代码客户端，就是感觉不好用
* Wox-1.4.1196 已经不太维护的启动器，界面也一般
* zyplayer--【win, mac】2023 据说不再更新，但是将逐渐不好用了
