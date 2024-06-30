---
title: linux 教程 3-1 新手体验
date: 2024-06-29 20:43:00
updated: 2024-06-29 20:43:00
categories:
  - 收藏
  - 日常软件
---

更新系统
sudo apt update
sudo apt  upgrade -y

## 如何安装软件

###  appimage

```sh
chmod +x  ./mouse-actions-gui_0.4.4_amd64.AppImage
./mouse-actions-gui_0.4.4_amd64.AppImage
```

###  snap 商店

snap 商店
ubuntu 自带了

例如可以安装

bitwarden
spotify
vscode
idea
vlc 安装失败，但是 nala 竟然可以安装成功

### flathub 商店

[flathub](https://flathub.org/) 商店
更换源
sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub

## 安装软件

内置 firefox 已经够用，然后再搭配插件 Vimium C - 全键盘操作浏览器 + Tree Style Tab - 树状标签页管理 + TST Hoverswitch
官网下载  [rime](https://github.com/rime/home/wiki/RimeWithIBusx)  输入法

```sh
sudo apt-get install ibus-rime
```

[edge](https://www.microsoft.com/zh-cn/edge) 还是不错的

然后 ctrl + ` 可以切换输入法

鼠标手势 目前 mouse-actions 不生效
键盘增强 虚位以待
截图 自带的挺好用
下载 motrix
坚果云 安装失败但是最终还是成功了，参考了这篇[博客](https://blog.csdn.net/qq_41100419/article/details/131826132)

```sh
ar x nautilus_nutstore_amd64.deb
tar xJf control.tar.xz
# 修改 control 中的依赖（用文本编辑器就可以），将其中的 libnautilus-extension1a (>= 3.14.1) 依赖删除（因为这个依赖 Ubuntu 23.04 已经没有了）
tar --ignore-failed-read -cvJf control.tar.xz postinst   postrm  md5sums control
#   将修改后的文件重新打包为 deb
ar rcs newpackage.deb debian-binary control.tar.xz data.tar.xz
# 完成这些步骤后，安装新生成的 newpackage.deb 即可。
dpkg -i  newpackage.deb
```

bitwarden yyds
office 中 [wps](https://www.wps.cn/product/wpslinux#) 缺少字体，然后打开一百多少 M 的 pdf 还会卡，由于是用 dpk 安装的，所以可以直接卸载 `sudo dpkg  -P  wps-office`
pdf 用自带的阅读器就很好 或者 浏览器也不差
[qq](https://im.qq.com) 体验很好
邮件收发由于网易邮箱大师安装失败了，所以还是雷鸟吧
音乐用 spotify
视频 mpv，本来想着用 vlc 但是打不开
espanso 尝试 snap 和手动安装都失败了，所以将尝试编译安装，将 17090412860 和 acc8226@qq.com 录入进去

ToDesk 安装失败 因此卸载之
sudo rm /opt/todesk/config/config.ini
sudo apt-get remove --purge todesk

[rustdesk](https://github.com/rustdesk/rustdesk/) 还是可以的

Albert 安装失败了
[ulauncher](https://ulauncher.io/) ok

## 快捷键 的使用

### 雷柏键盘 专用

fn + f3 打开计算器
fn + f4 打开预览 同 win
fn + f5 打开显示器设置
fn + f6 上一曲
fn + f7 下一曲
fn + f8 暂停 播放
fn + f9 停止
fn + f10 静音
fn + f11 降低音量
fn + f12 升高音量

### 系统快捷键

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
alt + 空格 弹出窗口菜单，就像在标题栏上右键单击一样。
alt + f4 关闭窗口
Alt+F7 来移动窗口
Alt+F8 改变窗口大小。使用方向键移动或改变窗口大小，然后按 Enter 确定，也可以按 Esc 取消，返回到原来的状态。
Super + 上 / alt + f10 最大化或还原窗口
Super + h 隐藏当前窗口到任务栏 竟然和最小化是一个意思
Super + ` 应用程序的窗口之间切换
Super + 鼠标左键 拖拽窗口
Super + D：显示桌面，隐藏所有窗口

系统
Super + s 打开快速设置菜单
Super + L：锁定屏幕
Super + A：显示全部应用，也可以款素s快速双击 Super
Super+V 打开通知列表
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

## 卸载软件

microsoft-edge-stable_126.0.2592.81-1_amd64.deb 使用 dpkg 安装后如何卸载

这里的 -r 或 --remove 选项表示卸载（remove）软件包。
sudo dpkg -r microsoft-edge-stable

如果软件包已经被卸载，但是它的配置文件仍然存在，您可能还想删除这些配置文件。为此，可以使用 -p 或 --purge 选项加上软件包的名称和版本号，如下：
sudo dpkg -P microsoft-edge-stable
-P选项已经包含了 -r 的功能，并且额外删除了配置文件

## 额外的软件

[NewsFlash](https://gitlab.com/news-flash/news_flash_gtk) snap 商店也有下载

[video-downloader](https://github.com/unrud/video-downloader)

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
