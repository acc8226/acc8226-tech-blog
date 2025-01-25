---
title: IDE 中的字体选择
date: 2025-01-24 10:32:00
updated: 2025-01-24 10:32:00
categories: IDE-使用
---

## 基础知识

Ligatures 是一种将多个字符组合成一个字符的特性，例如将 ==> 显示为一个整体符号。如果你需要这种特性，可以选择支持 Ligatures 的字体。

Nerd Font Mono（或 NFM）： 这是专为等宽字体设计的版本，适合终端使用。等宽字体的特点是每个字符宽度一致，适合代码编辑和命令行操作。

## mono 字体

编程字体大多是简洁柔和的无衬线字体，更适合在屏幕上长时间阅读。

### monaco【商用】

发布于 1990 年代，是苹果早期的等宽字体，设计风格简洁，适合代码编辑。曾是 Mac 终端和 Xcode 的默认字体。
<!-- more -->

### menlo【商用】

Menlo 是一个无衬线等宽字体，由 Jim Lyles 设计。
发布于 2008 年，是 Monaco 的替代品，设计风格更圆润、易读，适合终端和代码编辑器。
首次出现于 2009 年 8 月上市的 Mac OS X Snow Leopard 系统内建字体之一。

### SF Mono【商用】

这是苹果公司设计的一种等宽字体。

### Courier New

Courier New 是 Windows 的缺省等宽字体，是另一种等宽字体，也是微软设计的，历史比 Consolas 更悠久。它的风格较为传统，字符宽度一致，适合代码编辑。

### Consolas

Windows 平台上，大名鼎鼎的 **consolas** 是很多人的选择，也是  Visual Studio 和 VSCode 的默认字体。Consolas 是一套等宽字体的字型，属无衬线字体，由 Lucas de Groot 设计。

[GitHub - mozilla/Fira](https://github.com/mozilla/Fira): Mozilla's new typeface, used in Firefox OS

### Cascadia Code

**[Cascadia](https://github.com/microsoft/cascadia-code)** 是一种有趣的新编码字体，包括编程连字，旨在增强 Windows 终端的现代外观。它与 Windows 终端捆绑在一起，现在也是 Visual Studio 中的默认字体。

### Fira Mono

[GitHub - mozilla/Fira](https://github.com/mozilla/Fira): Mozilla's new typeface, used in Firefox OS

### Fira Code

[GitHub - tonsky/FiraCode](https://github.com/tonsky/FiraCode): Free monospaced font with programming ligatures

Fira Code 基于 Fira Mono，是一款免费的编程连字等宽字体。
最新发布时间 on Dec 7, 2021
Fira Code 是一种免费的等宽字体，包含常用的编程语言中多种字符组合的连字。这只是一个字体呈现功能，底层代码仍然与ASCII兼容。这有助于更快地阅读和理解代码。对于一些常见的序列，如..或//，连字允许我们纠正间距。

### JetBrains Mono

大家都知道，我们平时开发用的 IDEA 就是JetBrains 家开发的。作为专业的 IDE 开发商，对用户诉求那肯定是非常清楚的，所以专门设计了自家的编程字体 JetBrains Mono 。

### Iosevka

[官网](https://typeof.net/Iosevka/) 定制性极强

一款现代化的编程字体集合，除了等宽、oO0 iIl1明显区分等基本特性外，还有很多非常现代的特性，比如：

多种风格：有非常多的字形可供选择，衬线/非衬线，多级字重，不同风格的斜体，甚至还有融合了其他常用编程字体设计风格的风味版本。

字形较窄：采用窄高的风格，水平上可以显示更多内容。（字体文件中同时包含窄和宽的字形，带有Extended的就是宽字形）

连体字形：跟 JetBrains Mono 一样，对很多常用的字符组合都有连体字形，美观度直线上升。

严格对齐：跟 Ubuntu Mono 一样，使用此字体时，中文字符宽度会严格等于2个英文字符宽度，强迫症福音。

[Iosevka](https://github.com/be5invis/Iosevka/releases)

我一般会选择 [PkgTTF-IosevkaFixed-32.4.0.zip](https://github.com/be5invis/Iosevka/releases/download/v32.4.0/PkgTTF-IosevkaFixed-32.4.0.zip)

### Inconsolata

[Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html) 是最为漂亮的等宽字体之一。从 2006 年开始它便一直是一款开源和可免费获取的字体。它的创造者 Raph Levien 在设计 Inconsolata 时秉承的一个基本原则是：等宽字体并不应该那么糟糕。使得 Inconsolata 如此优秀的两个原因是：对于 0 和 o 这两个字符它们有很大的不同，另外它还特别地设计了标点符号。

### Source Code Pro

优雅、可读性强，由 Adobe 中一个小巧但天才的团队打造。由 Paul Hunt 和 Teo Tuominen 设计，Source Code Pro 是由 Adobe 创造的，成为了它的首款开源字体。Source Code Pro 值得注意的地方在于它极具可读性，且对于容易混淆的字符和标点，它有着非常好的区分度。Source Code Pro 也是一个字体族，有 7 中不同的风格：Extralight、Light、Regular、Medium、Semibold、Bold 和 Black，每种风格都还有斜体变体。

### 谷歌 Noto 家族

Google 打造的庞大字体族。该项目非常庞大，是 Google 宣称 “组织全世界信息” 的使命的延续。假如你想更多地了解它，可以查看这个绝妙的关于这些字体的视频。

## 普通中文

### 思源黑体

### 思源宋体

## 中英文 2:1 加等宽

### Maple Mono

[GitHub - subframe7536/maple-font](https://github.com/subframe7536/maple-font): [Try V7!] Maple Mono: Open source monospace font with round corner, ligatures and Nerd-Font for IDE and command line. 带连字和控制台图标的圆角等宽字体，中英文宽度完美2:1

### Sarasa-Gothic

（国产）等距更纱黑体 Sarasa Mono SC 1.0.27

### 星汉等宽

（国产）星汉等宽 Milky Han Mono CN

### 谷歌 Noto Sans Mono

比如 谷歌 无衬线等宽简体中文 Noto Sans Mono CJK SC 2.004 是一款不错的选择。

### 微软 Cascadia Next SC

Cascadia 字体系列的下一个演变，Cascadia Next。我们才华横溢的排版师为 SC（简体中文）、TC（繁体中文）和 JP（日语）创建了 Cascadia Next 的三种变体。
此预发布版包含有限的字符集，涵盖了这些语言的绝大多数使用案例。简体中文：ASCII、GB2312 扩展

[releases-cascadia-next](https://github.com/microsoft/cascadia-code/releases/tag/cascadia-next)

## Nerd Fonts 系列

[Nerd Fonts](https://www.nerdfonts.com) - Iconic font aggregator, glyphs/icons collection, & fonts patcher

### meslolg nerd font

属于基于 menlo 改造的且加上了 nerd font。

### Github Monaspace nf

直接去 [nf 网站](https://www.nerdfonts.com/font-downloads)下载

[下载](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip) | [preview](https://www.programmingfonts.org/#monaspace-neon)

## 一些字体网站

* [Fontsource](https://fontsource.org)
