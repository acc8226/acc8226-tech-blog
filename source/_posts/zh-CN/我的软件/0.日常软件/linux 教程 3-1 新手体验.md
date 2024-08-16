---
title: linux 教程 3-1 新手体验
date: 2024-06-29 20:43:00
updated: 2024-06-29 20:43:00
categories:
  - 收藏
  - 日常软件
---

## 开始

连接网络
如果是连接 wifi，点击右上角的去设置

选择源
去 软件与更新 应用
将 下载自 更改为 位于中国的服务器

更新系统
sudo apt update
sudo apt upgrade -y

个性化设置
建议开启夜灯

<!-- more -->

## 熟悉系统软硬件以及浏览器和输入法

一般 linux 系统都会有帮助文档，例如 gonme 的文档，kde 的文档等

### 浏览器

uos 自带了 360 研发的基于 Chromium 开源项目的浏览器，支持鼠标手势 和 悬停，目前最为推荐。否则建议选择 firefox 或者 [edge](https://www.microsoft.com/zh-cn/edge)。

插件上可以搭配 Vimium C - 全键盘操作浏览器

目前 firefox 可能是一个比 edge 更好的选择，因为可以通过插件实现鼠标悬停：Tree Style Tab - 树状标签页管理 + TST Hoverswitch
或者选择 还是不错的

### 输入法

系统自带的浏览器如果设置得当还是能用的。例如 ubuntu 和 Fedora 自带了 [IBus 智能拼音](https://github.com/libpinyin/ibus-libpinyin) 1.15.7

v 英文模式
u 用户词库名模式

<!-- more -->

如果是国产 uos 自带搜狗浏览器体验也很棒

除此以外，[rime](https://github.com/rime/home/wiki/RimeWithIBusx) 输入法较为推荐。

```sh
# rime 输入法安装
sudo apt-get install ibus-rime
```

rime 默认可通过 ctrl + ` 选择打字方案的

## 如何安装软件

### ubuntu 自带了 snap 商店

例如可以按需安装

spotify
[NewsFlash](https://gitlab.com/news-flash/news_flash_gtk)
bitwarden
powershell
vscode
idea
pycharm
vlc 装系统使用最小化配置竟然安装失败了，但是第二次重装系统选择全量却可以，另外使用 nala 也可以安装成功

### fedora 自带了 gonme 家的 flathub 商店

sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://mirror.sjtu.edu.cn/flathub

[flathub](https://flathub.org/) 商店
或者更换源
sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub

flatpak remote-add --if-not-exists flathub-origin https://dl.flathub.org/repo/flathub.flatpakrepo

### appimage 分发格式

```sh
chmod +x ./zhangsan.AppImage
./zhangsan.AppImage
```

### uos 可以安装玲珑格式

目前软件还是不丰富

## 安装软件

截图 自带的挺好

下载 一般推荐 motrix，超过 xdm

坚果云 直接安装会失败，但最终参考了这篇[博客](https://blog.csdn.net/qq_41100419/article/details/131826132) 是成功了的

```sh
ar x nautilus_nutstore_amd64.deb
tar xJf control.tar.xz
# 修改 control 中的依赖（用文本编辑器就可以），将其中的 libnautilus-extension1a (>= 3.14.1) 依赖删除（因为这个依赖 Ubuntu 23.04 已经没有了）
tar --ignore-failed-read -cvJf control.tar.xz postinst postrm md5sums control
#   将修改后的文件重新打包为 deb
ar rcs newpackage.deb debian-binary control.tar.xz data.tar.xz
# 完成这些步骤后，安装新生成的 newpackage.deb 即可。
sudo dpkg -i  newpackage.deb
```

bitwarden 依旧好用

[wps](https://www.wps.cn/product/wpslinux#) 缺少字体，然后打开一百多少 M 的 pdf 还会卡，由于是用 dpk 安装的，很不好用。所以可以直接卸载 `sudo dpkg  -P  wps-office`

pdf 用自带的阅读器就很好 或者 浏览器内置功能也不差

[qq](https://im.qq.com) 体验很好

邮件收发由于网易邮箱大师安装失败了，所以还是雷鸟吧

音乐用 spotify，如果系统 libc 版本太低可以选择 lx music

视频 mpv 太过于简陋，本来想着用 vlc 但是打不开，多次尝试后就可以了，否则 ubuntu 可以借助 apt 或者 nala 工具安装 vlc

espanso 如果在 ubuntu 上由于 snap 沙箱机制，会导致及时安装成功但是启动服务会失败，无奈可有尝试手动安装 和 编译安装

ToDesk 安装失败 因此卸载之，否则可以选择 [rustdesk](https://github.com/rustdesk/rustdesk/)

```sh
sudo rm /opt/todesk/config/config.ini
sudo apt-get remove --purge todesk
```

Albert 安装失败了，[ulauncher](https://ulauncher.io/) 是可以，但是不好用，linux 平台的启动器令人堪忧

## 快捷键 的使用

### 雷柏键盘 专用

fn + f1 打开浏览器 uos
fn + f2 打开邮箱 uos
fn + f3 打开计算器 uos、ubuntu、opensuse
fn + f4 打开预览 同 win ubuntu 打开搜索 opensuse
fn + f5 打开显示器设置 uos、ubuntu 打开系统设置 opensuse
fn + f6 上一曲 uos、ubuntu、opensuse
fn + f7 下一曲 uos、ubuntu、opensuse
fn + f8 暂停 播放 uos、ubuntu、opensuse
fn + f9 停止 uos、ubuntu、opensuse
fn + f10 静音 uos、ubuntu、opensuse
fn + f11 降低音量 uos、ubuntu、opensuse
fn + f12 升高音量 uos、ubuntu、opensuse

### 系统快捷键

#### uos 系统

通用
ctrl  + alt + t 启动终端
alt + 空格 弹出窗口菜单，就像在标题栏上右键单击一样

alt + ` 切换同类型窗口

启动器 shift + 空格

关闭窗口 ctrl + q
窗口最小化改为 Super + h
系统监视器改为 ctrl + shift + esc

Super + m 打开通知
Super + 空格 快捷搜索

#### ubuntu 系统

启动器
Super + F1 打开系统帮助
ctrl  + alt + t 启动终端

导航
Super + Home 切换到工作区1
Super + pageUp / ctrl + alt + 左 切换到上一个桌面
Super + pageDown / ctrl + alt + 右 切换到下一个桌面
Super + End 切换到最后一个工作区
alt + tab 切换窗口 再通过 shift 修饰表示切换上一个
Super + tab 切换程序 再通过 shift 修饰表示切换上一个
Super + tab 切换程序 再通过 shift 修饰表示切换上一个

截图
printScreen 截图
alt + printScreen 对窗口截图

打字
win + 空格 切换输入法 再通过 shift 修饰表示切换上一个

窗口
alt + 空格 弹出窗口菜单，就像在标题栏上右键单击一样
alt + f4 关闭窗口
Alt + F7 来移动窗口
Alt + F8 改变窗口大小。使用方向键移动或改变窗口大小，然后按 Enter 确定，也可以按 Esc 取消，返回到原来的状态。
Super + 上 / alt + f10 最大化或还原窗口
Super + h 隐藏当前窗口到任务栏 竟然和最小化是一个意思
Super + ` 切换同类型窗口
Super + 鼠标左键 拖拽窗口
Super + d 显示桌面，隐藏所有窗口

系统
Super + s 打开快速设置菜单
Super + L：锁定屏幕
Super + a：显示全部应用，也可以款素s快速双击 Super
Super + v 打开通知列表
ctrl + alt + del 注销

Docker
Super + 数字 如果窗口在 Dock 上，可以使用Super`键加上窗口在任务栏上的序号来快速切换到该窗口。

资源管理器
alt + left 后退
alt + right 前进
ctrl + c 复制
ctrl + x 剪切
ctrl + v 粘贴
alt + enter 属性
enter打开
delete 删除
F2 重命名

#### opensuse 系统

通用
ctrl + alt + t 打开终端

文件系统
meta + e 打开资源管理器
ctrl + esc 打开进程管理器
ctrl + n 新建窗口
ctrl + alt + c 复制路径
alt + shift + f4 在此处打开终端

窗口
alt + ` 切换同类型窗口
最大化/还原 win + pageUP
最小化 win + pageDown
win + 数字 打开任务栏对于数字的窗口并切换

### firefox 的快捷键

关闭标签页 	Ctrl + W
Ctrl + F4

关闭窗口 	Ctrl + Shift + W
Alt + F4

退出 	Ctrl + Q

选择标签页（1到8） 	Alt + 1 到 
选择最后一个标签页 	Alt + 9

新建标签页 	Ctrl + T
新建窗口 	Ctrl + N
新建隐私浏览窗口 	Ctrl + Shift + P

补齐 .com 地址 	Ctrl + Enter

### vscode 的快捷键

ctrl + alt + shift + 向上 向上复制一行
alt + 向上 向上移动一行

## 卸载软件

microsoft-edge-stable_126.0.2592.81-1_amd64.deb 使用 dpkg 安装后如何卸载

这里的 -r 或 --remove 选项表示卸载（remove）软件包。
sudo dpkg -r microsoft-edge-stable

如果软件包已经被卸载，但是它的配置文件仍然存在，您可能还想删除这些配置文件。为此，可以使用 -p 或 --purge 选项加上软件包的名称和版本号，如下：
sudo dpkg -P microsoft-edge-stable
-P选项已经包含了 -r 的功能，并且额外删除了配置文件

## 额外的软件

[video-downloader](https://github.com/unrud/video-downloader) 用不了，差评

## 技巧

sudo apt install nala
第一次使用优选 mirror
sudo nala fetch

一个 deb 安装器，之后可以右键安装 deb 安装包了
sudo nala install gdebi

sudo nala install gnome-tweaks

gonme 拓展管理器
sudo nala install gnome-shell-extension-manager

## Web 应用

duolingo
https://www.duolingo.cn/

阿里云盘
https://www.alipan.com/

## 技巧

### ubuntu 的 gnome 桌面点击 dock 栏图标最大化最小化设置 

1\.  设置的值。

gsettings range org.gnome.shell.extensions.dash-to-dock click-action

会输出一份枚举值。

2\. 设置点击可以最小化窗口。

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

注意：不要使用 sudo，此命令对当前用户生效

3\. 恢复默认设置。

gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
