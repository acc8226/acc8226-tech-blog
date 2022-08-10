---
title: Markdown-额外语法支持 GitHub Flavored Markdown
date: 2020.05.02 20:13:39
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## Syntax highlighting 语法突显

下面是一个例子，告诉你如何使用 GitHub 语法突显标记:

```js
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

您也可以简单地将代码缩进四个空格:

```js
    function fancyAlert(arg) {
      if(arg) {
        $.facebox({div:'#foo'})
      }
    }
```

## Task Lists 任务清单

```md
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

如果您在问题的第一个注释中包含了一个任务列表，那么您将在问题列表中得到一个方便的进度指示器。 它也可以在 Pull Requests 中工作！

## Tables 表格

您可以通过组合一个单词列表并用连字符`-`(对于第一行)划分它们，然后用管道 `|` 分隔每一列来创建表:

```md
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

Would become:

| First Header | Second Header |
| --- | --- |
| Content from cell 1 | Content from cell 2 |
| Content in the first column | Content in the second column |

## SHA references

任何对提交的 SHA-1 散列的引用都会自动转换为 GitHub 上提交的链接。

```text
16c999e8c71134401a78d4d46435517b2271d6ac
mojombo@16c999e8c71134401a78d4d46435517b2271d6ac
mojombo/github-flavored-markdown@16c999e8c71134401a78d4d46435517b2271d6ac
```

<!-- more -->

## Issue references within a repository

任何引用发布或拉请求的号码都将自动转换为链接。

```yml
#1
mojombo#1
mojombo/github-flavored-markdown#1
```

## Username @mentions

输入一个`@`符号，后面跟着一个用户名，会通知那个人来查看评论。 这被称为“@mention” ，因为你提到的是个人。 你也可以@提及组织中的团队。

## Automatic linking for URLs

任何 URL (如 `http://www.github.com/` 链接)都会自动转换成可点击的链接。

## Strikethrough 删除

任何带有两个波浪线的单词(比如`~~this~~`)都会被划掉。

## Emoji 表情符号

GitHub 支持表情符号 [emoji](https://help.github.com/articles/basic-writing-and-formatting-syntax/#using-emoji) !

要查看我们支持的所有图片，请查看 [Emoji Cheat Sheet](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md).

## 跳转到标题锚点

先定义一个`#标题`, 然后可以用`[abcd...](#该标题)`来定位该锚点

```md
* [1 前言](#1-前言)

## 1 前言
```

效果:
![image.png](https://upload-images.jianshu.io/upload_images/1662509-ef0a07314b60b29a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 参考

Mastering Markdown &middot; GitHub Guides
<https://guides.github.com/features/mastering-markdown/#GitHub-flavored-markdown>
