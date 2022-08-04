---
title: Markdown-替代品-Asciidoc-介绍
categories: 标记语言-Markdown
tags:
- Markdown
---

AsciiDoc，它的设计初衷就是为了解决写书规模的问题，并且是 O’Reilly 的在线出版平台 [Atlas](http://chimera.labs.oreilly.com/) 的推荐语言。经过一番学习，我觉得 Asciidoc 确实很适合电子书制作。

> 是一个用于编写纯文本笔记、文章、文档、书籍、网页、幻灯片和手册页的轻量级标记语言。 本指南是常见的 ascii doc 文档和文本格式化标记的快速参考。

AsciiDoc 相比 Markdown 支持更多的格式，包括而不限于：

* 文档属性，设置作者、版本信息等。
* 语法高亮。
* 表格。
* Include 功能，将大文档拆分几个文件。
* 自定义块语法，可扩展性。

Markdown 通过自行扩展语法或者使用 HTML 可以实现这些格式，但前者造成文档不通用的问题，后者则直接把展示结构硬编码到了文档中，将来修改会很麻烦。

当然， 更多的特性带来更多的学习成本，对于博客等简单文档，这些特性并不是必须的，但对于电子书等大型文档，标准内提供丰富的特性就很有必要，否则就需要自己实现不成熟、不兼容的扩展。

## AsciiDoctor

[AsciiDoctor](http://asciidoctor.org/) 是 AsciiDoc 的 Ruby 实现，也是一个工具链，实现了 AsciiDoc 对 HTML5/DocBook/EPUB/PDF/MOBI 的转换（有的需要借助第三方工具例如 Kindlegen）。相比原版 Python 实现，AsciiDoctor 作了以下改进：

* 添加模板引擎，可以用 Ruby 的模板语言（例如 erb）自定义输出格式。
* 处理过程分成解析和生成两步，在解析之后文档转化为 Ruby 对象，可供编程处理。
* 性能和安全性提升。
* 通过 JRuby 提供 Java 版本；通过转编译提供 JavaScript 版本。

AsciiDoctor 是一个很宏伟的项目，还有很多子项目在开发中，例如我比较关注的 Asciidoctor PDF 和 Asciidoctor EPUB3，这两个项目用于去掉现有工具链中对 DocBook 的依赖，由原文档直译目标文档。工具链层次的减少可以增加定制便利性，也更方便用户安装。

示例一:
<https://raw.githubusercontent.com/asciidoctor/asciidoctor/master/README-zh_CN.adoc>

```adoc
= Asciidoctor
Dan Allen <https://github.com/mojavelinux[@mojavelinux]>; Sarah White <https://github.com/graphitefriction[@graphitefriction]>; Ryan Waldron <https://github.com/erebor[@erebor]>
// settings:
:page-layout: base
:idprefix:
:idseparator: -
:source-language: ruby
:language: {source-language}
ifndef::env-github[:icons: font]
ifdef::env-github[]
:status:
:outfilesuffix: .adoc
:caution-caption: :fire:
:important-caption: :exclamation:
:note-caption: :paperclip:
:tip-caption: :bulb:
:warning-caption: :warning:
endif::[]
// Variables:
:release-version: 2.0.10
// URIs:
:uri-org: https://github.com/asciidoctor
:uri-repo: {uri-org}/asciidoctor
:uri-asciidoctorj: {uri-org}/asciidoctorj
:uri-asciidoctorjs: {uri-org}/asciidoctor.js
:uri-project: https://asciidoctor.org
ifdef::env-site[:uri-project: link:]
:uri-docs: {uri-project}/docs
:uri-news: {uri-project}/news
:uri-manpage: {uri-project}/man/asciidoctor
:uri-issues: {uri-repo}/issues
:uri-contributors: {uri-repo}/graphs/contributors
:uri-rel-file-base: link:
:uri-rel-tree-base: link:
ifdef::env-site[]
:uri-rel-file-base: {uri-repo}/blob/master/
:uri-rel-tree-base: {uri-repo}/tree/master/
endif::[]
:uri-changelog: {uri-rel-file-base}CHANGELOG.adoc
:uri-contribute: {uri-rel-file-base}CONTRIBUTING.adoc
:uri-license: {uri-rel-file-base}LICENSE
:uri-tests: {uri-rel-tree-base}test
:uri-discuss: https://discuss.asciidoctor.org
:uri-irc: irc://irc.freenode.org/#asciidoctor
:uri-rubygem: https://rubygems.org/gems/asciidoctor
:uri-what-is-asciidoc: {uri-docs}/what-is-asciidoc
:uri-user-manual: {uri-docs}/user-manual
:uri-install-docker: https://github.com/asciidoctor/docker-asciidoctor
//:uri-install-doc: {uri-docs}/install-toolchain
:uri-install-osx-doc: {uri-docs}/install-asciidoctor-macosx
:uri-render-doc: {uri-docs}/render-documents
:uri-themes-doc: {uri-docs}/produce-custom-themes-using-asciidoctor-stylesheet-factory
:uri-gitscm-repo: https://github.com/git/git-scm.com
:uri-prototype: {uri-gitscm-repo}/commits/master/lib/asciidoc.rb
:uri-freesoftware: https://www.gnu.org/philosophy/free-sw.html
:uri-foundation: https://foundation.zurb.com
:uri-tilt: https://github.com/rtomayko/tilt
:uri-ruby: https://ruby-lang.org
// images:
:image-uri-screenshot: https://raw.githubusercontent.com/asciidoctor/asciidoctor/master/screenshot.png

{uri-project}/[Asciidoctor] 是一个 _快速_ 文本处理器和发布工具链，它可以将 {uri-what-is-asciidoc}[AsciiDoc] 文档转化成 HTML 5、 DocBook 5 以及其他格式。
Asciidoctor 由 Ruby 编写，打包成 RubyGem，然后发布到 {uri-rubygem}[RubyGems.org] 上。
这个 gem 还被包含到几个 Linux 发行版中，其中包括 Fedora、Debian 和 Ubuntu。
Asciidoctor 是开源的，link:{uri-repo}[代码托管在 GitHub]，遵从 {uri-license}[MIT] 协议。

该文档有如下语言的翻译版：

* {uri-rel-file-base}README.adoc[English]
* {uri-rel-file-base}README-fr.adoc[Français]
* {uri-rel-file-base}README-jp.adoc[日本語]

.关键文档
[.compact]
* {uri-docs}/what-is-asciidoc[Asciidoctor 是什么？]
* {uri-docs}/asciidoc-writers-guide[AsciiDoc 写作指南]
* {uri-docs}/asciidoc-syntax-quick-reference[AsciiDoc 语法快速参考]
* {uri-docs}/user-manual[Asciidoctor 用户手册]

.Ruby 所至， Asciidoctor 相随
****
使用 JRuby 让 Asciidoctor 运行在 Java 虚拟机上。
使用 {uri-asciidoctorj}[AsciidoctorJ] 直接调用 Asciidoctor 的 API 运行在 Java 或者其他 Java 虚拟机中。
基于 AsciidoctorJ 有好多插件可用，这些插件可以将 Asciidoctor 整合到 Apache Maven，Gradle 或 Javadoc 构建中。

Asciidoctor 也可以运行在 JavaScript 上。
我们可以使用 https://opalrb.com[Opal] 将 Ruby 源码编译成 JavaScript 生成 {uri-asciidoctorjs}[Asciidoctor.js] 文件，这是一个全功能版的 Asciidoctor，可以运行在任意的 JavaScript 环境中，比如 Web 浏览器 或 Node.js。
Asciidoctor.js 被用于预览 AsciiDoc，支持 Chrome 扩展，Atom，Brackets 或其他基于 Web 的工具。
****

ifdef::status[]
.*Project health*
image:https://img.shields.io/travis/asciidoctor/asciidoctor/master.svg[Build Status (Travis CI), link=https://travis-ci.org/asciidoctor/asciidoctor]
image:https://ci.appveyor.com/api/projects/status/ifplu67oxvgn6ceq/branch/master?svg=true&amp;passingText=green%20bar&amp;failingText=%23fail&amp;pendingText=building%2E%2E%2E[Build Status (AppVeyor), link=https://ci.appveyor.com/project/asciidoctor/asciidoctor]
//image:https://img.shields.io/coveralls/asciidoctor/asciidoctor/master.svg[Coverage Status, link=https://coveralls.io/r/asciidoctor/asciidoctor]
//image:https://codeclimate.com/github/asciidoctor/asciidoctor/badges/gpa.svg[Code Climate, link="https://codeclimate.com/github/asciidoctor/asciidoctor"]
image:https://inch-ci.org/github/asciidoctor/asciidoctor.svg?branch=master[Inline docs, link="https://inch-ci.org/github/asciidoctor/asciidoctor"]
endif::[]

[#the-big-picture]
== 整体概况

Asciidoctor 以纯文本格式读取内容，见下图左边的面板，并将它转换成 HTML 5 呈现在右侧面板中。
Asciidoctor 将默认的样式表应用到 HTML 5 文档上，提供一个愉快的开箱即用的体验。

image::{image-uri-screenshot}[AsciiDoc 源文预览和相应的 HTML 渲染]

[#asciidoc-processing]
== AsciiDoc Processing

Asciidoctor 会读取并处理用 AsciiDoc 语法写的文件，然后将解析出来的解析树参数交给内置的转化器去生成 HTML 5，DocBook 5 或帮助手册页面输出。
你可以选择使用你自己的转化器或者加载 {uri-tilt}[Tilt] - 支持通过模板来自定义输出或产生附加的格式。

NOTE: Asciidoctor是为了直接替换原 AsciiDoc Python 处理器（`asciidoc.py`）。
Asciidoctor 测试套件含有 {uri-tests}[> 1,600 测试示例] 来确保和 AsciiDoc 语法的兼容性。

除了传统的 AsciiDoc 语法，Asciidoctor 还添加额外的标记和格式设置选项，例如 font-based 图标（例如： `+icon:fire[]+`）和 UI 元素（例如： `+button:[Save]+`）。
Asciidoctor 还提供了一个基于 {uri-foundation}[Foundation] 的现代化的、响应式主题来美化 HTML 5 输出。

[#requirements]
== 要求

Asciidoctor 可以运行在 Linux，OSX (Mac) 和 Windows 系统，但需要安装下面任意一个 {uri-ruby}[Ruby] 环境去实现：

* CRuby (aka MRI) 2.3 - 2.6
* JRuby 9.1 - 9.2
* TruffleRuby (GraalVM)
* Opal (JavaScript)

我们欢迎你来帮助在这些以及其他平台测试 Asciidoctor。

请参考 <<{idprefix}contributing,Contributing>> 来了解如何参与。

[CAUTION]
====
如果在非英语的 Windows 环境，当你去调用 Asciidoctor 时，可能会碰到 `Encoding::UndefinedConversionError` 的错误提示。
为了解决这个问题，我们建议将控制台的编码更改为 UTF-8：

 chcp 65001

一旦你做了这个改变，所有的编码问题，都将迎刃而解。
如果你使用的是像 Eclipse 这样的 IDE 集成开发工具，你也需要确保他被你设置为 UTF-8 编码。
使用 UTF-8 能使 Asciidoctor 在任何地方都能正常工作。
====

[#installation]
== 安装

Asciidoctor 可以通过三种方式安装（a）`gem install` 命令；（b）Bundler打包编译；（c）流行的 Linux 发行版的包管理器

TIP: 使用 Linux 包管理器安装的好处是如果你机器在之前没有安装 Ruby 和 RubyGems 库，当你选择这种方式安装时它们会一并安装上去。
不利的是在 gem 发布之后，这类安装包并不是立即可用。
如果你需要安装最新版，你应该总是优先使用 `gem` 命令安装。

[#a-gem-install]
=== (a) gem 安装

打开一个终端输入如下命令（不含开头的 `$`）：

 $ gem install asciidoctor

如果想安装一个预览版（比如：候选发布版），请使用：

 $ gem install asciidoctor --pre

.升级
[TIP]
====
如果你安装有的是旧版本 Asciidoctor，你可以使用下面的命令来升级：

 $ gem update asciidoctor

如果使用 `gem install` 命令来安装一个新版本的 gem 来代替升级，会安装多个版本。
这种情况，你可以使用下面的 gem 命令来移除旧版本：

 $ gem cleanup asciidoctor
====

[#b-bundler]
=== (b) Bundler

. 在项目的根目录（或者当前路径），创建一个 `Gemfile` 文件；
. 在这个文件中添加 `asciidoctor` gem 如下：
+
[source,subs=attributes+]
----
source 'https://rubygems.org'
gem 'asciidoctor'
# 或者明确指明版本
# gem 'asciidoctor', '{release-version}'
----

. 保存 `Gemfile` 文件
. 打开终端，使用如下命令安装 gem：

 $ bundle

要升级 gem 的话，在 `Gemfile` 文件中，指明新版本，然后再次运行 `bundle` 即可。
*不推荐* 直接使用 `bundle update` 命令，因为它还会升级其他 gem，也许会造成不可预料的结果。

[#c-linux-package-managers]
=== (c) Linux 包管理

[#dnf-fedora-21-or-greater]
==== DNF (Fedora 21 或更高版本)

在 Fedora 21 或更高版本中安装这个 gem，可以使用 dnf。打开终端并输入如下命令：

 $ sudo dnf install -y asciidoctor

升级则使用：

 $ sudo dnf update -y asciidoctor

TIP: 如果你的 Fedora 系统配置的是自动升级包，在这种情况下，不需要你亲自动手升级。

[#apt-get-debian-ubuntu-mint]
==== apt-get (Debian, Ubuntu, Mint)

在 Debian，Ubuntu 或 Mint 中安装这个 gem，请打开终端并输入如下命令：

 $ sudo apt-get install -y asciidoctor

升级则使用：

 $ sudo apt-get upgrade -y asciidoctor

TIP: 如果你的 Debian 或 Ubuntu 系统配置的是自动升级包，在这种情况下，不需要你亲自动手升级。

使用包管理器（ apt-get ）安装的 Asciidoctor 的版本也许不是最新发布版。
请查看发行版的包库，来确定每个发行版是打包的哪个版本。

* https://packages.debian.org/search?keywords=asciidoctor&searchon=names&exact=1&suite=all&section=all[Debian 发行版中的 asciidoctor]
* https://packages.ubuntu.com/search?keywords=asciidoctor&searchon=names&exact=1&suite=all&section=all[Ubuntu 发行版中的 asciidoctor]
* https://community.linuxmint.com/software/view/asciidoctor[Mint 发行版中的 asciidoctor]

[CAUTION]
====
我们建议不要使用 `gem update` 来升级包管理的 gem。
这样做会使系统进入不一致的状态，包管理工具将不再跟踪相关文件（通常安装在 /usr/local 下。）
简单地说，系统的 gem 只能由包管理器进行管理。

如果你想使用一个比包管理器安装的更新版本的 Asciidoctor，你应该使用 https://rvm.io[RVM] 在你的用户家目录（比如：用户空间）下安装 Ruby。
然后，你就可以放心地使用 `gem` 命令来安装或者更新 Asciidoctor gem。
当使用 RVM 时，gem 将被安装到与系统隔离的位置。
====

[#apk-alpine-linux]
==== apk (Alpine Linux)

在 Alpine Linux 中安装这个 gem，请打开终端并输入如下命令：

 $ sudo apk add asciidoctor

升级则使用：

 $ sudo apk add -u asciidoctor

TIP: 如果你的 Alpine Linux 系统配置的是自动升级包，在这种情况下，不需要你亲自动手升级。

[#other-installation-options]
=== 其他安装选项

* {uri-install-docker}[使用 Docker 安装 Asciidoctor ]
* {uri-install-osx-doc}[在 Mac OS X 安装 Asciidoctor ]

[#usage]
== 使用

如果成功安装 Asciidoctor，则在可执行程序路径中，`asciidoctor` 就可用了。
为了验证它的可用性，你可以在终端中执行如下命令：

 $ asciidoctor --version

你应该看到关于 Asciidoctor 和 Ruby 环境信息将打印到你的终端上。

[.output,subs=attributes+]
....
Asciidoctor {release-version} [https://asciidoctor.org]
Runtime Environment (ruby 2.4.1p111 [x86_64-linux]) (lc:UTF-8 fs:UTF-8 in:- ex:UTF-8)
....

Asciidoctor 还提供了一套 API。
这套 API 是为了整合其他的 Ruby 软件，例如 Rails、Sinatra、GitHub，甚至其他语言，比如 Java （通过 {uri-asciidoctorj}[AsciidoctorJ]） 和 JavaScript （通过 {uri-asciidoctorjs}[Asciidoctor.js]）。

[#command-line-interface-cli]
=== 命令行（CLI）

`asciidoctor` 命令可以让你通过命令行（比如：终端）来调用 Asciidoctor。

下面的命令将 README.adoc 文件转化为 HTML，并且保存到同一目录下的 README.html 文件中。
生成的 HTML 文件名源自源文件名，只是将其扩展名改为了 `.html`。

 $ asciidoctor README.adoc

您可以通过添加各种标志和开关控制 Asciidoctor 处理器，通过下面的命令你可以学习它的更多用法：

 $ asciidoctor --help

比如，将文件写入到不同路径里，使用如下命令：

 $ asciidoctor -D output README.adoc

`asciidoctor` {uri-manpage}[帮助页面] 提供了这个命令的完整参考。

点击下面的资源，学习更多关于 `asciidoctor` 命令的用法。

* {uri-render-doc}[如何转化文档？]
* {uri-themes-doc}[如何使用 Asciidoctor 样式工厂来创建自定义主题？]

[#ruby-api]
=== Ruby API

为了在你应用中使用 Asciidoctor，首先需要引入这个 gem：

[source]
require 'asciidoctor'

然后，你可以通过下面的代码将 AsciiDoc 源文件转化成一个 HTML 文件：

[source]
Asciidoctor.convert_file 'README.adoc', to_file: true, safe: :safe

WARNING: 当你通过 API 使用 Asciidoctor 时，默认的安全模式是 `:secure`。
在 secure 模式下，很多核心特性将不可用，包括 `include` 特性。
如果你想启用这些特性，你需要明确设置安全模式为 `:server` （推荐）或 `:safe`。

你也可以将 AsciiDoc 字符串转化我内嵌的 HTML （为了插入到一个 HTML 页面），用法如下：

[source]
----
content = '_Zen_ in the art of writing https://asciidoctor.org[AsciiDoc].'
Asciidoctor.convert content, safe: :safe
----

如果你想得到完整的 HTML 文档，只需要启用 `header_footer` 选项即可。如下：

[source]
----
content = '_Zen_ in the art of writing https://asciidoctor.org[AsciiDoc].'
html = Asciidoctor.convert content, header_footer: true, safe: :safe
----

如果你想访问已经处理过的文档，可以将转化过程拆分成离散的几步：

[source]
----
content = '_Zen_ in the art of writing https://asciidoctor.org[AsciiDoc].'
document = Asciidoctor.load content, header_footer: true, safe: :safe
puts document.doctitle
html = document.convert
----

请注意：如果你不喜欢 Asciidoctor 输出结果，_你完全可以改变它。_
Asciidoctor 支持自定义转化器，它可以操作从待处理文件到生成文档整个环节。

一个简单的、细微地自定义输出的方式是使用模板转化器。
模板转化器运行你提供一个 {uri-tilt}[Tilt] 模板，这样通过模板文件来操作转化出的文档的每个节点。

这样，你就 _可以_ 百分之百地控制你的输出。
关于更多关于 API 或自定义输出信息，请参考 {uri-user-manual}[用户帮助手册]。

[#contributing]
== 贡献

自由软件的精神鼓励 _每个人_ 来帮助改善这个项目。
如果你在源码、文档或网站内容中发现错误或漏洞，请不要犹豫，提交一个议题或者推送一个修复请求。
随时欢迎新的贡献者！

这里有几种 *你* 可以做出贡献的方式：

* 使用预发布版本（alpha, beta 或 preview）
* 报告 Bug
* 提议新功能
* 编写文档
* 编写规范
* 编写 -- _任何补丁都不小。_
** 修正错别字
** 添加评论
** 清理多余空白
** 编写测试！
* 重构代码
* 修复 {uri-issues}[issues]
* 审查补丁

{uri-contribute}[贡献指南]提供了如何提供贡献，包括如何创建、修饰和提交问题、特性、需求、代码和文档给 Asciidoctor 项目。

[#getting-help]
== 获得帮助

开发 Asciidoctor 项目是未来了帮助你更容易地书写和发布你的内容。
但是，如果没有反馈，我们将寸步难行。
我们鼓励你在讨论组、Twitter或聊天室里，提问为题，讨论项目的方方面面，

讨论组 (Nabble):: {uri-discuss}
Twitter:: https://twitter.com/search?f=tweets&q=%23asciidoctor[#asciidoctor] 来加入话题 或 https://twitter.com/asciidoctor[@asciidoctor] at并提醒我们
聊天 (Gitter):: image:https://badges.gitter.im/Join%20In.svg[Gitter, link=https://gitter.im/asciidoctor/asciidoctor]

ifdef::env-github[]
Further information and documentation about Asciidoctor can be found on the project's website.

{uri-project}/[Home] | {uri-news}[News] | {uri-docs}[Docs]
endif::[]

Asciidoctor 组织在 GitHub 托管代码、议案跟踪和相关子项目。

代码库 (git):: {uri-repo}
议案跟踪:: {uri-issues}
在 GitHub 的 Asciidoctor 组织:: {uri-org}

[#copyright-and-licensing]
== 版权和协议

Copyright (C) 2012-2020 Dan Allen, Sarah White, Ryan Waldron, and the individual contributors to Asciidoctor.
这个软件的免费使用是在MIT许可条款授予的。

请看 {uri-license}[版权声明] 文件来获取更多详细信息。

[#authors]
== 作者

*Asciidoctor* 由 https://github.com/mojavelinux[Dan Allen] 和 https://github.com/graphitefriction[Sarah White] 领导，并从 Asciidoctor 社区的 {uri-contributors}[很多其他独立开发者] 上收到了很多贡献。
项目最初由 https://github.com/erebor[Ryan Waldron] 于 2012年基于 https://github.com/nickh[Nick Hengeveld] 的 {uri-prototype}[原型] 创建。

*AsciiDoc* 由 Stuart Rackham 启动，并从 AsciiDoc 社区的其他独立开发者上收到很多贡献。

== Changelog

请看 {uri-changelog}[CHANGELOG]。
```

示例二:
<https://raw.githubusercontent.com/spring-guides/gs-gradle/master/README.adoc>

```adoc
:spring_boot_version: 1.5.10.RELEASE
:jdk: https://www.oracle.com/technetwork/java/javase/downloads/index.html
:toc:
:icons: font
:source-highlighter: prettify
:project_id: gs-gradle
This guide walks you through using Gradle to build a simple Java project.

== What you'll build

You'll create a simple app and then build it using Gradle.


== What you'll need

 - About 15 minutes
 - A favorite text editor or IDE
 - {jdk}[JDK 6] or later


include::https://raw.githubusercontent.com/spring-guides/getting-started-macros/master/how_to_complete_this_guide.adoc[]


[[scratch]]
== Set up the project

First you set up a Java project for Gradle to build. To keep the focus on Gradle, make the project as simple as possible for now.

include::https://raw.githubusercontent.com/spring-guides/getting-started-macros/master/create_directory_structure_hello.adoc[]


Within the `src/main/java/hello` directory, you can create any Java classes you want. For simplicity's sake and for consistency with the rest of this guide, Spring recommends that you create two classes: `HelloWorld.java` and `Greeter.java`.

`src/main/java/hello/HelloWorld.java`
[source,java,tabsize=2]
----
include::initial/src/main/java/hello/HelloWorld.java[]
----

`src/main/java/hello/Greeter.java`
[source,java,tabsize=2]
----
include::initial/src/main/java/hello/Greeter.java[]
----


[[initial]]
== Install Gradle

Now that you have a project that you can build with Gradle, you can install Gradle.

It's highly recommended to use an installer:

- https://sdkman.io/[SDKMAN]
- https://brew.sh[Homebrew] (brew install gradle)

As a last resort, if neither of these tools suit your needs, you can download the binaries from https://www.gradle.org/downloads. Only the binaries are required, so look for the link to gradle-_version_-bin.zip. (You can also choose gradle-_version_-all.zip to get the sources and documentation as well as the binaries.)

Unzip the file to your computer, and add the bin folder to your path.

To test the Gradle installation, run Gradle from the command-line:

----
gradle
----

If all goes well, you see a welcome message:

....
:help

Welcome to Gradle 2.3.

To run a build, run gradle <task> ...

To see a list of available tasks, run gradle tasks

To see a list of command-line options, run gradle --help

BUILD SUCCESSFUL

Total time: 2.675 secs
....

You now have Gradle installed.


== Find out what Gradle can do
Now that Gradle is installed, see what it can do. Before you even create a build.gradle file for the project, you can ask it what tasks are available:

----
gradle tasks
----

You should see a list of available tasks. Assuming you run Gradle in a folder that doesn't already have a _build.gradle_ file, you'll see some very elementary tasks such as this:

....
:tasks

== All tasks runnable from root project

== Build Setup tasks
setupBuild - Initializes a new Gradle build. [incubating]

== Help tasks
dependencies - Displays all dependencies declared in root project 'gs-gradle'.
dependencyInsight - Displays the insight into a specific dependency in root project 'gs-gradle'.
help - Displays a help message
projects - Displays the sub-projects of root project 'gs-gradle'.
properties - Displays the properties of root project 'gs-gradle'.
tasks - Displays the tasks runnable from root project 'gs-gradle'.

To see all tasks and more detail, run with --all.

BUILD SUCCESSFUL

Total time: 3.077 secs
....

Even though these tasks are available, they don't offer much value without a project build configuration. As you flesh out the `build.gradle` file, some tasks will be more useful. The list of tasks will grow as you add plugins to `build.gradle`, so you'll occasionally want to run **tasks** again to see what tasks are available.

Speaking of adding plugins, next you add a plugin that enables basic Java build functionality.


== Build Java code
Starting simple, create a very basic `build.gradle` file in the <project folder> you created at the beginning of this guide. Give it just just one line:

[source,groovy]
----
include::initial/build.gradle[]
----

This single line in the build configuration brings a significant amount of power. Run **gradle tasks** again, and you see new tasks added to the list, including tasks for building the project, creating JavaDoc, and running tests.

You'll use the **gradle build** task frequently. This task compiles, tests, and assembles the code into a JAR file. You can run it like this:

----
gradle build
----

After a few seconds, "BUILD SUCCESSFUL" indicates that the build has completed.

To see the results of the build effort, take a look in the _build_ folder. Therein you'll find several directories, including these three notable folders:

* _classes_. The project's compiled .class files.
* _reports_. Reports produced by the build (such as test reports).
* _libs_. Assembled project libraries (usually JAR and/or WAR files).

The classes folder has .class files that are generated from compiling the Java code. Specifically, you should find HelloWorld.class and Greeter.class.

At this point, the project doesn't have any library dependencies, so there's nothing in the *dependency_cache* folder.

The reports folder should contain a report of running unit tests on the project. Because the project doesn't yet have any unit tests, that report will be uninteresting.

The libs folder should contain a JAR file that is named after the project's folder. Further down, you'll see how you can specify the name of the JAR and its version.


== Declare dependencies

The simple Hello World sample is completely self-contained and does not depend on any additional libraries. Most applications, however, depend on external libraries to handle common and/or complex functionality.

For example, suppose that in addition to saying "Hello World!", you want the application to print the current date and time. You could use the date and time facilities in the native Java libraries, but you can make things more interesting by using the Joda Time libraries.

First, change HelloWorld.java to look like this:

[source,java,tabsize=2]
----
package hello;

import org.joda.time.LocalTime;

public class HelloWorld {
  public static void main(String[] args) {
    LocalTime currentTime = new LocalTime();
    System.out.println("The current local time is: " + currentTime);

    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}
----

Here `HelloWorld` uses Joda Time's `LocalTime` class to get and print the current time.

If you ran `gradle build` to build the project now, the build would fail because you have not declared Joda Time as a compile dependency in the build.

For starters, you need to add a source for 3rd party libraries.

[source,groovy]
----
include::complete/build.gradle[tag=repositories]
----

The `repositories` block indicates that the build should resolve its dependencies from the Maven Central repository. Gradle leans heavily on many conventions and facilities established by the Maven build tool, including the option of using Maven Central as a source of library dependencies.

Now that we're ready for 3rd party libraries, let's declare some.

[source,groovy]
----
include::complete/build.gradle[tag=dependencies]
----

With the `dependencies` block, you declare a single dependency for Joda Time. Specifically, you're asking for (reading right to left) version 2.2 of the joda-time library, in the joda-time group.

Another thing to note about this dependency is that it is a `compile` dependency, indicating that it should be available during compile-time (and if you were building a WAR file, included in the /WEB-INF/libs folder of the WAR). Other notable types of dependencies include:

* `providedCompile`. Required dependencies for compiling the project code, but that will be provided at runtime by a container running the code (for example, the Java Servlet API).
* `testCompile`. Dependencies used for compiling and running tests, but not required for building or running the project's runtime code.

Finally, let's specify the name for our JAR artifact.

[source,groovy]
----
include::complete/build.gradle[tag=jar]
----

The `jar` block specifies how the JAR file will be named. In this case, it will render `gs-gradle-0.1.0.jar`.

Now if you run `gradle build`, Gradle should resolve the Joda Time dependency from the Maven Central repository and the build will succeed.


== Build your project with Gradle Wrapper

The Gradle Wrapper is the preferred way of starting a Gradle build. It consists of a batch script for Windows and a shell script for OS X and Linux. These scripts allow you to run a Gradle build without requiring that Gradle be installed on your system. This used to be something added to your build file, but it's been folded into Gradle, so there is no longer any need. Instead, you simply use the following command.

----
$ gradle wrapper --gradle-version 2.13
----

After this task completes, you will notice a few new files. The two scripts are in the root of the folder, while the wrapper jar and properties files have been added to a new `gradle/wrapper` folder.

    └── <project folder>
        └── gradlew
        └── gradlew.bat
        └── gradle
            └── wrapper
                └── gradle-wrapper.jar
                └── gradle-wrapper.properties

The Gradle Wrapper is now available for building your project. Add it to your version control system, and everyone that clones your project can build it just the same. It can be used in the exact same way as an installed version of Gradle. Run the wrapper script to perform the build task, just like you did previously:

----
./gradlew build
----

The first time you run the wrapper for a specified version of Gradle, it downloads and caches the Gradle binaries for that version. The Gradle Wrapper files are designed to be committed to source control so that anyone can build the project without having to first install and configure a specific version of Gradle.

At this stage, you will have built your code. You can see the results here:

----
build
├── classes
│   └── main
│       └── hello
│           ├── Greeter.class
│           └── HelloWorld.class
├── dependency-cache
├── libs
│   └── gs-gradle-0.1.0.jar
└── tmp
    └── jar
        └── MANIFEST.MF
----

Included are the two expected class files for `Greeter` and `HelloWorld`, as well as a JAR file. Take a quick peek:

----
$ jar tvf build/libs/gs-gradle-0.1.0.jar
  0 Fri May 30 16:02:32 CDT 2014 META-INF/
 25 Fri May 30 16:02:32 CDT 2014 META-INF/MANIFEST.MF
  0 Fri May 30 16:02:32 CDT 2014 hello/
369 Fri May 30 16:02:32 CDT 2014 hello/Greeter.class
988 Fri May 30 16:02:32 CDT 2014 hello/HelloWorld.class
----

The class files are bundled up. It's important to note, that even though you declared joda-time as a dependency, the library isn't included here. And the JAR file isn't runnable either.

To make this code runnable, we can use gradle's `application` plugin. Add this to your `build.gradle` file.

----
apply plugin: 'application'

mainClassName = 'hello.HelloWorld'
----

Then you can run the app!

----
$ ./gradlew run
:compileJava UP-TO-DATE
:processResources UP-TO-DATE
:classes UP-TO-DATE
:run
The current local time is: 16:16:20.544
Hello world!

BUILD SUCCESSFUL

Total time: 3.798 secs
----

To bundle up dependencies requires more thought. For example, if we were building a WAR file, a format commonly associated with packing in 3rd party dependencies, we could use gradle's
https://www.gradle.org/docs/current/userguide/war_plugin.html[WAR plugin]. If you are using Spring Boot and want a runnable JAR file, the https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#using-boot-gradle[spring-boot-gradle-plugin] is quite handy. At this stage, gradle doesn't know enough about your system
to make a choice. But for now, this should be enough to get started using gradle.

To wrap things up for this guide, here is the completed `build.gradle` file:

`build.gradle`
[source,gradle]
----
include::complete/build.gradle[]
----

NOTE: There are many start/end comments embedded here. This makes it possible to extract bits of the build file into this guide for the detailed explanations above. You don't need
them in your production build file.

== Summary

Congratulations! You have now created a simple yet effective Gradle build file for building Java projects.

== See Also

The following guide may also be helpful:

* https://spring.io/guides/gs/maven/[Building Java Projects with Maven]

include::https://raw.githubusercontent.com/spring-guides/getting-started-macros/master/footer.adoc[]
```

## 配套软件
**[推荐]** Visual Studio Code 和配套asciidoctor-vscode插件
https://marketplace.visualstudio.com/items?itemName=joaompinto.asciidoctor-vscode

## 参考

asciidoctor 官网
<https://github.com/asciidoctor/asciidoctor>

asciidoc 官网
<http://asciidoc.org/asciidocapi.html>

AsciiDoc 简介
<https://chloerei.com/2014/10/16/asciidoc-introduction/>

asciidoctor-vscode插件的 Github 地址
<https://github.com/asciidoctor/asciidoctor-vscode>
