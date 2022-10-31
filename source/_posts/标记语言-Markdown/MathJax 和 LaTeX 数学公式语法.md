---
title: Markdown-MathJax 和 LaTeX 数学公式语法
date: 2020-05-03 14:17:04
updated: 2022-10-6 20:35:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## MathJax 和 LaTeX 数学公式 支持

[MathJax](https://www.mathjax.org/) 是一款运行在浏览器中的开源数学符号渲染引擎，使用 MathJax 可以方便的在浏览器中显示数学公式，不需要使用图片。目前，MathJax 可以解析 **Latex**、**MathML** 和 **ASCIIMathML** 的标记语言。MathJax 项目于 2009 年开始，发起人有 American Mathematical Society, Design Science 等，还有众多的支持者，个人感觉 MathJax 会成为今后数学符号渲染引擎中的主流，也许现在已经是了。本文接下来会讲述 MathJax 的基础用法，但不涉及MathJax 的安装及配置。

另外这里有个 LaTeX 教程，图文并茂, 强烈建议参考收藏。它和 MathJax 有差异，但是很多语法可以通用。

You can render LaTeX mathematical expressions using [KaTeX](https://khan.github.io/KaTeX/)

## 实例

特殊字符

圆周率 $\pi$

```math
\pi
```

加减乘除  $\times \div \pm \mp$

```math
\times \div \pm \mp
```

上下标 $x_i^2$

```math
这两种方法都可以
x_i^2

x^2_i
```

只有上标的情况 $x^{10}$

```math
x^{10}
```

<!-- more -->

括号

1. 小括号与方括号：使用原始的()，[]即可
2. 大括号：由于大括号 {} 被用来分组，因此需要使用\{和\}这种转义方法表示，也可以使用 \lbrace 和 \rbrace 来表示。如

```math
\{a*b\}
```

$$\{a*b\}$$

```math
\pi
```

$$\pi$$

```math
\lbrace a*b \rbrace
```

$$\lbrace a*b \rbrace$$

**求和与积分**
\sum 用来表示求和符号，其下标表示求和下限，上标表示上限。如

```math
\sum_1^n
```

$$\sum_1^n$$

\int 用来表示积分符号，同样地，其上下标表示积分的上下限。如

```math
\int_1^\infty
```

$$\int_1^\infty$$

分式
第一种，使用 \frac ab , \frac作用于其后的两个组 a , b，结果为 𝑎𝑏。如果你的分子或分母不是单个字符，请使用{...}来分组。

```math
\frac ab
```

$$\frac ab$$

```math
\frac a{x+1}
```

$$\frac a{x+1}$$

第二种，使用 \over 来分隔一个组的前后两部分，如 {a+1 \over b+1}

```math
{a+1 \over b+1}
```

$${a+1 \over b+1}$$

根式
根式使用\sqrt表示

```math
\sqrt 5
```

$$\sqrt 5$$

```math
\sqrt[3] {x \over y}
```

$$\sqrt[3] {x \over y}$$

小于大于等号

```math
\lt \gt \le \ge \neq
```

$$\lt \gt \le \ge \neq$$

```math
\not\lt \not\gt \not\le \not\ge
```

$$\not\lt \not\gt \not\le \not\ge$$

排列

```math
\binom{n+1}{2k}
```

$$\sqrt[3] {x \over y}$$

或者

```math
{n+1 \choose 2k}
```

$${n+1 \choose 2k}$$

```math
x = {-b \pm \sqrt{b^2-4ac} \over 2a}
```

$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$

数列
 \ldots与\cdots，其区别是 dots 的位置不同，ldots 位置稍低，cdots 位置居中。

```math
a_1 + a_2 + \cdots
```

$$a_1 + a_2 + \cdots$$

```math
a_1,\,a_2, \ldots, a_n
```

$$a_1,\,a_2, \ldots, a_n$$

**矩阵**
使用‘三个点’

```text
\begin{matrix}...\end{matrix}
```

$$\begin{matrix}...\end{matrix}$$来表示矩阵，在\begin与\end之间加入矩阵的元素即可。矩阵的行之间用\\分隔，列之间用&分隔。

```math
\begin{matrix} 1 & x & x^2 \\ 1 & y & y^2 \\ 1 & z & z^2 \end{matrix}
```

$$\begin{matrix} 1 & x & x^2 \\ 1 & y & y^2 \\ 1 & z & z^2 \end{matrix}$$

加括号
如果要对矩阵加括号，可以使用特殊的matrix，即替换 \begin{matrix}...\end{matrix}中的matrix 为 pmatrix , bmatrix , Bmatrix , vmatrix , Vmatrix.

省略元素
可以使用\cdots ⋯ \ddots ⋱ \vdots ⋮ 来省略矩阵中的元素，如：

## 一些参考

```math
\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}
```

$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$

```math
\Gamma(z) = \int_0^\infty t^{z-1}e^{-t}dt\,.
```

$$\Gamma(z) = \int_0^\infty t^{z-1}e^{-t}dt\,.$$

## 支持 LaTeX 数学公式的 markdown 工具

StackEdit 支持`$$...$$`写法
印象笔记 支持` ```math `写法
有道云笔记 支持`$$...$$`写法 和 ` ```math `写法
简书, 支持`$...$`行内式写法和 `$$...$$`独占整行写法

## 总结

不能记住所有的命令, 记得经常翻看
<https://khan.github.io/KaTeX/docs/supported.html>

**空格的使用**
`\,` 或者 `\thinspace` ³∕₁₈ em 空格, 最常用的一种空格形式
`\enspace` ½ em 空格
`\quad` 1 em 空格

## 颜色支持

指定字体的方式很简单,我们只需要在数学公式中以`{\字体{Samplety}}` 的形式使用上述字体标记,就可以将 "Sample" 这几个字符设置为指定字体了。

除此之外,在必要情况下,我们还可以使用\color标记来指定这些字体的颜色,该标记的第一个参数为颜色的名称,第二个参数是被指定颜色的字符,譬如 `$\color{black}{Sample}$`

花体
$\cal{Sample}$
旧德式字体
$\frak{Sample}$

```text
花体
$\cal{Sample}$
旧德式字体
$\frak{Sample}$
```

$\color{black}{Sample}$
$\color{red}{Sample}$
$\color{olive}{Sample}$
$\color{purple}{Sample}$
$\color{blue}{Sample}$
$\color{lime}{Sample}$

```text
$\color{black}{Sample}$
$\color{red}{Sample}$
$\color{olive}{Sample}$
$\color{purple}{Sample}$
$\color{blue}{Sample}$
$\color{lime}{Sample}$
```

## 参考

Mathjax 与 LaTex 公式简介 - 林大勇 - 博客园
<https://www.cnblogs.com/linxd/p/4955530.html>

MathJax basic tutorial and quick reference - Mathematics Meta Stack Exchange
<https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference/5044>

Supported Functions · KaTeX
<https://khan.github.io/KaTeX/docs/supported.html>

Markdown 写作指南-异步社区-致力于优质IT知识的出版和分享
<https://www.epubit.com/columnDetails?id=CL6c695f34d7aec>
