## 发布线上电子书

目前 npm gitbook 项目已不再更新，请使用  [GitBook.com / GitHub integration](https://docs.gitbook.com/integrations/github)。

> As the efforts of the GitBook team are focused on the [GitBook.com](https://www.gitbook.com/) platform, the CLI is no longer under active development.
All content supported by the CLI are mostly supported by our [GitBook.com / GitHub integration](https://docs.gitbook.com/integrations/github).
Content hosted on the [legacy.gitbook.com](https://legacy.gitbook.com/) will continue working until further notice. For differences with the new vesion, check out our [documentation](https://docs.gitbook.com/v2-changes/important-differences).

## 导出为 word 文件

前提条件：下载 Releases · jgm/pandoc https://github.com/jgm/pandoc/releases。或者使用 typora。

**不带模板的导出 word**
```
pandoc abc.md -o abc1.docx
```

**导出 word 且使用 reference docx**
```
pandoc --reference-doc myColumns.docx -o abc2.docx abc.md
```
官网介绍 abc.md 改成 xxx 也是可以的。所以说这个没有限制。只要源文件存在。

## 导出为 pdf 文件

对 windows 环境而言，光使用 pandoc 还不够，还得安装插件，所以这里更建议使用 typora。

## 发布为 ppt 文件

### Marp 介绍

https://github.com/marp-team/marp/

Marp 最早是一个 GitHub 上的开源桌面软件，目前已经迭代成为一个多项目库的集合，包括 JavaScript 框架、命令行接口、代码编辑器插件等等。

对于普通用户而言，现阶段使用 Marp 的最好方式就是通过其发布的 VS Code 插件，通过它，我们可以让使用 Markdown 写 PPT 这件事的体验接近原生 App，上手简单，最后却能输出样式丰富的幻灯片（比如官方的 [这个例子](https://yhatt-marp-cli-example.netlify.com/#1)）。

Marp for VS Code - Visual Studio Marketplace
https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode

目前支持的导出格式
![](https://upload-images.jianshu.io/upload_images/1662509-cbca5f2d9bb40d76.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Reveal.js 介绍

> Reveal.js 是一个使用 HTML 语言制作演示文稿的 Web 框架，支持插入多种格式的内容，并以类似 PPT 的形式呈现。在英文中，「reveal」有「启示」的意思，我觉得这一释义恰到体现了演示文稿的本质。

Reveal.js 支持 Markdown 语法，我们得以直接在 Markdown 编辑器里做 PPT。你用 Markdown 语法所实现的精美、简洁的版式，在 Reveal.js 里仍能沿用。

The HTML presentation framework | reveal.js
https://revealjs.com/

hakimel/reveal.js: The HTML Presentation Framework
https://github.com/hakimel/reveal.js

## 推荐客户端工具

typora 可以无脑导出，值得推荐！

## 参考

Reveal.js：把你的 Markdown 文稿变成 PPT - 少数派
https://sspai.com/post/40657

Marp：用 Markdown「写」PPT 的新选择 - 少数派
https://sspai.com/post/55718
