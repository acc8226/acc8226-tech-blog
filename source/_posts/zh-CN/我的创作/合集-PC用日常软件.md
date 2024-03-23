---
title: 合集-PC用日常软件
date: 2023-03-22 21:02:00
updated: 2024-01-30 22:50:00
categories: 我的创作
---

注：以下对各软件的评论, 谨代表个人观点。

安全永远是第一要务。下载软件也尽量从官网下载，这样更安全，也避免从其他渠道下载到恶意软件。

说明：尽量选择跨平台在搭配特定系统特有软件即可满足大部分使用场景。

## 日常

### 必备

#### 电脑管家

普通 windows 用户可二选一：[【win】腾讯电脑管家【安装版】](https://guanjia.qq.com/) 或 [【win】360 安全卫士【安装版】](https://weishi.360.cn/)

进阶玩家推荐[【win】火绒安全【安装版】](https://www.huorong.cn/) + [【win】微软电脑管家【安装版】](https://pcmanager.microsoft.com/zh-cn) 的套装

maybe

搭配【win】`dism++` 据说这货优化功能挺强，不过仅适合高级用户。

- - -

【mac】腾讯柠檬清理<https://lemon.qq.com/>

主打清理电脑垃圾文件，一键释放磁盘空间。因 App Store 审核限制，完整版内部分功能无法上架（例如应用卸载等）。建议去官网下载完整版。

- - -

【linux】 是否需要

#### 浏览器类-360 极速

【win】【安装版】360 极速浏览器 安全防护永远要放在第一位，鼠标悬停切换标签功能值得点赞。

【mac】360 极速浏览器

【linux】360 安全浏览器

#### 压缩解压-Bandzip

【win】【安装版】bandzip 智能解压特别好用

【mac】The Unarchiver【App Store版】

linux 系统一般用 tar 或 zip 命令。

#### 输入法-微信输入法

如果你 Win11 自带的输入法也不错，当你用起来很顺心可不用安装额外输入法

【win mac】**微信输入法**，特有云粘贴板功能，现已支持跨设备粘贴文字和图片
<https://z.weixin.qq.com/>

maybe

[搜狗输入法智慧版](https://pinyin.sogou.com/zhihui/), 无广告不解释。处理日常使用外还能表情斗图。

- - -

mac 平台

【mac win】微信输入法 特有云粘贴板功能。

not

* [mac 版搜狗输入法](https://pinyin.sogou.com/mac/) 和微信输入法比起来没啥优势
* mac 版百度输入法，曾经卡过一次，体验不太好，颜值不过可以

- - -

linux 平台

搜狗
<https://shurufa.sogou.com/linux>

百度和讯飞都有支持，据说还有个 ibus。

#### Office 或者 WPS

文字处理等办公必不可少。

### 网盘类

1. 【win mac】阿里云盘 <https://www.aliyundrive.com/drive/> 主打大容量 + 同步功能，高峰时段限速但一般没感觉。
2. 【全平台】坚果云 <https://www.jianguoyun.com/s/downloads> 主要用于文档

- - -

linux 平台

暂时没找到好用的

- - -

mac 平台

依旧阿里云 + 坚果云的组合。

### 密码管理

【全平台】[BitWarden](https://bitwarden.com/)  一款全平台的密码管理软件。

bitwarden-clients <https://github.com/bitwarden/clients>

<https://github.com/bitwarden/clients/releases/download/desktop-v2023.10.1/Bitwarden-Portable-2023.10.1.exe>

### 工具类

#### 鼠标手势

win 平台

【收费】WGestures 2 鼠标手势 | YingDev
<https://www.yingdev.com/projects/wgestures2>

如果不想买 wg 2 可以使用【win】【免费】WGestures 1。这绝对是效率神器。quciker 也是此类效率软件可自行研究。

- - -

mac 平台

betterAndBetter 免费且比目前付费的 wg 2 功能更加强大，还自带 mac 上需要的翻转鼠标功能，于是我卸载了 Scroll Reverser。

- - -

linux 平台据说 easystroke 还能用。

```sh
apt install easystroke
```

#### 键盘增强

MyKeymap-2.0
<https://xianyukang.com/MyKeymap.html> | GitHub 地址 <https://github.com/xianyukang/MyKeymap>

- - -

mac 平台

hammerspoon

#### 截图

【win】PixPin <https://pixpinapp.com/> mac 版即将推出
<https://download.pixpinapp.com/PixPin_1.3.1.0.exe>

not

【win mac】Snipaste <https://zh.snipaste.com/> 免费版不支持长截图

【win】【新版收费】 FSCapture

【win】picpick_portable 说不上哪不好

- - -

mac 平台

我目前一直 Snipaste。其实我一直在等待 PixPin mac 版发布。

not

单独的 ishot 免费版有水印，且免费版不能贴图

单独的 Snipaste 免费版功能有限

#### 下载

【全平台】motrix【首选】 <https://motrix.app/zh-CN/> | [下载页](https://motrix.app/zh-CN/download) 颜值高。支持下载 HTTP、FTP、BT、磁力链接等资源。即使 Github 资源也不在话下。

and

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

downie 收费

#### 护眼

【win mac】【安装版】flux <https://justgetflux.com/>

EyesGuard 定时提醒眼睛休息 ~~由于作者说微软商店不再提供更新~~，所以还是去 github 下载最新版本
<https://github.com/avestura/EyesGuard/releases/>

- - -

mac 平台

【mac win】依旧 flux <https://justgetflux.com/>

#### 看图

菠萝看图 BLumia/pineapple-pictures: A homebrew lightweight image viewer.
<https://github.com/BLumia/pineapple-pictures>

or

ImageGlass 界面很现代
<https://github.com/d2phap/ImageGlass>

not

* acdsee 免费版都需要注册，差评
* Honeyview <https://www.bandisoft.com/honeyview/> 页面太丑了，已过时
* Bandiview <https://www.bandisoft.com/bandiview/> Honeyview 的升级版
* jpegview 特点是小巧，但操作不顺手 <https://github.com/sylikc/jpegview/> 下载链接 <https://github.com/sylikc/jpegview/releases/download/v1.3.46/JPEGView32_1.3.46.7z>
* XnView 界面不那么现代 <https://www.xnview.com/en/xnview/#downloads>

- - -

mac 平台

picview <https://wl879.github.io/apps/picview/index.html>

#### 图像处理

【win】【轻量】ShareX <https://getsharex.com/> 也可以贴图，不过我更当是一个图片编辑器
[ShareX-15.0.0-portable 下载](https://github.com/ShareX/ShareX/releases/download/v15.0.0/ShareX-15.0.0-portable.zip)

【全平台】【重量】GIMP 【PS 的替代品且免费】 <https://www.gimp.org/>

or

【免费】【网页版】美图秀秀在线版

not

【win】Honeyview 只能查看，没有一丁点的编辑功能

【win】光影魔术手 不在维护了

【win mac】eagle 感觉不好用

PS 【收费软件】

- - -

mac 平台

依旧【全平台】【重量】GIMP

### 办公类

#### 移动办公

防诈骗！！！一定不要开启屏幕共享

飞书——先进企业协作与管理平台，一站式无缝办公协作，团队上下对齐目标，全面激活组织和个人。先进团队，先用飞书。
<https://www.feishu.cn/>

钉钉
<https://page.dingtalk.com/wow/z/dingtalk/simple/ddhomedownload#/>
个人版不好用，有点卡

企业微信
<https://work.weixin.qq.com/>

腾讯会议
<https://meeting.tencent.com/>

网易会议
<https://meeting.163.com/>

#### mail 收发

【win mac】网易邮箱大师 <https://dashi.163.com/>

or

【win】 windows 上建议选择 foxmail <https://www.foxmail.com/> 。但我感觉该软件对 mac 用户不够重视，经常不更新。

not

thunderbird <https://www.thunderbird.net/zh-CN/>

- - -

【mac win】网易邮箱大师 <https://dashi.163.com/>

#### Office 文档

【全平台】libreoffice <https://zh-cn.libreoffice.org/download/libreoffice/>

libreoffice 源1 - 清华
<https://mirrors.tuna.tsinghua.edu.cn/libreoffice/libreoffice/stable/>

libreoffice 源2 - 腾讯
<https://mirrors.cloud.tencent.com/libreoffice/libreoffice/stable/>

or

【全平台】WPS <https://www.wps.cn/>

- - -

mac 平台

在除了 iWork 系列 外还是选择 libreoffice

#### PDF 文档

【win】SumatraPDF【绿色版】

or

* 【win】极速 PDF 阅读器

中规中矩

* 【win】Right PDF Reader
* 【win】迅读 PDF
* 【win】福昕 PDF 编辑器

not

* 【win】PDF_XChangeViewer 貌似免费版只能查看
* 【win】金山PDF独立版 ctrl + n 快捷键不好使，差评
* 【win mac】UPDF ctrl + w 又是不好用，差评
* 【win】迅捷PDF阅读器 体验极差，快捷键几乎不支持

- - -

mac 平台

【mac】PDF 如果站在简单读取的角度直接用浏览器即可。否则可以选择 pdf expert

- - -

【linux】PDF 如果站在简单读取的角度直接用浏览器即可

#### 思维导图

Xmind 思维导图 <https://xmind.cn/>

### 音频类

【win mac】普通用户推荐【在线】QQ 音乐 <https://y.qq.com/download/index.html>

【魔法】高级用户推荐Spotify PC 版 曲库很全，但是非会员稍有限制，需要魔法才好

【win mac】汽水音乐也能优秀，不过 vip 的体验更好

or

【备用】方格音乐 由于可以下载歌曲
<http://morin.vin/>

【win】MusicPlayer2【本地】MusicPlayer2 <https://github.com/zhongyang219/MusicPlayer2>

【win】普听音乐。在阿里云盘的加持下很好用，前提是有自己的曲库

建议修改下快捷键。设置上一首和下一首的快捷键分别为 ctrl + left / right

not

* 【win mac】网易云音乐【在线】 网易云音乐 <https://music.163.com/#/download>
* 酷狗音乐 没落的不行了
* 千千音乐 快捷键都不支持，体验极差
* Spotube 开了魔法也不好用

- - -

mac 平台的本地音乐播放器 可能是 foobar2000 吧
<https://www.foobar2000.org/>

但是歌词搜索呢

### 视频类

【win mac】哔哩哔哩【在线】【本地】【首选】 哔哩哔哩下载中心 <https://app.bilibili.com/>
bili 的 mac 版的本地播放能力也挺强的

【win】荐片播放器官网 - 最新电影,播放器 <https://www.jianpian6.co/>

【win】PotPlayer【本地】【首选】 PotPlayer 高清影音播放器中文绿色版下载-PotPlayer中文网 <https://potplayer.org/>

not

* 【win mac】爱奇艺【在线】 爱奇艺-在线视频网站-海量正版高清视频在线观看 <https://www.iqiyi.com/>
* 【win mac】优酷【在线】优酷客户端下载中心 <https://youku.com/product/index>
* 【win mac】腾讯视频【在线】腾讯视频-中国领先的在线视频媒体平台,海量高清视频在线观看 https://v.qq.com/
* 【win mac】芒果 TV【在线】 芒果TV <https://www.mgtv.com/app/>
* 【win mac linux】【本地】VLC：官方网站 颜值不够 - VideoLAN <https://www.videolan.org/>
* 【win】【本地】kmplayer 没有便携版
* 【win】【本地】恒星播放器 广告太多
* 【win】【本地】mpv 足够清爽，可是功能太单一
* 【win】【本地】暴风影音5 不太好用

- - -

mac 平台使用 哔哩哔哩

### 社交类

【win mac】微信 <https://weixin.qq.com/>

【全平台】QQ <https://im.qq.com/index/>

【win】Tim <https://tim.qq.com/download.html>

not

阿里旺旺的 mac 版不好用

- - -

mac 平台

依旧 QQ 和 微信

### 教育类

【全平台】欧路词典 <https://www.eudic.net/v4/en/app/download>

【全平台】每日英语听力 <https://www.eudic.net/v4/en/app/ting>

### 远程类

【全平台】RustDesk – The Open Source Remote Desktop Access Software
<https://rustdesk.com/index.html>

or

ToDesk <https://www.todesk.com/download.html>

or

【win】DBAdmin <https://www.slser.com/>

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

### 启动器

【Win】自制的捷键

not

utools 差点意思

- - -

【mac】Raycast
<https://www.raycast.com/>

not

rubick 还不够完整

### 阅读类

【win】Fluent Reader 一款 rss 阅读器
<https://github.com/yang991178/fluent-reader/releases/>

- - -

mac 平台

Reeder 用于 rss

kindle 似乎已经都没了

## 拓展

### 驱动管理

驱动管理：[驱动精灵](http://www.drivergenius.com/) / [驱动人生](https://www.160.com/) 二选一。从此不用担心驱动光盘📀丢失。

### 激活类

HEU KMS Activator <https://dl.lancdn.com/landian/soft/heu/>

### 工具 OCR 软件

【win】Umi-OCR-OCR 图片转文字识别软件 <https://github.com/hiroi-sora/Umi-OCR>

【win mac】[已购] 工具 极度扫描-文字识别-OCR <https://jidusm.wrste.com/>

### 工具 录屏软件

EV 录屏 还可以单独录音 <https://www.ieway.cn/evcapture.html>

ScreenToGif 用于录制动图，可选格式 git ，apng 和 webp

键盘显示用【win】mulaRahul/keyviz: Keyviz is a free and open-source tool to visualize your keystrokes ⌨️ and 🖱️ mouse actions in real-time.
<https://github.com/mulaRahul/keyviz>

not

LICEcap 1.26 不够强大

Bandicam 班迪录屏 10 分种内才免费，不过体验极好

obs 有点卡

【win】KeyCastOW 颜值差点意思

- - -

mac 很多人都推荐免费的 Omi 录屏专家 或者用国产 ishot 的录屏功能就行

键盘显示用【mac】KeyCastr <https://github.com/keycastr/keycastr/releases>

not

ev 录屏 由于很久都没更新了，然后鼠标点击也不体现点击效果，差评

### 文字转语音软件

【win】tts-vue: 🎤 微软语音合成工具，使用 Electron + Vue + ElementPlus + Vite 构建，将文字转为语音 MP3。
<https://gitee.com/LGW_space/tts-vue>

### 文件搜索

工具 文件  Everything【绿色版】【win】<https://www.voidtools.com/zh-cn/downloads/>

文档中搜索关键字 【win】工具 FileSearchEX_v1.1.0.6

### 显示网速 TrafficMonitor【win】

<https://github.com/zhongyang219/TrafficMonitor>

- - -

mac 的腾讯柠檬清理已经自带了该功能

### DNS 相关【win】

**DNS 优选**

Dns Jumper v2.3 - A Free DNS Changer
<https://www.sordum.org/7952/dns-jumper-v2-3/>

or

GRC's | DNS Nameserver Performance Benchmark
https://www.grc.com/dns/benchmark.htm

**DNS 切换**

YogaDNS 【win】 <https://yogadns.com/> 但免费版只允许设置一个 dns，可能有用

**DNS server**

1\. SmartDNS
<https://pymumu.github.io/smartdns/>

2\. AdGuard Home| 适用于任何操作系统（Windows，macOS，Linux）的网络软件
<https://adguard.com/zh_cn/adguard-home/overview.html>
github AdguardHome
<https://github.com/AdguardTeam/AdguardHome>

### markdown 编辑

marktext <https://github.com/marktext/marktext/releases>

not

typora 收费就算了，但是很适合初学者

MarkdownPad2 <http://markdownpad.com/> 感觉差点意思

- - -

mac 平台据说 ulysses 评价很高，但是收费就算了

### 大文件分析 wiztree【win】

[wiztree【win】](https://www.diskanalyzer.com/)

or

[SpaceSniffer](http://www.uderzo.it/main_products/space_sniffer/index.html)

### 清理卸载

【win】极客卸载 Geek Uninstaller 简单清爽
<https://geekuninstaller.com/download>

or

【win】[HiBitSoftware](https://www.hibitsoft.ir/) 功能强大

not

ccleaner 只有安装版差评

- - -

mac 的腾讯柠檬清理已带了该功能

or

CCleaner mac 版目前免费呢

not

cleanmymac x 付费

### 内网通讯

内网通【安装版】【win】有广告但是没招，目前较为好用的软件
<http://www.51nwt.com/index.htm>

- - -

mac 平台暂时没找到好用的

### 手机助手

Android 用户可选择 [腾讯应用宝 PC 版](https://sj.qq.com/) / [360 手机助手PC版](http://sj.360.cn/index.html)

iOS 用户可下载 iTunes 或者某些国产助手

### 光驱刻录

win 11 自带一般够用，现在光驱都淘汰了。

虚拟光驱可用于加载 iso 文件到我的电脑，这里推荐 软媒魔方套件。

### 磁盘工具

工具 系统 傲梅分区助手【win】 <https://www.disktool.cn/download.html>

diskgenius

### U 盘引导

微 PE 工具箱 - 超好用的装机维护工具。主打纯净
<https://www.wepe.com.cn/>

or

[Ventoy](https://www.ventoy.net/cn/index.html)

### 系统辅助

微软 Sysinternals【win】 <https://learn.microsoft.com/zh-cn/sysinternals/>

AutoHotkey 【win】<https://www.autohotkey.com/> + upx-4.0.2 用于辅助 ahk 进行加密

## 专业

### 虚拟机

* 【mac】Fusion【首选】<https://www.vmware.com/products/fusion.html>
* 【mac】Parallels【付费】 <https://www.parallels.cn/>
* 【win】VMware Workstation Player【首选】 <https://www.vmware.com/products/workstation-player.html>
* 【全平台】VirtualBox【备选】<https://www.virtualbox.org/wiki/Downloads>

### 网盘搭建

AList 文档 <https://alist.nn.ci/zh/>

### 网络代理

【server】shadowsocks-shadowsocks-rust- A Rust port of shadowsocks <https://github.com/shadowsocks/shadowsocks-rust>

【win】shadowsocks-shadowsocks-windows- A C# port of shadowsocks <https://github.com/shadowsocks/shadowsocks-windows>

【mac】shadowsocks-ShadowsocksX-NG- Next Generation of ShadowsocksX <https://github.com/shadowsocks/ShadowsocksX-NG>

【android】shadowsocks-shadowsocks-android- A shadowsocks client for Android <https://github.com/shadowsocks/shadowsocks-android>

not

ClearVPN 免费版的套餐基本废了

### 内网转发

frp <https://github.com/fatedier/frp/releases>

### 投屏显示

注：不听不信，谨防被陌生人诈骗！！！

工具 同步显示 scrcpy <https://github.com/Genymobile/scrcpy/releases>

【备用】乐播投屏

### 文档转换

[pandoc 文档转换利器](https://github.com/jgm/pandoc/releases)

### 包管理器

* scoop
* choco
* ms winget
* sdkman

- - -

mac 平台

brew

## 系统镜像

### nas 或软路由

proxmox-ve_8.0-2

### 操作系统

乌班图 ubuntu-23.10.1-desktop-amd64.iso
<https://releases.ubuntu.com/23.10.1/ubuntu-23.10.1-desktop-amd64.iso>

树莓派 Raspberry Pi
<https://www.raspberrypi.com/software/operating-systems/>

深度操作系统 deepin-desktop-community-20.9-amd64.iso
<https://mirrors.tuna.tsinghua.edu.cn/deepin-cd/20.9/deepin-desktop-community-20.9-amd64.iso>

## 游戏

战网 | Battle.net
<https://download.battle.net/zh-tw/desktop>

雷神网游加速器-专线加速游戏，按分钟计费可暂停 4600 小时才 139 元，虽然事后又搞活动是 139 元 5200 小时
<https://www.leigod.com/>

not

奇游加速器

uu 太贵

迅游网游加速器 太贵了
<https://www.xunyou.com/index.shtml>

## 留观中

一些用过的软件但主观关键明显不好用的记录，说不定下版会优化，所以仅供参考

* 暴雪战网【mac】 mac 上玩炉石会风扇狂转，临时卸载，继续用 windows 玩
* 北京云法庭当事人端 涉案需要，哎，一次性卸了得了
* 抖音【mac appstore】该版本我用不习惯且电扇呼呼的，可能西瓜视频更好但是 mac 平台上目前没有
* 方格音乐 2023.9.28 1.0 版本暂时不成熟
* 芒果壁纸 时间长了会白屏
* 汽水音乐 2023.9.28 PC 版暂不完善
* 网易云音乐 windows 版的非会员不能跳过付费歌曲，卸载之
* 迅雷影音 貌似会挂载后台默默上传资源，不太好，卸载了吧，即使字幕功能貌似还算好用
* 央视影音【mac】 看直播还能一用，但是感觉有点卡
* 猿如意 不让人满意
* [Advanced IP Scanner](https://www.advanced-ip-scanner.com/cn/) – 免费下载网络扫描程序 我不太喜欢安装版的
* cursor 一款智能提示编写代码片段，现阶段暂时不好用
* chrome【win, mac】没有鼠标手势
* DisplayFusion【win】 可以管理拓展屏幕，留存吧。<https://www.displayfusion.com/>
* dism++ 一款优化软件，没有想象的好用，适合高级用户
* es 文件浏览器【mac】貌似只有压缩和解压功能，功能严重不足，留观
* Espanso 不如 ahk 拓展性高
* Fantastical【mac】 Fantastical 拥有和系统自带日历应用类似界面布局，但界面信息更加直观自然。软件支持苹果各个平台，除了可以与 iCloud / Google / Yahoo 日历无缝整合同步外，它还解决了系统自带日历 APP 功能的诸多不足。
* finalshell 只有安装版，不好用
* HiBitUninstaller-Portable【win】从界面上就觉得不太好用
* JupyterLab 感觉不好用
* Lively Wallpaper - Microsoft Store 应用程序 <<https://apps.microsoft.com/store/detail/lively-wallpaper/> 占用 CPU 资源太大
* [Microsoft PowerToys | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/powertoys/)
* monica 很好用的 ai 回答助手，不过每天才 30 次免费查询
* paint.net.4.3.11.install.anycpu.web 一般般，貌似不跨平台
* picpick 一般般
* quicker 虽说是效率神器，但是我用不习惯
* Raspberry Pi Imager 用于制作 U 盘系统镜像。
* starUML 一个画 uml 的工具，还行，可能不够通用吧
* Thunderbird 很强大，识别日历文件，还支持 rss，可能我用不习惯
* updf 中规中矩，如果编辑要钱，虽说是跨平台，卸之
* utools【win, mac】 可能是由于 windows 的一个 bug，总之暂时美中不足，让我弃用了它。
* uu加速器 免费学术资源没有 github 加速，差评
* verycapture【win】 一款截图软件，我感觉界面和操作不太适合我
* webviewdebug

## 已出局

* 火绒应用商店 体验一般。但对于高级玩家，还是官网下载比较好
* 炉石官方插件 随之国服没了已经落幕
* 录猎 不好用
* 芒果加速 啥玩意，也是此类，只能体验 2 小时
* 万彩录屏大师 太复杂了
* 万兴喵影 2023 需要登录才能录屏，差评，不过这个公司的产品还行
* 星星加速 可以谷歌，但是一来界面不好看，而来可以限时体验 3 天已经是很良心了。
* adguard 免费体验 2 天太少了
* AuTool-0.1.15-win-x64 暂时不好用
* CleanMy PC 软件都不更新
* Cursor Setup 0.1.3-x64 净化的不太完善吧，淘汰
* Dawn Launcher 不好用
* EncryptoforWin 厂商专注 mac 已经不更新了
* listen1【mac】 2023年初好多歌曲都不能播放了，无奈放弃
* LocalSend-1.8.0-windows 搜不到设备，不好用
* lx-music-desktop 不能按照歌手进行搜索，没资源了
* Listary 虽说效率神器但是不好用
* MQTT.FX 很久没更新了，淘汰
* OfficeBox官方绿色版v_3.1.2 颜值太低且功能不强大，差评
* OneAuth Win 商店版 需要先登录的二步验证，差评
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
