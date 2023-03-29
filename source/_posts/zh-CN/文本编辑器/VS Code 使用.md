---
title: VS Code 使用
date: 2022-05-07 09:42:38
updated: 2022-05-07 09:42:38
categories: 文本编辑器
---

作为一款开箱即用的产物，尽量不做过多额外配置。

## 设置 vscode 换行符 （\n）

直接搜索 files:eol 进行设置。

## 设置自动换行

搜索框输入： word warp 然后将值改成 on

## 我的必装插件

IntelliJ IDEA 键盘映射
<https://marketplace.visualstudio.com/items?itemName=k--kato.intellij-idea-keybindings>

markdownlint
<https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint>

## VS code 更改字体

两种字体的介绍:
等宽字体（英语：Monospaced Font）是指字符宽度相同的电脑字体。与此相对，字符宽度不尽相同的电脑字体称为比例字体（Proportional Font）。

在传统西文印刷中，比例字体可以提高单词的可读性。但因打字机及早期的电脑画面显示等由于技术的局限，无法进行字母宽度的比例调整，因此将每个字符都制作成一样的宽度，从而形成了等宽字体。在等宽字体中，字母 i, j 显得两侧余白较多，而字母 w, m 等的笔画显得相当拥挤。

但是随着图形用户界面主流的更新和电脑技术的提高，处理比例字体的局限性得到了突破，因此现在排版上显得比较自然的比例字体的使用已经相当普及。

由于等宽字体的特点，当今的平面设计上也有特意使用等宽字体所具有的文化特征进行创作的风格，其中最具有代表性的就是 ASCII 艺术。ASCII 艺术所使用的字符都是等宽字体，如果改用比例字体，图片往往变形而无法表达创作者本意。在网页设计中， `<tt></tt>` 或 `<pre></pre>` 等HTML 标记通常都是使用等宽字体。另外，代码以及文字接口的程序，如虚拟终端等也经常使用等宽字体。

另外，代码以及文字接口的程序，如虚拟终端等也**经常使用等宽字体**。

![截图](http://likai.test.upcdn.net/%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8-%E4%BD%BF%E7%94%A8/VS-Code-%E4%BD%BF%E7%94%A8/1.png)

## 修改 vscode 终端字体

在 code-首选项-设置里面，输入 fontsize, 点击功能-终端即可轻松找到。

## 多行操作快捷键

第一种模式
1 Alt+Shift  竖列选择

这种模式下只可以选择竖列，不可以随意插入光标。所以只限制于同一列且不间隔的情况下。

第二种模式
1 Shift + Ctrl 竖列选择
2 Ctrl + 光标点击 选择多个编辑位点

这种模式下不仅可以选择竖列，同时还可以在多个地方插入光标。

## VS Code 配置 Python

### Prerequisites

<https://code.visualstudio.com/docs/python/python-tutorial#_prerequisites>

To successfully complete this tutorial, you need to first setup your Python development environment. Specifically, this tutorial requires:

* VS Code
* VS Code Python extension
* Python 3

### 验证安装

Linux/macOS: open a Terminal Window and type the following command:

```sh
python3 --version
```

Windows: open a command prompt and run the following command:

```sh
py -3 --version
```

### Select a Python interpreter

<https://code.visualstudio.com/docs/python/python-tutorial#_select-a-python-interpreter>

Python is an interpreted language, and in order to run Python code and get Python IntelliSense, you must tell VS Code which interpreter to use.

From within VS Code, select a Python 3 interpreter by opening the **Command Palette** (Ctrl+Shift+P), start typing the **Python: Select Interpreter** command to search, then select the command. You can also use the **Select Python Environment** option on the Status Bar if available (it may already show a selected interpreter, too)

### 启用虚拟环境

Note: When you create a new virtual environment, you should be prompted by VS Code to set it as the default for your workspace folder. If selected, the environment will automatically be activated when you open a new terminal.

For Windows

```sh
py -3 -m venv .venv
.venv\scripts\activate
```

Once you are finished, type deactivate in the terminal window to deactivate the virtual environment.

## 下载加速

将域名替换为 vscode.cdn.azure.cn

## 参考

vscode 中多行操作快捷键_闲云野鹤的博客-CSDN博客_vscode 多行选择快捷键
<https://blog.csdn.net/weixin_44481878/article/details/88532141>
