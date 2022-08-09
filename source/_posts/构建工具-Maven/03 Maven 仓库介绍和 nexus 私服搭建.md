---
title: 03 Maven 仓库介绍和 nexus 私服搭建
date: 2019.11.03 23:42:26
categories:
  - 构建工具
  - Maven
tags:
- Maven
---

## Maven 仓库

在 Maven 的术语中，仓库是一个位置（place）。Maven 仓库是项目中依赖的第三方库，这个库所在的位置叫做仓库。在 Maven 中，任何一个依赖、插件或者项目构建的输出，都可以称之为构件。Maven 仓库能帮助我们管理构件（主要是 JAR ），它就是放置所有 JAR 文件（WAR，ZIP，POM 等）的地方。

Maven 仓库有三种类型：

* 本地（local）
* 中央（central）
* 远程（remote）

### 本地仓库

Maven 的本地仓库，在安装 Maven 后并不会创建，它是在第一次执行 maven 命令的时候才被创建。

运行 Maven 的时候，Maven 所需要的任何构件都是直接从本地仓库获取的。如果本地仓库没有，它会首先尝试从远程仓库下载构件至本地仓库，然后再使用本地仓库的构件。

默认情况下，不管 Linux 还是 Windows，每个用户在自己的用户目录下都有一个路径名为 `.m2/respository/` 的仓库目录。

Maven 本地仓库默认被创建在 %USER_HOME% 目录下。要修改默认位置，在 %M2_HOME%\conf 目录中的 Maven 的 settings.xml 文件中更改路径。

默认地址为 `${user.home}/.m2/repository`

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
   http://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository>C:/MyLocalRepository</localRepository>
</settings>
```

当你运行特定 Maven 命令，Maven 将下载依赖的文件到你指定的路径中。

### 中央仓库

Maven 中央仓库是由 Maven 社区提供的仓库，其中包含了大量常用的库。

中央仓库包含了绝大多数流行的开源 Java 构件，以及源码、作者信息、SCM、信息、许可证信息等。一般来说，简单的 Java 项目依赖的构件都可以在这里下载到。

中央仓库的关键概念：

* 这个仓库由 Maven 社区管理。
* 不需要配置。
* 需要通过网络才能访问。

使用这个仓库，开发人员可以搜索可能需要获取的代码库。

要浏览中央仓库的内容，maven 社区提供了一个 URL：[http://search.maven.org/#browse](http://search.maven.org/#browse)。

如果您知道包名等信息，也可逐步进行查找 <https://repo.maven.apache.org/maven2/>。

### 远程仓库

如果 Maven 在中央仓库中也找不到依赖的文件，它会停止构建过程并输出错误信息到控制台。为避免这种情况，Maven 提供了远程仓库的概念，它是开发人员自己定制仓库，包含了所需要的代码库或者其他工程中用到的 jar 文件。

举例说明，使用下面的 pom.xml，Maven 将从远程仓库中下载该 pom.xml 中声明的所依赖的（在中央仓库中获取不到的）文件。

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/maven-4.0.0.xsd">
   <modelVersion>4.0.0</modelVersion>
   <groupId>com.companyname.projectgroup</groupId>
   <artifactId>project</artifactId>
   <version>1.0</version>
   <dependencies>
      <dependency>
         <groupId>com.companyname.common-lib</groupId>
         <artifactId>common-lib</artifactId>
         <version>1.0.0</version>
      </dependency>
   <dependencies>
   <repositories>
      <repository>
         <id>companyname.lib1</id>
         <url>http://download.companyname.org/maven2/lib1</url>
      </repository>
      <repository>
         <id>companyname.lib2</id>
         <url>http://download.companyname.org/maven2/lib2</url>
      </repository>
   </repositories>
</project>
```

当然也可以在 settings.xml 的 profiles 标签中进行通用配置。

## 私服 nexus 的特性

nexus 私服实际上是一个 javaEE 的 web 系统
作用:用来管理一个公司所有的 jar 包,实现项目 jar 包的版本统一。
jar下载搜索顺序：本地仓库 -->  nexus私服 或者 Maven中央库.

## 为什么需要私服

为什么要搭建 nexus 私服，原因很简单，有些公司都不提供外网给项目组人员，因此就不能使用 maven 访问远程的仓库地址，所以很有必要在局域网里找一台有外网权限的机器，搭建 nexus 私服，然后开发人员连到这台私服上，这样的话就可以通过这台搭建了 nexus 私服的电脑访问 maven 的远程仓库。

## 安装

nexus下载地址 [http://www.sonatype.org/nexus/](http://www.sonatype.org/nexus/)

nexus for linux/mac 最新版本地址: https://download.sonatype.com/nexus/oss/nexus-latest-bundle.tar.gz

并解压到 `/usr/local/mysoft`下, 然后进入 nexus 的 bin 目录执行`./nexus start`

* sonatype-work: 里面是我们后面要对 nexus 进行一些配置的地方，像索引和起始的仓库和端口等都可以在这里面配置。
* nexus-3.19.1-01: 里面是 nexus 的运行环境和应用程序。

nexus 仓库情况
/usr/local/mysoft/sonatype-work/nexus/storage

> sudo ./nexus start: 在后台启动 Nexus 服务
sudo ./nexus status:查看 Nexus 运行状态
sudo ./nexus stop: 停止后台的 Nexus 服务
sudo./nexus restart: 重新启动后台的 Nexus 服务

如果报错则需要下一步的设置

```text
WARNING: ************************************************************
WARNING: Detected execution as "root" user.  This is NOT recommended!
WARNING: ************************************************************
Starting nexus
```

临时设置
输入：`export RUN_AS_USER=root` . 或者修改需要运行的用户 `vim nexus` 并将RUN_AS_USER变量设置为root.只后再执行 ./nexus start 试试。

nexus 默认主页为 http://IP地址:8081/nexus
默认用户名和密码：admin/admin123

然后为了安全, 可以右上角进入 profile 标签更改密码。

## 基本配置

仓库Type（类型）介绍

仓库有四种类型：
group：仓库组
hosted：宿主
proxy：代理
virtual：虚拟

仓库Format（格式）
有两种 maven1 和 maven2，下面的仓库分类只介绍 maven2

仓库Policy（策略）介绍
Release：发布版本
Snapshots：快照版本

仓库分类介绍
Public Repositories：该仓库组将Policy（策略）为 Release 的仓库聚合并通过一个地址对外提供服务

3rd party：用来部署无法从公共仓库获取的第三方发布版本的 jar 包

Apache Snapshots：用来代理 Apache Maven仓库的快照版本 jar 包

Central：该仓库代理 Maven 中央仓库，其Policy（策略）为 Release，因此只会下载和缓存中央仓库中的发布版本jar包

Codehaus Snapshots：用来代理 CodeHaus Maven仓库的快照版本 jar 包

Release：用户部署组织内部的发布版本的jar包

Snapshots：用来部署组织内部的快照版本的jar包
配置Type（类型）为proxy的的仓库

Download Remote Indexs 表示是否下载远程仓库的索引，有些索引仓库拥有索引，下载其索引后，即使没有缓存远程仓库的构件，用户还是能够在本地，用户还是能够在本地搜索和浏览那些构件的基本信息

**配置 Type（类型）为 proxy 的的仓库**
Download Remote Indexs 表示是否下载远程仓库的索引，有些索引仓库拥有索引，下载其索引后，即使没有缓存远程仓库的构件，用户还是能够在本地，用户还是能够在本地搜索和浏览那些构件的基本信息

![](https://upload-images.jianshu.io/upload_images/1662509-17778b449e836642.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 更新索引文件

![](https://upload-images.jianshu.io/upload_images/1662509-d56aea4b6f63a605.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

或手动更新。

## 上传 jar 到 3rd party 仓库？

![](https://upload-images.jianshu.io/upload_images/1662509-4b287c509fbb0b01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 选择 GAV Definition
**如果上传的 jar 是 maven 构建的，那么就选择 From POM，否则选择GAV Parameters**

![](https://upload-images.jianshu.io/upload_images/1662509-2d216239276db064.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## nexus 3 上传 jar包

![](https://upload-images.jianshu.io/upload_images/1662509-1ab35d84e7769d5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于 type 是 pom 类型的直接传 pom 包。

对于 type 是 jar 类型分别选择 pom 和 jar 文件，不要勾选 generate a pom file with these coordinates。

如果只能拿到 jar 包则需要勾选勾选 generate a pom file with these coordinates。

### 私服迁移

除了手动上传之外，很多时候也存在私服迁移到另外一个服务器的情况，这个时候就有更简单的方式去解决第三方jar的问题。
拷贝原私服 indexer（索引文件夹）和 storage（jar 贮藏文件夹）文件夹

拷贝到目标私服下同一个目录下，如果只需要jar包那就只拷贝 storage 文件夹覆盖即可，同理，需要索引的话那就拷贝 indexer 文件夹覆盖到目标文件夹即可。

如果说需要完全迁移私服，可以将 nexus 安装目录下的 sonatype-work 文件夹完全拷贝过去直接覆盖目标目录即可

![](https://upload-images.jianshu.io/upload_images/1662509-ddebbae3be631f3f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 为什么要设置 group 类型的仓库

![](//upload-images.jianshu.io/upload_images/8339984-caaca3281bf21c9d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

## 参考

搭建 Maven 私服系列(一)：下载并安装 Nexus
<https://blog.csdn.net/qq_35620501/article/details/87899439>
