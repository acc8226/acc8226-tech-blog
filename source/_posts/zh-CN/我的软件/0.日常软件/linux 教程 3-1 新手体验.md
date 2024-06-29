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
vlc 

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
office 中 wps 缺少字体，然后打开一百多少 M 的 pdf 还会卡，由于是用 dpk 安装的，所以可以直接卸载 `sudo dpkg  -P  wps-office`
pdf 用自带的阅读器就很好 或者 浏览器也不差
邮件收发由于网易邮箱大师安装失败了，所以还是雷鸟吧
音乐用 spotify
视频 mpv，本来想着用 vlc 但是打不开
espanso 安装失败了

## 卸载软件

microsoft-edge-stable_126.0.2592.81-1_amd64.deb 使用 dpkg 安装后如何卸载

这里的 -r 或 --remove 选项表示卸载（remove）软件包。
sudo dpkg -r microsoft-edge-stable

如果软件包已经被卸载，但是它的配置文件仍然存在，您可能还想删除这些配置文件。为此，可以使用 -p 或 --purge 选项加上软件包的名称和版本号，如下：
sudo dpkg -P microsoft-edge-stable
-P选项已经包含了 -r 的功能，并且额外删除了配置文件

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
