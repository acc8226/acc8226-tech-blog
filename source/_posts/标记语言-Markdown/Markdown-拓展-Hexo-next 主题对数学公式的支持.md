---
title: Markdown-拓展-Hexo-next 主题对数学公式的支持
categories: 标记语言-Markdown
tags:
- Markdown
---

由于静态网站的某些功能有限，所以我们需要第三方服务来扩展我们的网站。在任何时候，你都可以使用 NexT 支持的第三方服务来扩展所需的功能。

Next 提供了两个渲染引擎来显示数学方程: MathJax 和 KaTeX。

要使用这个特性，您只需要选择一个渲染引擎并打开它的 `enable`(位于`heme config file`)。 然后你需要安装相应的 Hexo 渲染器来完全支持数学方程式的显示-只开启启用可能不会让你正确地看到显示的方程式。 相应的 Hexo 渲染引擎将提供如下。

## Settings 设置

```yml
# Math Formulas Render Support
math:
  # Default (false) will load mathjax / katex script on demand.
  # That is it only render those page which has `mathjax: true` in front-matter.
  # If you set it to true, it will load mathjax / katex srcipt EVERY PAGE.
  every_page: false

  mathjax:
    enable: true
    # Available values: none | ams | all
    tags: none

  katex:
    enable: false
    # See: https://github.com/KaTeX/KaTeX/tree/master/contrib/copy-tex
    copy_tex: false
```

`per_page` 是控制是否每页呈现数学方程式。

* true → Equations will be processed on 每一页. Even if they not exists on one or another page。
* false → 它只会渲染那些含有 `mathjax: true` 的文章。

注意：如果启用的是 katex 则不用关心此项。

```yml
<!-- This post will render the Math Equations -->
---
title: Will Render Math
mathjax: true
---
....
```

```yml
<!-- This post will NOT render the Math Equations -->
---
title: Not Render Math
mathjax: false
---
....
```

```yml
<!-- This post will NOT render the Math Equations either -->
---
title: Not Render Math Either
---
....
```

## Render Engines 渲染引擎

目前，NexT 提供了两个渲染引擎: MathJax 和 KaTeX。

### MathJax 引擎

Firstly, make sure you have [installed](http://johnmacfarlane.net/pandoc/installing.html) pandoc (version >= 2.0).

```sh
npm un hexo-renderer-marked
npm i hexo-renderer-pandoc
```

In theme config file, choose mathjax as render engine.

```yml
math:
  ...
  mathjax:
    enable: true
```

### KaTeX 引擎

与 MathJax 相比，KaTeX 引擎是一个更快的数学渲染引擎，而且没有 JavaScript 它也能生存。

注意：目前在NexT 主题中 KaTeX 还不完善, 但是由于不依赖 pandoc 还是挺方便的。

1\. 需要卸载原始渲染器 hexo-renderer

```sh
npm un hexo-renderer-marked
```

2\. 如果你使用 KaTeX 渲染数学公式，你需要安装渲染器选中的一个:

```sh
npm i hexo-renderer-markdown-it-plus # or hexo-renderer-markdown-it
```

3\. 在主题配置文件中，选择 katex 作为渲染引擎。

```yml
math:
  ...
  katex:
    enable: true
```

4\. 运行标准 Hexo 生成、部署进程或启动服务器:

```sh
hexo clean && hexo g -d
# or hexo clean && hexo s
```

## Plugins 插件

Next 还集成了一些 MathJax 和 KaTeX 的插件，可以通过设置 CDN url 轻松配置它们。

Mhchem 是 MathJax 的第三方扩展，是一个可以轻松写出漂亮的化学方程式的工具。[MathJax/mhchem Manual](https://mhchem.github.io/MathJax-mhchem/).

Katex 的 Copy-tex 扩展修改了任何支持剪贴板 API 的浏览器中的复制 / 粘贴行为，这样，当选择和复制整个 KaTeX 渲染的元素时，结果剪贴板的文本内容将呈现 KaTeX 元素作为其 LaTeX 源，并由指定的分隔符包围。 更多信息:  [Copy-tex extension](https://github.com/KaTeX/KaTeX/tree/master/contrib/copy-tex).

注意:

1. Displayed Math `(i.e. $$...$$)` 需要以新行开始, 换言之before the opening `$$` and after the ending `$$`不能出现任何非空白字符
2. 不支持 Unicode 编码
3. Inline Math (..`$...$`) 不能包含空格 **after the opening `$` and before the ending `$`** ([comment #32](https://github.com/theme-next/hexo-theme-next/pull/32#issuecomment-357489509)).
4. Heading中使用 math, 在使用 toc 时候会出现三次, 因此 head 中不建议使用 math
5. 如果你在你的 post's title 中使用 math，它不会被渲染

## Examples 例子

### 在 MathJax 中对方程进行编号和引用

在 NexT 的新版本中，我们增加了自动等式编号的功能，以便有机会参考该等式。 下面我们将简要描述如何使用这个特性。

一般来说，要使自动方程式编号工作，您必须将 LaTeX 方程式包装在方程式环境中。 使用简单的老式方法(例如，用两个美元符号包装一个方程式)是行不通的。 如何引用一个等式？ 只需给出一个 label {}标记，然后在后面的文本中，使用 ref {}或 eqref {}来引用它。 使用 eqref {}是首选的，因为如果您使用 ref {} ，则方程数周围没有括号。 下面是方程式编号的一些常见场景。

### 简单方程式

```math
$$\begin{equation}
e=mc^2
\end{equation}$$
```

$$\begin{equation}
e=mc^2
\end{equation}$$

### Multi-line Equation 多行方程

对于多行方程，在方程式环境中，您可以使用`aligned`将其分割为多行:

```md
$$\begin{equation}
\begin{aligned}
a &= b + c \\
  &= d + e + f + g \\
  &= h + i
\end{aligned}
\end{equation}$$
```

$$
\begin{equation}
\begin{aligned}
a &= b + c \\
  &= d + e + f + g \\
  &= h + i
\end{aligned}
\end{equation}
$$

多重对齐方程
我们可以用 `align` 来排列多个方程，每个方程都有自己的数字。

```tex
$$\begin{align}
a &= b + c \label{eq3} \\
x &= yz \label{eq4}\\
l &= m - n \label{eq5}
\end{align}$$
```

$$\begin{align}
a &= b + c \label{eq3} \\
x &= yz \label{eq4}\\
l &= m - n \label{eq5}
\end{align}$$

## 额外： MarkDown 彩色字体语法

统一表示方法：`\color{颜色}{文本}`

```tex
# *附 上面那种 - MarkDown 彩色字体语法：
$\color{black}{黑色(\text{black})}$
$\color{red}{红色(\text{red})}$
$\color{blue}{蓝色(\text{blue})}$

$\color{grey}{灰色}$
$\color{purple}{紫色}$
$\color{olive}{橄榄绿}$
$\color{teal}{蓝绿色}$
$\color{silver}{银色}$
$\color{lime}{浅绿色}$
$\color{navy}{藏青色}$
```

$\color{black}{黑色(\text{black})}$
$\color{red}{红色(\text{red})}$
$\color{blue}{蓝色(\text{blue})}$

$\color{grey}{灰色}$
$\color{purple}{紫色}$
$\color{olive}{橄榄绿}$
$\color{teal}{蓝绿色}$
$\color{silver}{银色}$
$\color{lime}{浅绿色}$
$\color{navy}{藏青色}$

## 字体特效设置

```tex
$\bf{加粗}$
$\underline{下划线}$
$\enclose{horizontalstrike}{删除线}	$
$\enclose{verticalstrike}{删\\除\\线}	$
$\enclose{updiagonalstrike}{删除线}	$
$\enclose{downdiagonalstrike}{删除线}	$
$\enclose{updiagonalstrike,downdiagonalstrike}{删除线}	$
$\enclose{horizontalstrike,verticalstrike}{\;\ 删\\删除线\\\;\ 线}	$
$\enclose{updiagonalstrike,downdiagonalstrike,horizontalstrike,verticalstrike}{删除线}$
```

$\bf{加粗}$
$\underline{下划线}$
$\enclose{horizontalstrike}{删除线}	$
$\enclose{verticalstrike}{删\\除\\线}	$
$\enclose{updiagonalstrike}{删除线}	$
$\enclose{downdiagonalstrike}{删除线}	$
$\enclose{updiagonalstrike,downdiagonalstrike}{删除线}	$
$\enclose{horizontalstrike,verticalstrike}{\;\ 删\\删除线\\\;\ 线}	$
$\enclose{updiagonalstrike,downdiagonalstrike,horizontalstrike,verticalstrike}{删除线}$

> 补充：删除线可以多种形式搭配使用

## 额外：设置字号

$\Huge{小初字体(36pts)}$

$\huge{一号字体(27.5pts)}$

$\LARGE{二号字体(21pts)}$

$\Large{三号字体(15.75pts)}$

$\large{四号字体(13.75pts)}$

$\normalsize{小四字体(12pts)}$

$默认字体(12pts)$

$\small{五号字体(10.5pts)}$

$\scriptsize{六号字体(7.875pts)}$

$\tiny{七号字体(5.25pts)}$

## 遇到过的问题

问：Hexo Next主题配置Mathjax遇到的问题：pandoc exited with code null

答：使用 pandoc 还需要在本地安装，在官网上下载pandoc，直接安装即可。

## 参考

next 主题官网
<https://theme-next.org/>

 theme NexT
<https://github.com/next-theme/hexo-theme-next>
