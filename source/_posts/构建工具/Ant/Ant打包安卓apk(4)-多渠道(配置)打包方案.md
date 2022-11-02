---
title: Ant打包安卓apk(4) 多渠道(配置)打包方案
date: 2018-10-01 21:03:35
categories:
  - 构建工具
  - Ant
tags:
- Ant
---

> 目标 虽然用不上渠道的概念, 其实其实和渠道的概念类似, 其实就是多几个可以变更的字段配置。

目前我需要一个 boolean, 一个请求的 url,

```properties
config.url =http://10.1.64.42:9082/insure-pad/padServer.do,
config.bool = false
```

我想加快 apk 打包速度啊, 一方面是还在用 eclipse, 二来如果用普通的 gradle 的 farvor 方式还是不够快,美团都有 v2 方案了, 自己搞一搞比较有意思而已

## META-INF目录下添加额外信息(不推荐)

然后从代码中读取需要的字段即可

### 探测敌情

![](https://upload-images.jianshu.io/upload_images/1662509-090b0f1ff9def401.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 我的思考

我写出了这种形式`,http://10.1.104.28:8081/insure-pad/padServer.do,true`, 间隔符用的是逗号, 因为需要和`META-INF`拼接后的区分,  这样就能用`String#split`进行分割

可是在Windows环境下文件名不能包含`\/:*?"<>|`这九种字符

#### 我查询 Java 的 Unicode 编码, 想用对应字符替代

* 用166`¦`替代`:`
* 用643`ʃ`替代`/`
~~但是从文件名在安卓上读取的字符想扑克牌的方片,识别不了, 此路不走罢~~

#### 试试 URL 编码

> URL 编码 遵循下列规则: 每对 name/value 由 &; 符分开;每对来自表单的 name/value 由 = 符分开。如果用户没有输入值给这个 name，那么这个 name 还是出现，只是无值。任何特殊的字符(就是那些不是简单的七位 ASCII，如汉字)将以百分符 % 用十六进制编码，当然也包括象 =,&;，和 % 这些特殊的字符。其实url编码就是一个字符 ascii 码的十六进制。不过稍微有些变动，需要在前面加上"%"。比如"\"，它的 ascii码是 92，92 的十六进制是 5c，所以"\"的 url 编码就是 %5c。那么汉字的 url 编码呢? 很简单，看例子:"胡"的ascii码是-17670，十六进制是 BAFA，url 编码是 "%BA%FA"。

但是由于我写的地址`%2Chttp%3A%2F%2F10.1.64.42%3A9082%2Finsure-pad%2FpadServer.do%2Cfalse`由于我试的是android 5.1的机器, 暂时判定存在特殊字符串, 导致Failure [INSTALL_PARSE_FAILED_NO_CERTIFICATES]
~~URL编码也不好走~~

#### 通过文件名转成对应的字符串

其实解决的就是冒号 和 斜杠的转义, 写法如下
将`,http://10.1.64.42:9082/insure-pad/padServer.do,false`
其中用[SLASH]  表示斜杠`/` , 用[COLON] 表示冒号`:`
**还是存在同样的问题, 存在特殊字符串, 会导致Failure[INSTALL_PARSE_FAILED_NO_CERTIFICATES]**
所以仍然解决不了问题, 心灰意冷了

## APP文件的注释字段中添加渠道信息。(不推荐)

该种方式利用了 APK 本身是一种 zip 包的特点，在 zip 的注释字段中添加渠道信息，并提供了gradle插件。其中数据格式定义如下：

![](https://upload-images.jianshu.io/upload_images/1662509-3fec8266f79b4604.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

而添加的渠道信息如下所示：

![](https://upload-images.jianshu.io/upload_images/1662509-9b428a82b8fa0655.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

该种方式较前两种方式实现相对麻烦些，特别是渠道信息的获取需要读取整个APK，解析注解，获取渠道信息，另外就是**兼容性不是很好**。

## AndroidManifest.xml 中添加渠道信息 (推荐)

渠道信息将被添加到application结点下的子结点meta-data中，如下：

```xml
 <application
          android:icon="@7F03000A"
          android:label="@7F060014"
          android:theme="@7F090083">
      <meta-data
            android:name="Goapk_Market"
            android:value="Goapk">
      </meta-data>
```

该种方式是目前应用最广的一种，比如友盟统计 sdk，腾讯统计 sdk 等。其中**name和value可以自由定义**，比较灵活。APP 可以利用系统 API，方便的获取渠道信息，示例代码如下：

```java
ApplicationInfo appInfo = this.getPackageManager().getApplicationInfo(getPackageName(), PackageManager.GET_META_DATA);
String channel = appInfo.metaData.getString("Goapk_Market");
```

这里采用的是网易云捕精英大队开发了[多渠道打包工具](http://crash-public-online.nos.netease.com/makechannels.zip)，该工具主要基于 manifest 和 meta 渠道包制作方式，实现快速批量多渠道包的生成。

命令行下，运行：`java -jar makechannels.jar` 查看版本号与使用方法：

![](https://upload-images.jianshu.io/upload_images/1662509-cf07de8b17c65440.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

配置的 channels.txt (以 | 分割, 第一个是配置 value, 第二个是配置 key, 第三个是配置输出的文件名)

```text
false,http://10.1.104.28:8081/xxx|CUSTOM_KEY|保全技术
true,http://10.1.104.28:8099/yyy|CUSTOM_KEY|技术微服务
```

![插入成功, 很靠谱](https://upload-images.jianshu.io/upload_images/1662509-8bd0267ec6a520c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

推荐采用通用性较好的manifest方式
`java -jar makechannels.jar -apk xxx.apk -config channels.txt -out outputApk`

接下来得重新签名, 这里注意安卓从Android 7.0开始引入了v2签名，但是由于app需要兼容之前的机器，所以也必须进行v1签名才可以。如果只进行v2签名，将导致在android7.0之前的机器安装失败；我尝试Java自带的jarsigner可是报错`META-INF/MANIFEST.MF has invalid digest for AndroidManifest.xml`, 后来查资料发现还是用网易提供的极速签名工具[点击下载](http://nsmobile-pub-online.nos.netease.com/apksigner.rar)靠谱

`java -jar apksigner.jar -appname 测试 -keystore debug.keystore -pswd android -alias androiddebugkey -aliaspswd android -v1 true -v2 false in.apk `

> * -appname 待签名的应用程序名，可选，但建议不同的 APP 填上对应的 app 名（可以为中文），有助于【加速】
> * -keystore：后跟.keystore 签名文件
> * -alias：后跟签名别名
> * -pswd：后跟对应签名的密码，例如这里是 android 可选，如果不填，则签名的时候需要手动输入
> 最后跟待签名的 apk 路径或者目录路径，如果跟的是目录则是批量签名。
签名后如果包能正确安装到手机（无需运行）则没有问题，如果安装失败请用命令安装 ：`adb install apkfile`查看出错信息

最后一步 zipalign 优化

`zipalign -v -f [alignmentSize] in.apk out.apk `
(可选)再进行v2签名。
`java -jar ApkSigner.jar [-appname test] -keystore keystorePath -alias alias [-pswd password] [-aliaspswd aliasPassword] -v1 false -v2 true out.apk`

## 参考

* 详解高速神器 python 脚本打包 android apk，超级快！！（打包系列教程之六） - CSDN 博客
<https://blog.csdn.net/javazejian/article/details/50760590>
* Android快速批量多渠道包的“蛋生” - 网易云捕博客 - CSDN博客
<https://blog.csdn.net/crash163/article/details/51879585>
* Android 应用加固_工具下载_通用工具_网易云易盾
<http://support.dun.163.com/documents/15588074449563648?docId=101829642806284288>
* 自动化打包 apk 总结并整合资料 - 简书
<https://www.jianshu.com/p/4a07d902066f>
