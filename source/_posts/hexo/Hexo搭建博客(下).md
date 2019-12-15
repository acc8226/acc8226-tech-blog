---
title: Hexo搭建博客(下)
date: 2018-08-17 22:58:23
updated: 2018-08-18 17:26:55
---
老实说, 作为一个非网页前端, 能搭建这样一个博客已是非常难得了，再次感谢 主题[Archer](https://github.com/fi3ework/hexo-theme-archer)的作者。

我其实不愿意花太多时间特意打理，这样太花里胡哨啦。

## 首先用git管理项目
![](https://upload-images.jianshu.io/upload_images/1662509-9e61e45fdd8becb9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这里看到`.npmignore`这个东西, 感觉缺了.gitignore, 所以copy一下改改文件名就OK了, 是不是很机制

## _config.yml配置自动部署
提前安装 [hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。
```bash
$ npm install hexo-deployer-git --save
```
![加上git部署](https://upload-images.jianshu.io/upload_images/1662509-f0316ce1562d8876.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## _config.yml配置Writing新文章默认格式
```
# Writing
new_post_name: :category/:title.md # 新文章默认的文件名称  hexo new mytitle --category mycategory
```

## 启用-Algolia-搜索
### 注册帐号(可以用 Github 登录)
前往 Algolia [注册页面](https://www.algolia.com/)，注册一个新账户。 可以使用 GitHub 或者 Google 账户直接登录，注册后的 14 天内拥有所有功能（包括收费类别的）。之后若未续费会自动降级为免费账户，免费账户 总共有 10,000 条记录，每月有 100,000 的可以操作数。注册完成后，创建一个新的 Index，这个 Index 将在后面使用。

![image](https://user-images.githubusercontent.com/12322740/40921716-d512bae6-6842-11e8-804e-53a8e71206ab.png)

### 安装 Algolia
Index 创建完成后，此时这个 Index 里未包含任何数据。 接下来需要安装 [Hexo Algolia](https://github.com/oncletom/hexo-algolia) 扩展， 这个扩展的功能是搜集站点的内容并通过 API 发送给 Algolia。前往站点根目录，执行命令安装：
```bash
npm install --save hexo-algolia
```
### 获取 keys
在 Algolia 服务站点上找到需要使用的一些配置的值，包括 ApplicationID、Search-Only API Key、 Admin API Key。注意，Admin API Key 需要保密保存。点击ALL API KEYS 找到新建INDEX对应的key， 编辑权限，在弹出框中找到ACL选择勾选Add records, Delete records, List indices, Delete index权限，点击update更新。

![](https://user-images.githubusercontent.com/12322740/40921972-7fa7d64e-6843-11e8-9680-0f796767cccc.png)

然后在 **Hexo 目录下的 _config** 文件中加入以下字段（有三个字段是需要替换的）：

```yaml
algolia:
  applicationID: 'your applicationID'
  apiKey: 'your apiKey'
  indexName: 'your apiKey name'
  chunkSize: 5000
```
### 更新 index
在 Hexo 目录下执行以下命令，注意：
1. 如果是 Windows 系统，export 要换为 set (**如果使用的是git bash就不用换了**)
2. 填入你自己的 apiKey

```bash
$ export (in windows is set) HEXO_ALGOLIA_INDEXING_KEY='apiKey'
$ hexo algolia
```

### 主题集成
然后在 **archer 主题目录下的 _config** 文件中修改以下字段：
**（注意：目前有一个小 bug，不能在 hits_empty 和 hits_stats 中写入单引号，否则会报错）**

```yaml
algolia_search:
  enable: true
  hits:
    per_page: 10
  labels:
    input_placeholder: Search for Posts
    hits_empty: "We did not find any results for the search: ${query}"
    hits_stats: "${hits} results found in ${time} ms"
```

## 更改成自己喜欢的日期类型
![](https://upload-images.jianshu.io/upload_images/1662509-f336e25b670c69b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```html
<a href="<%- page.permalink %>"><%- (page.date).format('MMMM Do YYYY, h:mm:ss a') .....

修改为

<a href="<%- page.permalink %>"><%- (page.date).locale('zh-CN').format('YYYY年MMMMDo, H:mm:ss dddd') .....
```