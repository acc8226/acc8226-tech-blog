---
title: linux 教程 3-3 使用技巧
date: 2024-09-13 21:44:23
updated: 2024-09-13 21:44:23
categories:
  - 收藏
  - 日常软件
---

## Bash 脚本自动化任务

## 网络管理

ifconfig 或 ip：查看和配置网络接口。
ping：测试网络连接。
netstat：显示网络状态。

## deepin 深度操作系统

升高音量

```sh
#!/bin/sh
amixer -D pulse sset Master 5%+
```

降低音量

```sh
#!/bin/sh
amixer -D pulse sset Master 5%-
```

安装 jre`sudo apt install default-jre`

安装 jdk`sudo apt install default-jdk`

添加快捷方式到启动器 `ln -s /home/kai/software/Zotero_linux-x86_64/zotero.desktop  ~/.local/share/applications/zotero.desktop`