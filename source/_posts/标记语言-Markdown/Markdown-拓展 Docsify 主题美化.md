---
title: Markdown-拓展 Docsify 主题美化
date: 2021-02-23 11:00:16
updated: 2022-11-05 10:09:00
categories:
  - 标记语言
  - Markdown
tags: Markdown
---

docsify-themeable - A delightfully simple theme system for docsify.js
https://jhildenbiddle.github.io/docsify-themeable/#/

![](https://upload-images.jianshu.io/upload_images/1662509-3096acf1ee4a7d03.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-d5e4cb89fe674771.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-60f5db2d2a081afe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# Quick Start

## Installation

1. [Create a docsify site](//docsify.js.org/#/quickstart) by following the instructions on the [docsify.js](//docsify.js.org) website.

1. Select a theme from the [Themes](themes) section and replace the `<link>` in your `index.html`.

   ```html
   <!-- Theme: Simple (latest v0.x.x) -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/css/theme-simple.css">
   ```

1. Add the docsify-themeable plugin to your `index.html` after docsify:

```html
<!-- docsify-themeable (latest v0.x.x) -->
<script src="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/js/docsify-themeable.min.js"></script>
```

1. Review the [Options](options) section and configure as needed. For example:

```html
<script>
    window.$docsify = {
        // ...
        themeable: {
            readyTransition : true, // default
            responsiveTables: true  // default
        }
    }
</script>
```

1. Review the [Customization](customization) section and set theme properties as needed. For example:

```html
<style>
    :root {
    /* Reduce the font size */
    --base-font-size: 14px;

    /* Change the theme color hue */
    --theme-hue: 325;

    /* Change the sidebar bullets */
    --sidebar-nav-link-before-content: '😀';
    }
</style>
```

## Local Preview

Previewing your site locally requires serving your files from a web server.

The docsify [Quick Start](//docsify.js.org/#/quickstart) guide recommends [docsify-cli](//github.com/QingWei-Li/docsify-cli) for creating and previewing your site:

```bash
# Install docsify-cli globally
npm install -g docsify-cli

# Serve current directory
docsify serve

# Serve ./docs directory
docsify serve docs
```

A simple [Python](https://www.python.org/) web server can also be used:

```bash
# Change to site directory
cd /path/to/site/files

# Show Python version
python --version

# Launch web server (Python 2.x)
python -m SimpleHTTPServer

# Launch web server (Python 3.x)
python -m http.server
```

## Hosting

Sites powered by [docsify.js](//docsify.js.org/) can be hosted on any web server. The [docsify website](//docsify.js.org/) provides a helpful [deployment guide](//docsify.js.org/#/deploy) with tips for hosting your site on following platforms:

- [GitHub Pages](https://pages.github.com/)
- [GitLab Pages](https://about.gitlab.com/features/pages/)
- [Firebase Hosting](https://firebase.google.com/docs/hosting/)
- [Virtual Private Server (VPS)](https://en.wikipedia.org/wiki/Virtual_private_server)

## 主题推荐

docsify-share 使用的主题
<https://coroo.github.io/docsify-share/#/>

```html
  <!-- docsify-themeable styles-->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsify-themeable@0/dist/css/theme-simple.css" title="light">
  <link rel="stylesheet" href="assets/css/main-custom.css">
  <link rel="stylesheet" href="assets/css/button-custom.css">

  <script src="//unpkg.com/docsify/lib/docsify.min.js"></script>
```

![](https://upload-images.jianshu.io/upload_images/1662509-78f4d1435e4b015c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
