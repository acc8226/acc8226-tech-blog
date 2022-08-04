---
title: vim-简单使用1
categories: 文本编辑器-使用
---

Vim 是从 vi 发展出来的一个文本编辑器。代码补完、编译及错误跳转等方便编程的功能特别丰富，在程序员中被广泛使用。

简单的来说， vi 是老式的字处理器，不过功能已经很齐全了，但是还是有可以进步的地方。 vim 则可以说是程序开发者的一项很好用的工具。

连 vim 的官方网站 ([http://www.vim.org](http://www.vim.org/)) 自己也说 vim 是一个程序开发工具而不是文字处理软件。

> What Vim Can Do
Vim is an advanced text editor that seeks to provide the power of the de-facto Unix editor 'Vi', with a more complete feature set. It's useful whether you're [already using vi](https://www.vim.org/viusers.php) or [using a different editor](https://www.vim.org/others.php).

### Windows版 Vim 下载

https://github.com/vim/vim-win32-installer/releases

![](https://upload-images.jianshu.io/upload_images/1662509-72f7b09236e9ed2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

vim 键盘图：
![](https://upload-images.jianshu.io/upload_images/1662509-fb00bf307e6290d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## vi/vim 的使用

基本上 vi/vim 共分为三种模式，分别是命令模式（Command mode），输入模式（Insert mode）和底线命令模式（Last line mode）。

### 普通模式(Normal mode)
用户刚刚启动 vi/vim，便进入了普通模式。

此状态下敲击键盘动作会被 Vim 识别为命令，而非输入字符。比如我们此时按下i，并不会输入一个字符，i 被当作了一个命令。

以下是常用的几个命令：
i 切换到输入模式，以输入字符。
x 删除当前光标所在处的字符。

按下: 切换到底线命令模式，以在最底一行输入命令。
若想要编辑文本：启动Vim，进入了命令模式，按i（插入）或a（附加）键都可以，切换到输入模式。

普通模式只有一些**最基本的命令**，因此仍要依靠底线命令模式输入更多命令。

Vim 强大的编辑能来自于其普通模式命令。普通模式命令往往需要一个操作符结尾。例如普通模式命令 dd 删除当前行，但是第一个"d"的后面可以跟另外的移动命令来代替第二个d，比如用移动到下一行的"j"键就可以删除当前行和下一行。另外还可以指定命令重复次数，2dd（重复dd两次），和 dj 的效果是一样的。用户学习了各种各样的文本间移动／跳转的命令和其他的普通模式的编辑命令，并且能够灵活组合使用的话，能够比那些没有模式的编辑器更加高效地进行文本编辑。

### 插入模式(Insert mode)

在命令模式下按下i就进入了输入模式。

在输入模式中，可以使用以下按键：

* 字符按键以及Shift组合，输入字符
* ENTER，回车键，换行
* BACK SPACE，退格键，删除光标前一个字符
* DEL，删除键，删除光标后一个字符
* 方向键，在文本中移动光标
* HOME/END，移动光标到行首/行尾
* Page Up/Page Down，上/下翻页
* Insert，切换光标为输入/替换模式，光标将变成竖线/下划线
* ESC，退出输入模式，切换到命令模式

### 底线命令模式 / 命令行模式(Command line mode)

在命令模式下按下:（英文冒号）就进入了底线命令模式。

底线命令模式可以输入单个或多个字符的命令，可用的命令非常多。
在底线命令模式中，基本的命令有（已经省略了冒号）：

* q 退出程序
* w 保存文件
* q! 退出程序而不保存(强制)
* wq 保存且退出程序

按 ESC 键可随时退出底线命令模式。

![](https://upload-images.jianshu.io/upload_images/1662509-60ac29434bc2a19d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## VIM 安装配置目录树或文件浏览插件-NERD tree

### 下载插件

*   下载路径[https://github.com/scrooloose/nerdtree](https://github.com/scrooloose/nerdtree) 这个是NERD tree的官网地址。
*   可以点击[https://github.com/scrooloose/nerdtree/archive/master.zip](https://github.com/scrooloose/nerdtree/archive/master.zip) 该链接直接下载。

### 安装配置

将解压目录下所有文件将其拷贝到 vim 可执行程序同级目录下
启动 VIM 的时候，默认是不会激活该插件的，如要在命令模式下键入命令`: NERDTree`

## NERDTree 命令简介

1. 和编辑文件一样，通过h j k l移动光标定位
2. 切换工作台和目录
  * ctr+w+h 光标focus左侧树形目录，ctrl+w+l 光标focus右侧文件显示窗口。
  * ctrl+w+w，光标自动在左右侧窗口切换
3. o 打开关闭文件或者目录，如果是文件的话，光标出现在打开的文件中
  * go 效果同上，不过光标保持在文件目录里，类似预览文件内容的功能
  * i和s可以水平分割或纵向分割窗口打开文件，前面加g类似go的功能
4. t 在标签页中打开
5. T 在后台标签页中打开
6. p 到上层目录
70. P 到根目录
81. K 到同目录第一个节点
9. J 到同目录最后一个节点
10. m 显示文件系统菜单（添加、删除、移动操作）
11. ? 帮助
12. q 关闭

## 参考

* [Linux vi/vim | 菜鸟教程](http://www.runoob.com/linux/linux-vim.html)
* [VIM 安装配置目录树或文件浏览插件-NERD tree - CSDN博客](https://blog.csdn.net/yupei881027/article/details/44559431)
