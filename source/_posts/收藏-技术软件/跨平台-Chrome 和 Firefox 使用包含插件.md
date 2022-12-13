---
title: 跨平台-Chrome 和 Firefox 使用包含插件
date: 2020-09-12 10:53:39
updated: 2022-11-16 13:28:02
categories:
  - 收藏
  - 技术软件
---

## chrome 的使用

### 常用快捷键

新建标签
Ctrl + T

关闭当前标签
Ctrl + W

新建窗口
Ctrl + N

有时，我们会发现某个标签页本不该关闭，却为时已晚。正因如此，在 Chrome 中，可以通过几个简便的按键操作，重新打开关闭的标签页。
Windows, Chrome OS & Linux: Ctrl + Shift + T

借助此快捷键，您可以瞬间清除自己的浏览数据。
Windows, Chrome OS & Linux: Ctrl + Shift + Delete

放大/缩小以及还原为默认缩放比例等操作。
Windows, Chrome OS & Linux: Ctrl and +
Windows, Chrome OS & Linux: Ctrl and -
Windows, Chrome OS & Linux: Ctrl and 0

使用此键盘快捷键保存您喜爱和经常访问的网站。
Windows, Chrome OS & Linux: Ctrl + D

向下翻页
空格键 或者 pageDown 键

向上翻页
Shift + 空格键 或者 pageUp 键

### 常用插件

#### uBlock Origin （去广告）

uBlock Origin - 一款不可多得的浏览器广告拦截插件，使用体验比 Adblock 效果更好。
<https://www.cnplugins.com/office/block/>

#### 浏览器辅助神器：油猴

Tampermonkey 是一款浏览器脚本管理插件，常见浏览器都支持，结合脚本网站 Greasyfork，能够方便的实现脚本旳一键安装、自动更新、快速启用等便捷功能。

打开 [Tampermonkey.net](https://link.zhihu.com/?target=http%3A//tampermonkey.net/) 官网，安装对应版本的插件。

> **注**：chrome 可以通过网站 [crx4chrome](https://link.zhihu.com/?target=https%3A//www.crx4chrome.com/) 来下载扩展程序 crx 文件，手动将 crx 文件拖动至扩展页面安装即可。

**greasyfork 脚本大全**
<https://greasyfork.org/zh-CN> 。

**数码小站一个免费插件就能愉快地互联网冲浪**
<https://greasyfork.org/zh-CN/scripts/426806>
【数码小站】超级SVIP多功能工具箱-百度网盘直链高速下载,VIP视频去广告免费看等多功能聚合,持续更新

**为了让超链接能痛快地把用户送到终点**
<https://greasyfork.org/zh-CN/scripts/412612>
Open the F**king URL Right Now

**免费视频在线解析**
<https://greasyfork.org/zh-CN/scripts/27349>

#### Proxy SwitchyOmega

<https://proxy-switchyomega.com/>

Chrome 和 Firefox 浏览器上的代理扩展程序，可以轻松快捷的管理和切换多个代理设置。

* 可以使用 HTTP/Socks 代理访问网站；可以根据多种条件和规则自动切换；可以根据在线或本地的 PAC 脚本规则使用代理。
* 可以在线导入 AutoProxy 和 Switchy 格式的规则，也可以自己添加域名通配符、网址通配符和网址正则等切换规则。
* 可以在浏览器菜单中对情景模式进行快速切换，可以快速对当前网址添加过滤规则。

#### Web 开发者助手 FeHelper

<https://www.baidufe.com/fehelper/index/index.html>

插件支持Chrome、Firefox、MS-Edge 浏览器，内部工具集持续增加，目前包括 JSON 自动/手动格式化、JSON 内容比对、代码美化与压缩、信息编解码转换、二维码生成与解码、图片 Base64 编解码转换、Markdown、 网页油猴、网页取色器、脑图(Xmind)等贴心工具，甚至在目前新版本的 FeHelper 中，还集成了 FH 开发者工具， 如果你也想自己搞一个工具集成到 FeHelper 中，那这一定能满足到你。另外，本站也提供部分工具的在线版本！

#### Restlet Client-REST API Testing

Postman 的轻巧替代品

【Restlet Client - REST API Testing v2.19.1 Chrome插件下载】Restlet Client - REST API Testing v2.19.1 Chrome插件免费下载 - 开发者插件下载 - Chrome插件网

<http://www.cnplugins.com/devtool/restlet-client-rest-api-t-v2-19-1/download.html>

#### Axure RP Extension For Chrome （用于打开产品原型图）

对于很多需要设计产品原型的朋友来说，Axure RP Pro可谓是非常方便、好用的一款软件，因为它不仅能绘制出详细的产品构思，也能生成浏览器格式的产品原型。但是如果想把原型拿给客户查看，千万记得给浏览器安装Axure扩展程序哦。

最新Axure谷歌浏览器Chrome扩展程序安装方法 - Axure中文网
<https://www.axure.com.cn/79769/>

#### 彩云小译 - 在线翻译  (比百度 / 谷歌更智能）【付费，可免费使用】

<https://fanyi.caiyunapp.com/#/web>

浏览网页时，点击书签栏中或插件的"彩云小译"，网页将变成中英对照模式。

#### 安装插件遇到的问题及解决方法总结

**谷歌浏览器中安装 .crx 扩展名的离线 Chrome 插件**
找到自己已经下载好的 Chrome 离线安装文件 xxx.crx，然后将其从资源管理器中拖动到 Chrome 的扩展管理界面中，这时候用户会发现在扩展管理器的中央部分中会多出一个”拖动以安装“的插件按钮。

**解决“只能通过Chrome网上应用商店安装该程序”的方法**
1.把下载后的 .crx 扩展名的离线Chrome插件的文件扩展名改成 .zip 或者 .rar
2. 在 Chrome 的地址栏中输入：chrome://extensions/ 打开 Chrome 浏览器的扩展程序管理界面，并在该界面的右上方的开发者模式按钮上打勾
3. 在勾选开发者模式选项以后，在该页面就会出现加载正在开发的扩展程序等按钮，点击“加载正在开发的扩展程序”按钮，并选择刚刚解压的 Chrome 插件文件夹的位置。
4. 若出现加载程序出错的情况，Chrome 浏览器会提示无法加载以下来源的扩展程序： xxx路径（Chrome插件文件的解压位置）Cannot load extension with file or directory name _metadata. Filenames starting with "_" are reserved for use by the system.出现这种情况，是因为这款 Chrome 插件与新版的 Chrome 浏览器有些不兼容，这时候，用户可以打开刚刚解压的 Chrome 插件文件夹，并把其中 _metadata 文件夹的名字修改为 metadata（把前面的下划线去掉）
5. 更新文件夹名称成功以后，点击该错误提示下方的“重试”按钮，就可以成功地把Chrome插件加载谷歌浏览器中了

## firefox 的使用
