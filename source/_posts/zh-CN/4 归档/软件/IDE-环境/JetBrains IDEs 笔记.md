---
title: IDEA 笔记
date: 2019-06-02 21:41:52
updated: 2024-12-11 12:42:24
categories: IDE-使用
---

## 下载和安装（以 IDEA 举例）

<https://www.jetbrains.com/idea/download/other.html>

版本选择：根据我的观察，每年五月份过后获取的上个年度的最新版本应该是最终版本，可下载之。

## Windows 版的安装说明

1. 解压
1. 【可选】添加至环境变量，这样无论在哪个目录下都可启动 IntelliJ IDEA
1. 【可选】调整 JVM 堆大小的值
1. 打开命令行工具进入安装目录的 bin 文件夹下， 键入 idea.bat。这个命令同时会在 `${user.home}/. IntelliJIdea2020.3` 目录中初始化一系列的配置文件。

附原文：

<!-- more -->

```txt
IntelliJ IDEA

INSTALLATION INSTRUCTIONS
===============================================================================

  Windows Installation Instructions
  ------------------------------------------------------------------------------
  1. Unpack the IntelliJ IDEA distribution file that you downloaded to
     where you wish to install the program. We will refer to this destination
     location as your {installation home} below.

  2. [OPTIONAL] Add the "{installation home}/bin" to your PATH environmental
     variable so that you may start IntelliJ IDEA from any directory.

  3. [OPTIONAL] To adjust the value of JVM heap size, create
      ${user.home}/.IntelliJIdea2020.3/config/idea.vmoptions (or idea64.vmoptions
      if using a 64-bit JDK), and set the -Xms and -Xmx parameters. To see how to do this,
      you can reference the vmoptions file under "{installation home}/bin" as a model.

  4. Open a console and cd into "{installation home}/bin" and type:

       idea.bat

     to start the application. As a side effect, this will initialize various
     configuration files in the ${user.home}/.IntelliJIdea2020.3 directory.

  [OPTIONAL] Changing location of "config" and "system" directory
  ------------------------------------------------------------------------------
  By default, IntelliJ IDEA stores all your settings under the ${user.home}/.IntelliJIdea2020.3/config
  directory and uses ${user.home}/.IntelliJIdea2020.3/system as a data cache.
  If you want to change these settings,

  1. Open a console and cd into ${user.home}/.IntelliJIdea2020.3/config

  2. Create the file "idea.properties" and open it in an editor. Set the
     idea.system.path and/or idea.config.path variables as desired, for
     example:

     idea.system.path=${user.home}/.IntelliJIdea2020.3/system
     idea.config.path=${user.home}/.IntelliJIdea2020.3/config

  3. Note that we recommend to store data cache ("system" directory) on a disk
     with at least 1GB of free space.

  [OPTIONAL] Associate "*.ipr" files (IDEA project files) with IntelliJ IDEA
  ------------------------------------------------------------------------------
  1. Open a console and cd into "{installation home}/bin"

  2. If your installation directory is NOT "C:\Program Files\JetBrains\IntelliJ IDEA 10.0",
     edit file "ipr.reg" (you should replace all occurrences of
     "C:\Program Files\JetBrains\IntelliJ IDEA 10.0")

  3. From "{installation home}" type:
       ipr.reg
     to add information about "*.ipr" files to registry.

Enjoy!

-IntelliJ IDEA Development Team
```

## 使用前的通用设置

**修改默认 行分隔符**， 这里一律使用 unix 的换行符行为。

File -> Settings… Editor -> Code Style

建议都设置成 Unix 形式的 `Unix and OS X（\n）`

![](https://upload-images.jianshu.io/upload_images/1662509-2c28fe32553db645.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 快捷键

[官方快捷键参考手册](https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf) | [中文翻译](https://www.cnblogs.com/nzbin/p/18022979)

* Ctrl + N Navigate|Class Open any file in your project 快速打开类 Ctrl + Shift + N Navigate|File Open any file in your project 快速打开文件
* Ctrl + F / Cmd + F 意为 find 在当前文件进行文本查找 Ctrl + Shift + F 在当前项目进行文本查找
* Ctrl + R / Cmd + R 意为 replace 在当前文件进行文本替换 Ctrl + Shift + R 在当前项目进行文本替换
* Ctrl + Shift + Up/Down 整块代码 范围内向上/下移动 Alt + Shift + Up/Down 上/下移一行 或者 选中行代码向上/下移动
* Alt + Up/Down 在方法间快速移动定位
* Ctrl + O (Code|Override Methods) 重写方法 Ctrl + I(Code|Implements Methods) 实现方法
* Ctrl + U 转到父类 Ctrl + Alt + B 跳转到类 / 方法实现处
* Ctrl + Shift + U 大小写转化
* Shift + F6 (Refactor|Rename) 重构–重命名
* Ctrl + Alt + L 格式化代码
* Ctrl + G 跳转到行
* Ctrl + Alt + 左方向键 | 快速返回上次查看代码的位置（Back） Ctrl + Alt + 右方向键 | 快速返回上次查看代码的位置（Forward）
* Alt+F7 (Edit|Find|Find Usages)
* Ctrl + Q(View|Quick Documentation) Ctrl + B(Navigate|Declaration or Usages) 查看详情 click the mouse on usages with the CTRL 进入详情 Ctrl + F12 (Navigate|File Structure) + * select element press Enter key
* Ctrl + Shift + 空格 自动补全 Shift + Click close tabs 还是喜欢用鼠标中键
* Alt + Insert (Code|Generate) 自动生成，代码自动生成，如生成对象的 set / get 方法，构造函数，toString() 等 Alt+F1 查到当前编辑元素
* Ctrl + W(select word) Ctrl + 方向键（左 / 右）跳转到上一个 下一个单词的首位置 Ctrl + 方向键（上 / 下）无效
* Shift + 方向键（左 / 右）选中内容左/右移动一位 Shift + 方向键（上 / 下）选中内容上 / 下移动一行
* 当光标在单词首 或者 尾的位置时，可以 Ctrl + Shift + Left/Right 选中靠左/靠右单词
* 单行注释(//) ctrl+/ 注释光标所在行代码，会根据当前不同文件类型使用不同的注释符号多行注释(//) 注释选中多行代码块注释 ctrl+shift+/
* Ctrl+X 默认剪切光标当前行。否则为剪切选中内容 Ctrl+D 默认复制光标当前行到下一行。否则为复制选中内容到下一行 Ctrl+Y 删除行
* 清除无效包引用 Ctrl + Alt + O
* Alt + 左方向键 向左切换 tab 页 Alt + 右方向键 向右切换 tab 页
* 抽取函数/方法 Command-Option-M（Ctrl-Alt-M）

**修改 Project 工具窗口（或其他活动工具窗口）大小** Ctrl+Shift+Right（Windows 或 Linux）或 ⇧⌘Right (macOS) 增加工具窗口宽度，按 Ctrl+Shift+Left 或 ⇧⌘Left 减少工具窗口宽度。

对于其他工具窗口，例如 Run 或 Problems，可以使用 Ctrl+Shift+Up（Windows 或 Linux）或 ⇧⌘Up (macOS) 增加高度，使用 Ctrl+Shift+Down 或 ⇧⌘Down 减少高度。

**使用 Esc 返回编辑器窗口，使用 F12 跳转到上次使用的工具窗口** 完成 Project 工具窗口、Debug 窗口或 Maven 等工具窗口的操作后，使用 Esc 即可返回编辑器（不必在编辑器窗口中点击鼠标）。

还可以使用 F12 将焦点返回上次使用的工具窗口（作为该工具窗口的特定快捷键的替代方法）。

Shift + ESC 隐藏工具窗口 也能和 F12 连用。

## Live Templates

Java 开发过程经常需要编写有固定格式的代码，例如说声明一个私有变量，logger 或者 bean 等等。对于这种小范围的代码生成，我们可以利用 IDEA 提供的 Live Templates 功能。刚开始觉得它只是一个简单的 Code Snippet，后来发现它支持变量函数配置，可以支持很复杂的代码生成。下面我来介绍一下 Live Templates 的用法。

IDEA 自带很多常用的动态模板，在 Java 代码中输入 fori，回车就会出现

```java
for (int i = 0; i < ; i++) {
}
```

按 Tab 可以在各个空白处跳转，手动填值。

![详见设置页面-Live Templates](https://upload-images.jianshu.io/upload_images/1662509-662f0d4a3c6ed377.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- **psvm** 生成 main 方法的快捷键
- **sout** 生成 `System.out.println();`

## Postfix Completion

Postfix Completion 功能本质上也是代码模板，只是它比 Live Templates 来得更加便捷一点点而已。具体它是做什么的，我们通过下面一张 Gif 演示图来说明：

![image](https://upload-images.jianshu.io/upload_images/1662509-009cc6a8e8d3442b.gif?imageMogr2/auto-orient/strip)

如上图所示，非空的判断在 Java 代码中应该是非常常见的一句话代码，如果用 Live Templates 当然也是可以快速生成，但是没有上图 Gif 这种 Postfix Completion 效果快。也许只是快了那么 0.01 秒，但是有如此好用的功能不用也是一种浪费。

![Postfix Completion 的设置](https://upload-images.jianshu.io/upload_images/1662509-3f68674ff52d6514.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**1\. var 声明**

![](https://upload-images.jianshu.io/upload_images/1662509-476d60cd15a59ef9?imageMogr2/auto-orient/strip)

**2\. null 判空**

![](https://upload-images.jianshu.io/upload_images/1662509-d21511891faa8edb?imageMogr2/auto-orient/strip)

**3\. notnull 判非空**

![](https://upload-images.jianshu.io/upload_images/1662509-779adca154050bd5?imageMogr2/auto-orient/strip)

**4\. nn 判非空**

![](https://upload-images.jianshu.io/upload_images/1662509-da7fd03fd0be7270?imageMogr2/auto-orient/strip)

**5\. for 遍历**

![](https://upload-images.jianshu.io/upload_images/1662509-d591171b0f26152e?imageMogr2/auto-orient/strip)

**6\. fori 带索引的遍历**

![](https://upload-images.jianshu.io/upload_images/1662509-86e651c2d563707e?imageMogr2/auto-orient/strip)

**7\. not 取反**

![](https://upload-images.jianshu.io/upload_images/1662509-0db8989f7616e244?imageMogr2/auto-orient/strip)

**8\. if 条件判断**

![](https://upload-images.jianshu.io/upload_images/1662509-01105e97ed8dca27?imageMogr2/auto-orient/strip)

**9\. cast 强转**

![](https://upload-images.jianshu.io/upload_images/1662509-8da2fa5ff3004641?imageMogr2/auto-orient/strip)

**10\. return 返回值**

![](https://upload-images.jianshu.io/upload_images/1662509-1b2405284f52d4fc?imageMogr2/auto-orient/strip)

## IntelliJ IDEA 两种 keymap 快捷键方案 Mac OS X 和 Mac OS X 10.5+ 的区别

就是 Mac OS X 10.5+ 更贴近于 Mac 系统本身快捷键的操作体验，IDE 的快捷键与系统快捷冲突的更少；而 Mac OS X 方案更贴近于 IntelliJ IDEA 固有的设计。

因此，如果你有经常更换系统平台进行开发的需求，那么为了快捷键的更快适应，达到体验一致性，就**使用 Mac OS X 方案**；如果想要更爽的利用 mac 系统开发，没有跨平台和协作性的问题的话，就使用 Mac OS X 10.5+ 方案。

官网：<http://www.jetbrains.com/idea/download/#section=windows>

![设置编码](https://upload-images.jianshu.io/upload_images/1662509-43b4d7de28f46b8b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

| **快捷键** | **介绍** |
| --- | --- |
| Alt + Enter | 根据光标处所在的问题，提供快速修复选择，光标放在的位置不同提示的结果也不同（万能修复快捷键，同时可以帮助我们生成本地变量==eclipse 中的 ctrl+1）注意：非个人编码问题导致的错误，都可以尝试使用该快捷键修复 |
| Alt + Insert | 代码自动生成，如生成对象的 set / get 方法，构造函数，toString() 等 |
| Shift + Shift | 查找所有文件 |
| Ctrl + Alt + L | 格式化代码，可以对当前文件和整个包目录使用 |
| Alt + 7 | 显示当前类中的所有方法、全局常量，方法还包括形参和返回值 |
| Alt + F7 | 可以查看一个 Java 类、方法或变量的直接使用情况。 |
| ctrl + alt +b | 查看接口的实现类 |
| ctrl + h | 查看类或接口的继承关系 |
| F7 | 在 Debug 模式下，进入下一步，如果当前行断点是一个方法，则进入当前方法体内，Step Into |
| F8 | 在 Debug 模式下，进入下一步，如果当前行断点是一个方法，则不进入当前方法体内，Step Over |
| F9 | 在 Debug 模式下，恢复程序运行，但是如果该断点下面代码还有断点则停在下一个断点上，Resume |

## Idea 合并 test 分支到主分支

【local branches】本地分支【remote branches】远程仓库分支

第一步: 合并到 master 主分支切换到 master 分支

第二步: 合并代码到 master 主分支, 在合并的分支上点击 merge ![点击merge](https://upload-images.jianshu.io/upload_images/1662509-4933ab0ca8f40e7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## IDEA 设置代理

![](https://upload-images.jianshu.io/upload_images/1662509-d309c9461605568e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## IDEA 集成 tomcat

## Intellij IDEA 打开多个窗口项目

![](https://upload-images.jianshu.io/upload_images/1662509-6fa8e0b6fa8d533a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 已集成的 HTTP Request 工具

![](https://upload-images.jianshu.io/upload_images/1662509-835188162fd7c6bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Following HTTP Request Live Templates are available:

- 'gtrp' and 'gtr' create a GET request with or without query parameters;
- 'ptr' and 'ptrp' create a POST request with a simple or parameter-like body;
- 'mptr' and 'fptr' create a POST request to submit a form with a text or file field (multipart/form-data);

<!-- more -->

```md
### GET 请求

GET http://localhost:80/api/item Accept: application/json
```

## 记录

### 非商业用途免费用

建议在 github 的项目。

三个月内有活跃

申请地址

<https://www.jetbrains.com/shop/eform/opensource?product=ALL>

### 开启 idea 自动提示功能

ctrl+alt+s 进入快捷键设置界面。打开 Code Completion / 代码补全，勾选 输入时显示建议 即可。

### JetBrains Mono 字体安装

JetBrains 已推出编程字体 Mono：更适合程序开发人员

JetBrains 表示：在当今的大部分时间里，我们作为开发人员都在看代码。我们一直在寻找最佳字体，以使我们更容易在屏幕上查看文本。但是，许多流行字体中的逻辑并不总是考虑到通读代码和阅读书本之间的区别。我们的眼睛以非常不同的方式沿代码移动，通常必须垂直移动和水平移动，这与阅读书籍不同，因为它们总是沿同一方向沿文本滑动。

因此，在使用 JetBrains Mono 进行开发时，除其他外，重点研究了在长时间使用代码期间可能导致眼睛疲劳的问题。我们考虑了字母的大小和形状等问题；它们之间的空间量，自然以等宽字体设计的平衡；一些看起来不必要的细节和符号之间不清楚的区别，例如 I 和 l；还要和开发字体时的编程连字。

**JetBrainsMono.** A typeface for developers

- **mac**: Select all font files in the folder and double-click them. Click the “Install Font” button.
- **windows**: Select all font files in the folder, right-click any of them, then pick “Install” from the menu.
- **linux**: Unpack fonts to ${HOME}/.fonts and execute sudo fc-cache -f -v

使用方式： Select JetBrains Mono in the IDE settings: go to Preferences/Settings → Editor → Font, and then select JetBrains Mono from the Font dropdown.

**RECOMMENDED SETTINGS** --- Size: 13 **FOR THE FONT** --- Line spacing: 1.2

## 问题

**@Override is not allowed when implementing interface method** @Override 从 jdk1.5 开始出现的，是用来标注方法重写；通常方法重写发生在继承父类，重写父类方法，或者实现接口，实现接口方法；

@Override 能够保证你正确重写方法，当重写方法出错时（方法名误写、漏掉参数）编译器会提示编译错误

1.问题出在 idea 得 jdk 版本低于 1.5 ：File → Project Structure → Modules 把 JDK 版本改成大于 1.5 就可以了

### 让 IDEA 显示标题栏，而不是跟菜单栏合并

新版的 IDEA 默认把标题栏跟菜单栏合并了，变得美观了些，但是非常不方便拖动窗口，影响生产力解决方法：

- 打开 Help -> Edit Custom VM Options…
- 添加 -Dide.win.frame.decoration=false
- 重启

### 重新分配地址的变量或者参数，IDEA 会默认给它们加上下划线

这是 IntelliJ IDEA 2018.2 的新特性。

需要关闭修改的话，可以在 Settings | Editor | Color Scheme | Language Defaults | Identifiers | Reassigned local variable.下关闭这个提示： 把右侧的 Effects 默认勾选给取消。

> 建议还是保留比较好

### 提示：Boolean method ‘xxx‘ is always inverted

提示详情：一个返回类型为布尔值的方法，被 IDEA 自动高亮，提示为 Boolean method 'xxx' is always inverted。并提供一个 Invert method 的解决方案。

### IDEA 突然爆红，但是代码却可以正常运行

原因是因为 IDEA 有缓存，只需要刷新一下缓存就好了

解决办法：

file --> Invalidate Caches /Restart. --> Invalidate and Restart

### command line is too long. shorten command line for xxx 的解决方法

方式一：打开 IDEA，找到项目最上部的 .idea ----- 双击打开 ----- 找到 workspace.xml ---- 双击打开该文件

在 workspace.xml 文件中搜索：`<component name="PropertiesComponent">` 包含配置内加上一条：`<property name="dynamic.classpath" value="true" />`

重新启动便可正常运行。

方式二：

第一步：找到该程序的配置信息编辑处第二步：找到修改选项的地方：“Modify options”，按照图中顺序选择第三步：再选择具体的 “Shorten command line”选项：classpath 路径

### idea 无法解析 SDK

应该是运行配置有问题

## 参考

* IntelliJ IDEA_ReferenceCard <https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf>
* 伯乐在线 > 代码生成利器：IDEA 强大的 Live Templates http://blog.jobbole.com/110607
* JetBrains 官方发布快捷键技巧：IntelliJ IDEA 中，你完全不需要鼠标的 10 种情况 - IT 之家 <https://www.ithome.com/0/573/291.htm>
