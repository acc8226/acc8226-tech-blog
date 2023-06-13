---
title: Eclipse 笔记
date: 2017-06-08 17:38:38
updated: 2022-11-09 13:56:00
categories: IDE-使用
---

## 官网

**下载地址** Eclipse Packages | The Eclipse Foundation - home to a global community, the Eclipse IDE, Jakarta EE and over 350 open source projects... <https://www.eclipse.org/downloads/packages/>

## 使用前基本配置

将工作区 Text 文件编码改为 UTF-8。

![](https://upload-images.jianshu.io/upload_images/1662509-d6a91d318d8dc401.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

默认编辑区域的字体太小，优先推荐调节为 14 或者 16 号。

![](https://upload-images.jianshu.io/upload_images/1662509-fb72d70d64cc54d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Eclipse 常用快捷键

### Ctrl + Shift + R：打开资源

这可能是所有快捷键组合中最省时间的了。这组快捷键可以让你打开你的工作区中任何一个文件，而你只需要按下文件名或 mask 名中的前几个字母，比如 applic\*.xml。

### Ctrl + O：快速 outline

如果想要查看当前类的方法或某个特定方法，但又不想把代码拉上拉下，也不想使用查找功能的话，就用 ctrl+ o 吧。它可以列出当前类中的所有方法及属性，你只需输入你想要查询的方法名，点击 enter 就能够直接跳转至你想去的位置。

### Alt + Shift + R：重命名

重命名属性及方法在几年前还是个很麻烦的事，需要大量使用搜索及替换，以至于代码变得零零散散的。今天的 Java IDE 提供源码处理功能，Eclipse 也是一样。现在，变量和方法的重命名变得十分简单，你会习惯于在每次出现更好替代名称的时候都做一次重命名。要使 用这个功能，将鼠标移动至属性名或方法名上，按下 alt+shift+r，输入新名称并点击回车。就此完成。如果你重命名的是类中的一个属性，你可以点击 alt+shift+r 两次，这会呼叫出源码处理对话框，可以实现 get 及 set 方法的自动重命名。

### Alt+ Shift +l 以及 Alt + Shift+m：提取本地变量及方法

源码处理还包括从大块的代码中提取变量和方法的功能。比如，要从一个 string 创建一个常量，那么就选定文本并按下 alt+shift+l 即可。如果同 一个 string 在同一类中的别处出现，它会被自动替换。方法提取也是个非常方便的功能。将大方法分解成较小的、充分定义的方法会极大的减少复杂度，并提 升代码的可测试性。

### Ctrl +. 及 Ctrl +1：下一个错误及快速修改

ctrl+. 将光标移动至当前文件中的下一个报错处或警告处。这组快捷键我一般与 ctrl+1 一并使用，即修改建议的快捷键。新版 Eclipse 的修改建议做的很不错，可以帮你解决很多问题，如方法中的缺失参数，throw/catch exception，未执行的方法等等。

### Alt+方向键

这也是个节省时间的法宝。这个组合将当前行的内容往上或下移动。在 try/catch 部分，这个快捷方式尤其好使。

### Ctrl + F11 运行最后一次执行的程序

### Ctrl + m

大显示屏幕能够提高工作效率是大家都知道的。Ctrl+m 是编辑器窗口最大化的快捷键。

### Shift + Enter 及 Ctrl + Shift + Enter

Shift+enter 在当前行之下创建一个空白行，与光标是否在行末无关。Ctrl + shift + enter 则在当前行之前插入空白行。

### Ctrl + E：快速转换编辑器

## 自动填写功能

这组快捷键将帮助你在打开的编辑器之间浏览。使用 ctrl + pageDown 或 ctrl + pageUp 可以浏览前后的选项卡，但是在很多文件打开的状态下，ctrl+e 会更加有效率。

## 开启 java editor 的自动填写功能, 填写你需要的正则或者普通字符串都行

windows->preferences->java->editor->content assist 填入`.[a-zA-Z]`

![](https://upload-images.jianshu.io/upload_images/1662509-8b5a1da57fed350b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 更改 src 所在构建路径

![](https://upload-images.jianshu.io/upload_images/1662509-737b8760715a32b1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## attach source 关联源码

点击 Eclipse 打开 .class 文件时出现的那个 “Attach Source” 按键，然后把 JDK 库的源文件压缩包（通常是在 jdk 安装的根目录中的一个 “src.zip” 文件）载入 Eclipse 中。

其他的第三方 java 插件的源代码文件的载入方法类似。

## Eclipse 中对 maven 项目进行打包

选中项目右键 --》 Run As/Debug As -- 》 Maven build

## 遇到过的问题

### Eclipse 启动 Tomcat 时 45 秒超时解决方法

双击 Servers 视图中的对应的 Server，打开 Server 的属性界面，右边有个 Timeouts，把里面的 45 改大些

## Eclipse 教程 | 菜鸟教程

<https://www.runoob.com/eclipse/eclipse-tutorial.html>
