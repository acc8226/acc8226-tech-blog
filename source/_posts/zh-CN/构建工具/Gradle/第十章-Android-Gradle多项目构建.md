---
title: 第十章-Android-Gradle多项目构建
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

Android 的多项目和其他基于 Gradle 构建的多项目是差不多，比如 Java 多项目、Groovy 多项目，他们本身都是 Gradle 的多项目构建，唯一的区别是项目本身属性，比如这个项目是 Java 库、那个是 Android App 项目等等。

这一章我们简单的介绍下 Android 不同类型的项目，他们如何设置，如何引用以及库项目如何单独发布，像因多项目导致的 65535 等问题我们已经在上一章节做了介绍，这里就不再重复了。

### 10.1 Android项目区别

Android 的项目一般分为 库项目、应用项目、测试项目，Android Gradle 根据他们分别有 3 种插件
com.android.library、com.android.application、com.android.test。

库项目一般和我们的 Java 库非常相似，它比 Java 多的是一些 Android 特有的资源等配置。一般一些具有公用特性的类、资源等可以抽象成一个库工程，这样他们就可以被其他不用的项目引用；还有一种情况，比如我们的工程非常负责，我们可以根据我们业务，把我们的工程分成一个个的库项目，然后通过一个主的应用项目引用他们，组合起来，就是我们最终的产品->一个复杂的 App 了。

<!-- more -->

应用项目，一般只有一个，它可以打包成我们可发布的 Apk 包，如果工程太复杂，就像上面说的，它会引用很多的库项目，以便组成一个最终的 App 发布。应用项目有时也会有多个，比如我们发布了不同特色的 App，但是他们又是同类产品，比如 QQ 的标准版、轻聊版，他们是同类产品，只不过轻聊版更简洁，去除了很多冗余的功能，这时候我们就可以创建两个应用项目，让他们引用不用的库项目，然后再分别根据需求做出相应的调整，就可以生成两个不同的 App，满足不同人群的要求。

测试项目是我们为了对我们的 App 进行测试而创建的，比如测试 Activity、Service、Application 等等，他是Android 基于 Junit 提供的一种测试Android项目的框架方法，让我们可以方便的对我们的Android App进行测试，保证质量。

### 10.2 Android 多项目设置

多个项目的设置和 Gradle 的多项目是一样的，Android 也是基于 Gradle 的，所以项目其实是 Gradle 的概念，项目自身的特性才是每个领域的细分和定义，比如 Android 项目、Java 项目等等。

定义一个工程，包含很多项目，在 Gradle 中，项目的结构没有那么多的限制，不像我们用 Eclipse+Ant 构建的时候，路径都限制的很多，比如只能在根目录下等等，在Gradle 中就没有这么多限制了，你可以通过文件夹组织你不同的项目，最终只要在 setting.gradle 里配置好这些项目即可。比如如下的项目结构：

![](http://upload-images.jianshu.io/upload_images/1662509-eaeb0bb25c320965.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

严格的说应该是四个项目，还有一个根项目MyProject。根项目会有一个 setting.gradle 配置文件，每个项目里都有一个 build.gradle 文件，所以他们的结构为：

![](http://upload-images.jianshu.io/upload_images/1662509-0293dafe71129bbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这就是一个完成的工程了，里面只要再加上一些 Java 文件、资源等等，就可以编译运行了，我们看下setting.gradle配置文件，也是非常简单的。

![](http://upload-images.jianshu.io/upload_images/1662509-764d5b6fc8a5ca58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

就是指定这几个项目，有时候如果项目的路径太深，我们可以用如下方法指定配置：

![](http://upload-images.jianshu.io/upload_images/1662509-973b7b47b7086b75.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

通过如上方法我们直接指定项目的目录即可。这样我们整个多项目配置的架子算是搭好了，增减项目可以模拟这个框架。

### 10.3 库项目引用和配置

多项目配置好之后，就要引用他们，尤其是库项目，不然我们多项目协作开发还有什么意义呢？一般引用的都是库项目，所以这里我们着重讲库项目引用。

Android 库项目引用和 Gradle 的其他引用是一样的，都是通过dependencies：

![](http://upload-images.jianshu.io/upload_images/1662509-5c0f496b78dc1c99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就引用了这个 lib 库项目，就是这么简单，沿用了 Gradle 的依赖来进行关系，关于 Gradle 依赖可以请参考我们前面章节讲的。

需要特别说明的是 Android App 项目不光可以引用 Android Lib 项目，还可以引用 Java Lib 项目哦，这个看我们的需求，Android Lib 是打包成一个 aar 包，Java Lib是打包成一个 jar包，如果我们里面有资源，就是用 Android Lib，如果没有并且是纯 Java 的可以考虑 Java Lib。

引用 Android 库项目是引用的一个库项目发布出来的**aar包**，默认情况下，Android库项目发布出来的包都是**release**的，当然我们可以通过配置来改变它，比如改成默认发布的是debug的

![](http://upload-images.jianshu.io/upload_images/1662509-501a0e7e7c95bfbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就改成发布的是debug版本的aar包了，我们可以通过如上方式配置不同的发布版本，只要我们配置的这个名字是合法存在的即可--也就是Assemble任务能够打包出来的aar包。比如你配置了多个flavor，那么我们发布的就可以针对不同的flavor+buildtype配置，比如：

![](http://upload-images.jianshu.io/upload_images/1662509-b1f345ceb9ca780f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就发布了flavor1Debug这个aar包以供其他的的项目引用。

有朋友可能要问了，如果想同时发布多个版本的 aar 包以供不同的项目引用怎么办？比如我们要做一个产品，他们有不同的版本，但是都是一个产品，比如一个专业版，一个标版，他们有一些区别，不光是在App项目里体现，在我们的库工程里也要体现(比如库工程里针对这两种版本的资源不一样)，这时候我们需要针对不同的版本，引用不同的发布的aar包。这是可以做到的，默认情况下是不能同时发布多个 aar 包的，我们可以开启。

![](http://upload-images.jianshu.io/upload_images/1662509-fc4d7194bb19d007.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这时候就是告诉 Android Gradle 插件我们这个库工程要同时发布不同的 aar，这时候 Android Gradle 就会生成多个 aar 以供被其他项目引用，下面看下我们怎么分别引用他们。

![](http://upload-images.jianshu.io/upload_images/1662509-d13ca76391523940.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看到这里大家看明白了把，对于 lib 这个库项目，我们先配置成可以同时发布多个aar，然后我们在其他引用工程里做如上示例的引用，比如 flavor1 这个渠道包就引用 flavor1 这个渠道对应的 lib1 库的 release aar包；flavor2这个渠道就引用flavor2 这个渠道对应的 lib1 库的 release aar包。

以上这些引用都是在项目立直接引用，下一节我们讲如何发布我们的aar包到Maven中心库，以供其他项目引用。

### 10.4 库项目单独发布

项目直接依赖一般适用于关联比较紧密、不可复用的项目，对于这类项目我们可以直接基于源代码项目的依赖，有时候我们会有一些项目，可以被其他项目所复用，比如我们的公共组件库，工具库等等，这类就可以单独发布出去，被其他项目使用，就像我们引用jcenter上的类库一样方便，这一节我们就讲如何把库项目单独的发布到我们自己的Maven中心库.

要搭建自己的Maven私服，推荐使用 Nexus Repository Manager，版本选择 2.xx，下载地址： <http://www.sonatype.com/download-oss-sonatype> ，我这里选择的是 2.12.1 版本，我们选择 nexus-2.12.1-01-bundle.tar.gz包下载解压，然后找到nexus-2.12.1-01\bin\jsw这个目录，可以看到有很多以操作系统和 cpu 架构命名的文件夹，你可以根据你的系统选择进入相应的文件夹运行 start-nexus 脚本即可启动 Nexus，启动之后，我们在浏览器里打开 <http://localhost:8081/nexus/> 即可访问，注意看右上角有个 Log In 链接，点击可以登陆管理 Nexus，默认的用户名是admin，密码是admin123。关于Nexus的搭建和使用，非常简单，大家可以 Google 下相关文章，很容易的就会入门使用，这里不再多讲。

有了部署好的Nexus Maven中心库之后，我们就可以把我们的项目发布到我们的中心库了，要想通过Maven发布，首先我们得在build.gradle中应用maven插件：

```sh
apply plugin: 'com.android.library'
apply puugin: 'maven'
```

应用过之后，我们需要配置Maven构建的三要素，他们分别是 group:artifact:version。

```groovy
apply plugin: 'com.android.library'
apply puugin: 'maven'

version  '1.0.0'
group 'ory.flysnow.widget'
```

group 和 version 比较方便，直接指定即可。对于 version 还有一个概念-快照版本 SNAPSHOT，比如配置成 1.0.0-SNAPSHOT，这时候我们在发布的时候就会发布到我们的 snapshot 中心库里，每次发布版本号不会变化，只会在版本号后之后按顺序号 +1，比如1.0.0-1，1.0.0-2，1.0.0-3 等等，类似于这样的，我们引用的时候版本号写1.0.0-SNAPSHOT 即可，Maven 会帮我们下载最新(序号最大的)的**快照版本，这种方式适用于联调测试**的时候，每次修复好测试的问题就发布一个快照版本，直到没有问题为止，然后再放出release版本，正式发布。

配置好 group 和 version 之后，我们来配置发布配置，比如发布到到哪个 Maven 库，使用的用户名和密码多少，发布什么格式的存档，它的 artifact 是什么等等：

![](http://upload-images.jianshu.io/upload_images/1662509-e5e66e8df430ae0e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如上所示，我们配置了uploadArchives，指定对应的mavenDeployer配置，这里配置了两个发布的Maven库，一个是release版本的，一个是snapshot版本的，并同时配置了他们的密码以及URL，URL是nexus maven提供的，可以打开Nexus网页版，点击右侧的repositorys菜单查看，里面配置了很多库，我们也可以新增一些自己的repository。

发布到 Nexus Maven 库之后，我们就可以像引用 jcenter 中的类库一样引用他们，要使用他们，我们首先得配置我们的仓库，因为我们新增了一个我们自己的私有Maven库，这个使用要告诉Gradle，不然它不知道这个私有Maven仓库的存在。

![](http://upload-images.jianshu.io/upload_images/1662509-7944387993630556.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样配置后，我们就可以在我们的依赖配置里引用刚刚发布的aar包啦

![](http://upload-images.jianshu.io/upload_images/1662509-fc39168d0e461e1f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

刚刚我们讲了我们可以发布快照版本，那么我们如何引用呢？因为快照版本的仓库和Release的不一样，所以我们还得要新增一个快照版本的仓库。

![](http://upload-images.jianshu.io/upload_images/1662509-93e10486fd7c9f0f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

引用的时候时候把 dependencies 依赖换成如下这样即可：

![](http://upload-images.jianshu.io/upload_images/1662509-dfce7614c690c5b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样所以解决了问题，但是会配置两个Maven库，而且他们非常相似，那么能不能用一个Maven库代替呢？答案是可以的，Nexus Maven为我们提供了一种**group类型的repository，这种类型的repository可以同时集成好几个repository**，把他们统一当成一个group来对外发布，比如Nexus内置的public group，就包含里release和snapshot，现在我们可以把Maven库的配置改为

![](http://upload-images.jianshu.io/upload_images/1662509-06b1f9085aa79cd9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样就方便简洁多了，你可以在Nexus里配置public这个分组所管理的repository，可以增减，看你的需求，也可以新建其他group类型的repository来用，比如根据你们公司的事业部来创建不同的group给他们使用，很好的分离开了不同权限、不同业务需求的repository。

### 10.5 小结

有了前面几章的知识，这一章的理解简单的多，因为多项目其实就是不同项目的组合，前面我们已经针对单个项目的不同的配置，所以多项目要做的其实就是针对这些项目，采用 Gradle 的方式管理组合起来即可。

这一章节比较重要的新知识点就是库项目的单独发布，发布到 Maven 中心库，学会里这个，发布到其他如jcenter库就非常简单了，他们是类似的，你只要在 jcenter 注册好账号，得到发布的地址即可配置发布。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle 权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
