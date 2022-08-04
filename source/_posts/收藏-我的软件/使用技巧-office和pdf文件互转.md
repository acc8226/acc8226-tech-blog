---
title: 使用技巧-office和pdf文件互转
categories: 收藏-我的软件
---

## word 转 pdf

### 在线版

网页工具：Word 转换为 PDF 文件。DOC文件转换为 PDF 文件
<https://www.ilovepdf.com/zh-cn/word_to_pdf>

### 离线版

【优先】PDF24 Tools: 免费且易于使用的在线PDF工具
<https://tools.pdf24.org/zh/>

【备用】office 和 wps 可直接导出 pdf，如果想批量导出 pdf，可尝试万彩办公大师-文件转换工具。
<http://www.wofficebox.com/>

注：其余无论国产/国外软件转 pdf 软件大多是付费服务，要不免费版有水印，要不就是前几页免费，极度不推荐。

## pdf 转 word

1. 使用上面提到的万彩-PDF 批量转 Office 工具就可以。

## markdown 转 html

1. 编辑器导出，例如使用 typora。
2. 借助 pandoc

需要先行安装 pandoc 工具。pandoc是进行文件类型转换的**瑞士军刀**，初次接触的同学可以体验下[Pandoc Demos](http://pandoc.org/demos.html)。更多信息请查看[Pandoc User’s Guide](http://pandoc.org/README.html)。

```sh
pandoc 15-GitHub-使用总结.md  -s -c style.css  -o abc.html
```

其中，”style.css”是自定义的模板。以下仓库有更多模板供参考。

asin929/markdown-css: a collection of makrdown css.
<https://github.com/asin929/markdown-css>

## html 转 pdf

wkhtmltopdf，生成的 pdf 有目录。比直接打印网页强。
<https://wkhtmltopdf.org/index.html>

简单用法 wkhtmltopdf www.ithome.com ithome.pdf

加页脚页码 wkhtmltopdf --footer-center [page]/[topage] www.ithome.com ithome.pdf

遇到的问题：目前好像必须源文件是 http/https 的资源，不能是本地的资源。我最终选择本地启了一个服务才完成转 pdf。

## markdown 转为 word

1. 编辑器导出，例如使用 typora。该软件默认预设了多种主题，然后界面支持多语言。多级标题也能完美展示。
2. 借助 pandoc 命令行工具。 `pandoc -s MANUAL.txt -o example29.docx`

下载 pandoc 的地址 <https://github.com/jgm/pandoc/releases>

## markdown 转为 pdf

1. 编辑器导出，例如使用 typora。
2. 借助 pandoc 命令行工具，但是配置太多了，因此不推荐。
3. 迂回方案1：markdown 先转成 html, 最终再转成 pdf。
4. 迂回方案2：markdown 先转成 docx, 最终再转成 pdf。

## 关系图

![关系图](./imgs/%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7-office%E5%92%8Cpdf%E6%96%87%E4%BB%B6%E4%BA%92%E8%BD%AC/%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7-office%E5%92%8Cpdf%E6%96%87%E4%BB%B6%E4%BA%92%E8%BD%AC.png)

## 参考

Pandoc - Demos
<https://pandoc.org/demos.html>

wkhtmltopdf/wkhtmltopdf: Convert HTML to PDF using Webkit (QtWebKit)
<https://github.com/wkhtmltopdf/wkhtmltopdf>
