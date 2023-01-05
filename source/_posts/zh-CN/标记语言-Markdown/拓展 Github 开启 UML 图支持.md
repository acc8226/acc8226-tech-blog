---
title: Markdown-拓展-Gitlab-Github 开启 UML 图支持
date: 2022-04-11 12:15:06
updated: 2022-11-05 10:09:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

## 为什么需要它

一些[可视化](https://so.csdn.net/so/search?q=%E5%8F%AF%E8%A7%86%E5%8C%96&spm=1001.2101.3001.7020)工具再给我们带来直观性的同时，也增加了操作的难度，需要精细地调整组件的大小和样式，更多的时候，我们不是为了写一份漂亮的报告而画流程图，只是需要便捷地向他人分享自己的 idea，在这样的需求下，代码生成流程图显然更适合。

## 对 gitlab 的支持

You can generate diagrams and flowcharts from text by using [Mermaid](https://mermaidjs.github.io/) or [PlantUML](https://plantuml.com/). You can also use [Kroki](https://kroki.io/) to create a wide variety of diagrams.

### gitlab 配置 plantuml

plantuml/plantuml-server: PlantUML Online Server
<https://github.com/plantuml/plantuml-server>

plantuml-server 启动完成后，需要在 GitLab 上配置开启 PlantUML，管理员登录 -> Admin Area -> Settings，复选框选中 Enable PlantUML，输入 PlantUML URL（就是刚刚启动的 PlantUML Server 服务监听地址）。好了现在可以开始 PlantUML 之旅了。

### gitlab 配置 Mermaid

在 GitLab 10.3 中[引入](https://gitlab.com/gitlab-org/gitlab-foss/-/merge_requests/15107) 。您可以访问官方页面以获取更多详细信息。

### gitlab 配置 [Kroki](https://kroki.io/)

可以访问官方页面以获取更多详细信息。

## 对 github 的支持

支持时间：<https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/>

目前版本已内置，可以直接使用。

mermaid-js/mermaid: Generation of diagram and flowchart from text in a similar manner as markdown
<https://github.com/mermaid-js/mermaid>

## 对 mermaid 的详细说明

如果您不熟悉使用 Mermaid，或者需要帮助来确定 Mermaid 代码中的问题，则 [Mermaid Live Editor](https://mermaid-js.github.io/mermaid-live-editor/) 是一个有用的工具，可用于在 Mermaid 图中创建和解决问题。

Mermaid 支持软件项目中一系列不同的常见图表类型，涵盖流程图、UML、Git 图、用户体验流程图，甘特图。

To generate a diagram or flowchart, write your text inside the mermaid block:

    ```mermaid
    graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
    ```

## 对 Typora 的支持

真正实现画图功能的并不是 Typora 本身，它只是内置了对 Mermaid 的支持。Mermaid 集成功能建议去 gitlab 和 GitHub 查看帮助文档，了解更多信息。

## 总结

由于无论 gitlab 还是 GitHub 都对 Mermaid 有了良好的支持，在对比渲染流程，所以我优先考虑此方式。

## 参考文档

GitLab Flavored Markdown | GitLab
<https://docs.gitlab.com/ee/user/markdown.html#mermaid>

GitLab Markdown - 《Gitlab 中文文档》 - 书栈网 · BookStack
<https://www.bookstack.cn/read/gitlab-doc-zh/docs-408.md#mermaid>

Mermaid：如何在 Markdown 文本中添加流程图，附支持github的方法_DenryDu的博客-CSDN博客_gitlab mermaid
<https://blog.csdn.net/weixin_43661154/article/details/112101437>

Typora 通过 mermaid 使用流程图、脑图-CSDN博客_mermaid 思维导图
<https://blog.csdn.net/Alexhcf/article/details/112801877>
