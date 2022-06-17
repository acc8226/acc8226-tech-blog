主题介绍: 
NexT - Elegant and powerful theme for Hexo. 支持丰富的拓展的 Hexo 主题.

官网地址
https://theme-next.js.org/

github 地址
https://github.com/next-theme/hexo-theme-next

## 前提已安装 Node 和 hexo
* 操作系统下安装 nodejs
* 使用 npm 安装 hexo: `npm install hexo --save`

## 安装 NexT

### 获取 NexT
using npm 

```bash
$ cd hexo-site
$ npm install hexo-theme-next
```

或使用 git 进行下载(克隆整个仓库到 themes/next 目录)
```bash
$ cd hexo-site
$ git clone https://github.com/next-theme/hexo-theme-next themes/next
```

或者转到 NexT 版本Release Page 发布页面. 下载 [稳定版](https://github.com/next-theme/hexo-theme-next/releases)，将 zip 文件解压缩到站点的 themes 目录，并重命名解压缩的文件夹为 next

### **升级 NexT**
using npm
```
$ cd hexo-site
$ npm install hexo-theme-next@latest
```

using git
```
$ cd hexo-site
$ cd themes/next
$ git pull origin master
```

### 启动 NexT

在 **Hexo 站点配置文件**（`/_config.yml`）中设置你的主题：

```yml
theme: next
```

在更改主题和验证主题之间，我们最好使用 `hexo clean` 来清理 Hexo 的缓存。
然后键入`hexo s --debug`,现在你可以在浏览器中打开 http://localhost:4000，检查网站是否正常运行。

## 部署

### Local Deployment 本地部署

1. Modify files locally. 本地修改文件
3. Localization testing: 本地化测试:hexo clean && hexo s.
3. Deployment: 部署:hexo g -d.

### Continuous Integration 持续集成

可以做到直接在线编辑文件，立即生效的效果.

## 开始自定义设置

如果是第一次安装 NexT，则复制整个配置文件theme config file 主题配置文件 by the following command:

```
# Installed through npm
cp node_modules/hexo-theme-next/_config.yml _config.next.yml
# Installed through Git
cp theme/next/_config.yml _config.next.yml
```


### 主题
迄今为止，NexT 支持4个方案，它们是:
```
#scheme: Muse
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```

默认的 NexT 方案是Muse。我这里选择的是 Gemini 主题.

### Dark Mode 黑暗模式

您可以通过编辑主题配置文件，搜索暗模式关键字来启用暗模式。 主题下一步自动显示黑暗模式，如果操作系统偏好的主题是黑暗的。 Css 混合混合模式是用来使黑暗模式的所有4个方案以上，确保您的浏览器支持此属性。

```
# Dark Mode
darkmode: true
```

### Reading Progress 阅读进度
You can enable it by setting value reading_progress.enable to true in theme config file.

```
# Reading progress bar
reading_progress:
  enable: true
```

### GitHub Banner
Next 在右上角提供了 GitHub 上的 Follow me 标题。

```
# `Follow me on GitHub` banner in the top-right corner.
github_banner:
  enable: true
  permalink: https://github.com/acc8226
  title: Follow me on GitHub
```

### Bookmark 书签

书签是一个插件，允许用户保存他们的阅读进度。 用户只需点击页面左上角的书签图标(如图)就可以保存滚动位置。 当他们下次访问你的博客时，他们可以自动恢复每个页面的最后滚动位置。

```
# Bookmark Support
bookmark:
```

### 返回顶部
```
back2top:
  enable: true
  # Back to top in sidebar.
  sidebar: true
  # Scroll percent label in b2t button.
  scrollpercent: true
```
