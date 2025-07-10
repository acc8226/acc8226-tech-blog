---
title: IDE 的字体选择
date: 2025-01-24 10:32:00
updated: 2025-03-13 22:50:27
categories: IDE-使用
---

## 基础知识

* Ligatures 连字是一种将多个字符组合成一个字符的特性，例如将 ==> 显示为一个整体符号。如果你需要这种特性，可以选择支持 Ligatures 的字体。
* Nerd Font Mono（或 NFM 体）是专为等宽字体设计的版本，适合终端使用。等宽字体的特点是每个字符宽度一致，适合代码编辑和命令行操作。

## 等宽英文（mono）

编程字体大多是简洁柔和的无衬线字体，更适合在屏幕上长时间阅读。

### 苹果系

#### monaco

发布于 1990 年代，是苹果早期的等宽字体，设计风格简洁，适合代码编辑。曾是 Mac 终端和 Xcode 的默认字体。
<!-- more -->

#### menlo

Menlo 是一个无衬线等宽字体，由 Jim Lyles 设计。发布于 2008 年，是 Monaco 的替代品，设计风格更圆润、易读，适合终端和代码编辑器。首次出现于 2009 年 8 月上市的 Mac OS X Snow Leopard 系统内建字体之一。

#### SF Mono

这是苹果公司设计的一种等宽字体。

### 微软系

#### Courier New

Courier New 是 Windows 的缺省等宽字体，是另一种等宽字体，也是微软设计的，历史比 Consolas 更悠久。它的风格较为传统，字符宽度一致，适合代码编辑。

#### Consolas

在Windows 平台上，大名鼎鼎的 consolas 是很多人的选择，也是 Visual Studio 和 VSCode 的默认字体。Consolas 是一套等宽字体的字型，属无衬线字体，由 Lucas de Groot 设计。

#### Cascadia Code

[Cascadia Code](https://github.com/microsoft/cascadia-code) 是微软打造的一款等宽编程字体。这款字体的字形风格特别，它除了优化代码的可读性、让字母数字和符号更易辨认之外，最大的特点是支持编程连字 (Programming Ligatures)，即在输入的时候，可以通过组合字符来创建新的字形。旨在增强 Windows 终端的现代外观。它与 Windows 终端捆绑在一起，现在也是 Visual Studio 中的默认字体。

### Mozilla 系

#### Fira Mono

[GitHub - mozilla/Fira](https://github.com/mozilla/Fira): Mozilla's new typeface, used in Firefox OS

#### Fira Code

[GitHub - tonsky/FiraCode](https://github.com/tonsky/FiraCode): Free monospaced font with programming ligatures

Fira Code 基于 Fira Mono，是一款免费的编程等宽字体，加入了编程连字特性 (ligatures)。 最新发布时间 on Dec 7, 2021。包含常用的编程语言中多种字符组合的连字。这只是一个字体呈现功能，底层代码仍然与 ASCII 兼容。这有助于更快地阅读和理解代码。对于一些常见的序列，如 `..` 或 `//`，连字允许我们纠正间距。

Fira Code 也是第一个提供专用字形来渲染进度条的编程字体。

### Adobe 系

#### Source Code Pro

[Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) | [GitHub Releases](https://github.com/adobe-fonts/source-code-pro/releases) 是 Adobe 打造的等宽编程字体，也是 adobe 打造的首款开源字体。非常适合用于编程场景，极具可读性，且对于容易混淆的字符和标点，它有着非常好的区分度。支持 Linux、macOS 和 Windows 等操作系统，提供了 ExtraLight、Light、Regular、Medium、Semibold、Bold 和 Black 共 7 种字体粗细。

Source Code Pro 采用了开源字体许可证 SIL Open Font License，开源免费且可商用。

### 谷歌系

#### 谷歌 Noto 家族

Google 打造的庞大字体族。该项目非常庞大，是 Google 宣称 “组织全世界信息” 的使命的延续。

### GitHub 系

#### Mona Sans

[Mona Sans](https://github.com/github/mona-sans) 是一种强大而多功能的字体，采用 Degarism 设计，灵感来自工业时代的怪诞。Mona Sans 字体适用于产品、Web 和打印等方面。Mona Sans 是一种可变字体。可变字体允许将字体的不同变体合并到一个文件中，并且所有主要浏览器都支持可变字体，从而可以提高性能并精细地控制字体的字重、宽度和倾斜度。

#### Hubot Sans

[Hubot Sans](https://github.com/github/hubot-sans) 灵感来自 Mona 的机器人伙伴，更多的几何元素赋予了技术和独特的感觉，非常适合标题、引语等。同样的，Hubot Sans 是一种可变字体。

#### Monaspace

GitHub 日前推出了名为 [Monaspace](https://monaspace.githubnext.com) 的开源字体家族，拥有五种风格可选，分别为“Neon（现代风格字体）”、“Argon（人文风格字体）”、“Xenon（衬线风格字体）”、“Radon（手写风格字体）”、“Krypton（机械风格字体）”。

官方介绍称，这五款字体均支持调节字重，特别适合 IDE 使用，号称可以让 IDE 富有表现力，也可以作为系统字体日常使用。

### Ubuntu 系

#### Ubuntu

[Ubuntu 字体](https://design.ubuntu.com/font)具有当代风格，包含了 Ubuntu 品牌独有的特征，传达了一种精确、可靠和自由的态度。

#### Ubuntu Monospace

Ubuntu 的等宽体

### JetBrains Mono

[JetBrains Mono](https://www.jetbrains.com/lp/mono/) 是 JetBrains 公司专门为开发者打造的编程字体 —— 甚至有「最漂亮的编程字体」之称。

JetBrains Mono 提供了 Thin、ExtraLight、Light、Regular、Medium、SemiBold、Bold 和 ExtraBold 共 8 种字体粗细，包含英文数字字符和西文字体，支持 147 种语言，但不包含中文，默认情况下中文会显示为系统的默认中文字体。

JetBrains Mono 采用了开源字体许可证 SIL Open Font License，开源免费且可商用。

### Iosevka

[Iosevka](https://typeof.net/Iosevka) | [Github 发行版](https://github.com/be5invis/Iosevka/releases) 定制性极强，是一款现代化的编程字体集合，除了等宽、oO0 iIl1明显区分等基本特性外，还有很多非常现代的特性，比如：

多种风格：有非常多的字形可供选择，衬线/非衬线，多级字重，不同风格的斜体，甚至还有融合了其他常用编程字体设计风格的风味版本。
字形较窄：采用窄高的风格，水平上可以显示更多内容。（字体文件中同时包含窄和宽的字形，带有Extended的就是宽字形）
连体字形：跟 JetBrains Mono 一样，对很多常用的字符组合都有连体字形，美观度直线上升。
严格对齐：跟 Ubuntu Mono 一样，使用此字体时，中文字符宽度会严格等于2个英文字符宽度，强迫症福音。

我一般会选择 [PkgTTF-IosevkaFixed-32.4.0.zip](https://github.com/be5invis/Iosevka/releases/download/v32.4.0/PkgTTF-IosevkaFixed-32.4.0.zip)

### Inconsolata

[Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html) 非常漂亮的一款等宽字体。从 2006 年开始它便一直是一款开源和可免费获取的字体。它的创造者 Raph Levien 在设计 Inconsolata 时秉承的一个基本原则是：等宽字体并不应该那么糟糕。使得 Inconsolata 如此优秀的两个原因是：对于 0 和 o 这两个字符它们有很大的不同，另外它还特别地设计了标点符号。

### [0xProto](https://gitcode.com/gh_mirrors/0x/0xProto)

[GitHub Release](https://github.com/0xType/0xProto/releases) 是一款专注于源代码可读性的编程字体。确保代码清晰易读是你的职责哦！ 😉

对于编程字体来说，可识别性至关重要，尤其是每个字母之间的明显区别。保持编码的清晰有助于减少歧义，防止因错误导致软件bug。0xProto 是一款精心设计的统一字体，旨在增强类似字母间的辨识度。

软件工程师经常在文本编辑器或终端软件中使用小号字体。因此，我们调整了字体，以保证即使在较小的字号下，字符内部的空间也足够宽广，易于观察。

此外，还有名为 Texture Healing 的功能，增强了像 m 这样自然宽度较宽的字符的可读性。该功能会在 m 等字符与较窄的字符（如 i 和 l）或符号（如点、冒号和空格）相邻时，适度拓宽它们，同时保持其等宽特性。GitHub 在 'monaspace' 字体中采用了这一特性。

### Intel One Mono

英特尔面向开发者发布了一款新的开源等宽字体“Intel One Mono”，其涵盖了 200 多种使用拉丁文字的语言，提供四种粗细规格，依次为 Light（较细）、Regular（标准）、Medium（中等，比 Regular 略粗）和 Bold（粗体），默认支持斜体。

听说还是一款「护眼」字体，主打更高清晰度和可读性。英特尔称这套新字体设计摈弃常规字体设计中对统一性和「和谐度」的追求，反而更重视让每个字母都更「不同」，以此提高可读性。

这套字体由英特尔品牌团队、Frere-Jones Type 和 VMLY&R 合作开发，官方称“集清晰度、易读性和保护开发者视力于一体”。用户反馈，这套新字体阅读起来能有 11.11% 的速度提升：「这让我可以更长时间写代码而不会感到疲惫。」

[下载地址](https://github.com/intel/intel-one-mono/releases)

### [IBM Plex 字体家族](https://gitcode.com/gh_mirrors/pl/plex)

IBM Plex 是一个开源项目，遵循开放字体许可证（OFL）可供下载和多种用途。IBM Plex 字体系列包括无衬线、衬线、等宽和无衬线紧凑四种风格，均配备罗马体和真正的斜体。Plex 字体被设计得能够很好地适用于用户界面（UI）环境和其他介质。此项目提供所有源文件和多种格式，以支持大多数排版需求。目前，IBM Plex Sans 支持扩展拉丁语、阿拉伯语、繁体中文、西里尔语、梵文、希腊语、希伯来语、日语、韩语和泰语。

此外，IBM 还推出了 IBM Plex® Math。这个备受期待的版本包含了超过 5,000 个新符号，涵盖广泛的数学符号，如字母数字、双击、Fraktur、运算符、脚本、图标、箭头、希腊字母、语音学、技术性和几何形状——使其成为当今市面上最完整的数学字体之一。IBM Plex Math 提供了 STIX 和 Microsoft Cambria 字体的全新且全面的替代品。它与 IBM Plex Serif Regular 的兼容性，使其成为 IBM 研究人员和数学家的理想选择。

## 等宽中文

中文字体应该都是等宽的。
字重有小到大：
Thin、Extralight、Light、**Default**、Medium、Demibold、Bold、Extrabold、Heavy
Thin、Extralight、Light、**Normal**、Regular、Medium、Demibold、SemiBold、 Bold、Heavy
Thin、Light、**Regular**、Medium、Bold、Black

### Adobe 系

#### [思源黑体](https://github.com/adobe-fonts/source-han-sans)

开发商：Google & Adobe

思源黑体（也称作 Source Han Sans 或 Noto Sans CJK）是 Google 和 Adobe 合作打造的开源字体，采用了开源字体许可证 SIL Open Font License，免费且可商用。“思源” 二字取自于成语 “饮水思源”。

思源黑体支持简体中文、繁体中文、日文、韩文以及英文；提供了 ExtraLight、Light、Normal、Regular、Medium、Bold 和 Heavy 共 7 种字体粗细，可以满足不同场景下的文字显示需求。适合设计师、开发者，以及普通用户使用。

#### [思源宋体](https://source.typekit.com/source-han-serif/cn)

开发商：Google & Adobe

继 “思源黑体” 后，Adobe 和 Google 再度联手创造了 “思源宋体”（称作 Source Han Serif 或 Noto Serif CJK）。思源宋体也采用了开源字体许可证 SIL Open Font License，免费且可商用。

思源宋体同样包含简繁中文以及日韩四种汉字写法和 ExtraLight、Light、Regular，Medium、SemiBold、Bold 和 Black 七种粗细字重，每种粗细字重分别收录了 65535 个字形，七种字重共收录高达 458745 个字形，可以满足不同的设计需求。

### 霞鹜文楷 (LXGW WenKai)

[霞鹜文楷](https://github.com/lxgw/LxgwWenKai)是一款开源中文字体，名字取自于王勃的《滕王阁序》——“落霞与孤鹜齐飞，秋水共长天一色”。衍生自开源字体 Klee One，后者是一款日文的教科书字体，由日本著名字体厂商 FONTWORKS 打造，兼有仿宋和楷体的特点。霞鹜文楷基于 Klee One 补全了简繁常用字。

### 霞鹜新晰黑

霞鹜新晰黑：为清晰而生的免费商用黑体字库 基于IPAex黑体优化-[猫啃网](https://www.maoken.com/freefonts/8999.html)

### [OPPO Sans](https://www.coloros.com/article/A00000074)

### [MiSans](https://hyperos.mi.com/font/zh/download)

### [HarmonyOS 字体](https://developer.huawei.com/consumer/cn/doc/design-guides-V1/font-0000001157868583-V1)

### [荣耀 HONOR 字体](https://developer.honor.com/cn/doc/guides/100813)

## 特殊系列

### 中英文 2:1 等宽

字体融合了中英文

#### Maple Mono

[GitHub - subframe7536/maple-font](https://github.com/subframe7536/maple-font): [Try V7!] Maple Mono: Open source monospace font with round corner, ligatures and Nerd-Font for IDE and command line. 带连字和控制台图标的圆角等宽字体，中英文宽度完美2:1

#### Sarasa-Gothic

（国产）等距更纱黑体 Sarasa Mono SC 1.0.27

#### 星汉等宽

（国产）星汉等宽 Milky Han Mono CN

#### 谷歌 Noto Sans Mono

比如 谷歌 无衬线等宽简体中文 Noto Sans Mono CJK SC 2.004 是一款不错的选择。

#### 微软 Cascadia Next SC

Cascadia 字体系列的下一个演变，Cascadia Next。我们才华横溢的排版师为 SC（简体中文）、TC（繁体中文）和 JP（日语）创建了 Cascadia Next 的三种变体。
此预发布版包含有限的字符集，涵盖了这些语言的绝大多数使用案例。简体中文：ASCII、GB2312 扩展

[releases-cascadia-next](https://github.com/microsoft/cascadia-code/releases/tag/cascadia-next)

### Nerd Fonts 系列

[Nerd Fonts](https://www.nerdfonts.com) - Iconic font aggregator, glyphs/icons collection, & fonts patcher

也可直接进入 [Nerd Fonts 下载频道](https://www.nerdfonts.com/font-downloads)下载

#### MesloLG Nerd Font

基于苹果的 Menlo 改造的且加上了 nerd font。

[下载](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip)

#### Monaspice Nerd Font

[下载](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip) | [preview](https://www.programmingfonts.org/#monaspace-neon)

#### FireCode Nerd Font

[下载](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip)

## 教程

### 如何引用谷歌字体库

Google 中国提供的 Google Fonts 国内镜像
使用 fonts.googleapis.cn 替换 fonts.googleapis.com
使用 fonts.gstatic.cn 替换 fonts.gstatic.com

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
    <style>
		@import url('https://fonts.font.im/css?family=Ubuntu+Mono');
		
        body {
            font-family: 'Ubuntu Mono', sans-serif;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Mist Hello World</h1>
</body>
</html>
```

## 一些字体网站

* [Fontsource](https://fontsource.org)
* [Free Fonts!](https://www.fontsquirrel.com) Legit Free & Quality » Font Squirrel
* [猫啃网](https://www.maoken.com) 免费商用字体，广州市海锋网络科技有限公司

## VS code 字体我的预设配置

"editor.fontFamily": "'SF Pro Text', 'HarmonyOS Sans SC Medium'"
苹果电脑 "editor.fontFamily": "MonaspiceNe Nerd Font, PingFang SC, Menlo, monospace"

## 总结

微软终端 -`MonaspiceNe Nerd Font`
