---
title: ac网址导航-争做简洁、高效的网址导航
date: 2022-07-27 00:00:00
updated: 2022-07-27 00:00:00
categories:
  - 我的开源
---

采用 HTML + CSS + JQ 开发的简单的静态页面，手机上查看效果也正常。搭配 github pages 或者 gitee pages 食用效果更佳！

注：本项目修改于刘明野的工具箱 <https://tools.liumingye.cn/> 右键并查看源代码。如有侵权，请联系我们，本站会尽快删除。

## 项目地址

<https://gitee.com/acc8226/nav>

## 网址导航代码修改过程

1. 右键查看源代码，去除自认为不需要元素并保存 css 和 js 等资源到本地
2. 直接修改 index.html 代码即可。添加网址分类和按条目添加网址信息。

图片替换示例：

```html
<img class="img-circle lazy" src="./imgs/mail.webp"
```

### 如何获取图标

图标类的 icon 的获取：一般而言为域名后 + "/favicon.ico"即可出现所需站点的 ico 图标。

对于 PC 类的图标，我更倾向于极限软件园-极限下载站-绿色免费软件下载基地找寻图标。这样的图标更高清。
<http://www.jxdown.com/>

对于 app 类型，可以去应用宝搜索 app 的图标。
<https://webcdn.m.qq.com/webapp/homepage/index.html#/>

### 图标压缩

如果图标过大，甚至超过 50k 则可以对其进行压缩。我一般会采用在线压缩工具 <https://tinify.cn/> 进行压缩优化。
