---
title: 14. Maven-问题记录
date: 2021-11-03 19:21:31
updated: 2022-08-25 15:00:00
categories:
  - 构建工具
  - Maven
tags:
- Maven
---

## 记录

### mvn 指定 jdk 版本

windows

```sh
set JAVA_HOME=D:/java/jdk1.8
mvn clean package
```

linux

```sh
export JAVA_HOME=/usr/loal/jdk1.8
mvn clean package
```

<!-- more -->

### 跳过测试用例的执行

* -DskipTests，不执行测试用例，但编译测试用例类生成相应的 class 文件至 target/test-classes 下。
* -Dmaven.test.skip=true，不执行测试用例，也不编译测试用例类。

<!-- more -->

### Maven 中 classifier

classifier 通常用于区分从同一 POM 构建的具有不同内容的构件（artifact）。它是可选的，它可以是任意的字符串，附加在版本号之后。

2.使用场景
场景一：区分基于不同 JDK 版本的 jar 包
场景二：区分项目的不同组成部分，例如：源代码、javadoc、类文件等。

写法

```xml
<!-- maven -->
<dependency>
    <groupId>net.sf.json-lib</groupId>
    <artifactId>json-lib</artifactId>
    <version>2.4</version>
    <classifier>jdk15</classifier>
</dependency>
```

```groovy
<!-- gradle-->
compile group: 'net.sf.json-lib', name: 'json-lib', version: '2.4',classifier:'jdk15'
```

### Maven 的 Snapshot 版本与 Release 版本的区别

Maven 的 Snapshot 版本与 Release 版本

1、Snapshot 版本代表不稳定、尚处于开发中的版本。
2、Release 版本则代表稳定的版本。
3、什么情况下该用 SNAPSHOT?
协同开发时，如果 A 依赖构件 B，由于 B 会更新，B 应该使用 SNAPSHOT 来标识自己。这种做法的必要性可以反证如下：
a. 如果 B 不用 SNAPSHOT，而是每次更新后都使用一个稳定的版本，那版本号就会升得太快，每天一升甚至每个小时一升，这就是对版本号的滥用。
b.如果 B 不用 SNAPSHOT, 但一直使用一个单一的 Release 版本号，那当 B 更新后，A 可能并不会接受到更新。因为 A 所使用的 repository 一般不会频繁更新 release 版本的缓存（即本地 repository)，所以B以不换版本号的方式更新后，A 在拿 B 时发现本地已有这个版本，就不会去远程 Repository 下载最新的 B

4、 不用 Release 版本，在所有地方都用 SNAPSHOT 版本行不行？
不行。正式环境中不得使用 snapshot 版本的库。 比如说，今天你依赖某个 snapshot 版本的第三方库成功构建了自己的应用，明天再构建时可能就会失败，因为今晚第三方可能已经更新了它的 snapshot 库。你再次构建时，Maven 会去远程 repository 下载 snapshot 的最新版本，你构建时用的库就是新的 jar 文件了，这时正确性就很难保证了。

### Maven 项目中导出项目依赖的 jar 包

1\. 导出到默认目录 targed/dependency
　　从 Maven 项目中导出项目依赖的 jar 包：进入工程 pom.xml 所在的目录下，执行如下命令：
　　1、mvn dependency:copy-dependencies，则 maven 项目所依赖的 jar 包会导出到 target/dependency 目录中。

2\. 导出到自定义目录中
　　在 maven 项目下创建 lib 文件夹，输入以下命令：
　　1、mvn dependency:copy-dependencies -DoutputDirectory=lib；
　　2、maven 项目所依赖的 jar 包都会复制到项目目录下的lib目录下。

3\. 设置依赖级别
　　同时可以设置依赖级别，通常使用 compile 级别
　　mvn dependency:copy-dependencies -DoutputDirectory=lib -DincludeScope=compile

### maven 动态切换 mirror 配置

在公司用部门搭建的 maven 私服做镜像，回到家用 aliyun 的镜像，每次都要改配置文件，很麻烦，希望能够不改动配置文件的情况下，

我们知道 settings.xml 中可以使用变量，可以尝试使用变量解决。首先需配置多个 mirror。

```xml
<mirrors>
  <mirror>
    <id>aliyun</id>
    <url>https://maven.aliyun.com/repository/public</url>
    <mirrorOf>${aliyun}</mirrorOf>
  </mirror>
  <mirror>
    <id>netease</id>
    <url>http://mirrors.163.com/maven/repository/maven-public/</url>
    <mirrorOf>${netease}</mirrorOf>
  </mirror>
   <mirror>
    <id>default</id>
    <url>http://192.168.0.100/nexus/repository/maven-public/</url>
    <mirrorOf>central</mirrorOf>
  </mirror>
</mirrors>
```

默认情况下配置多个 mirror 的情况下，只有第一个生效。那么我们可以将最后一个作为默认值，前面配置的使用环境变量动态切换。

默认情况下，执行： `mvn help:effective-settings` 可以看到使用的是私服。

如果希望使用阿里云镜像，如下执行：

```sh
mvn help-effective-settings -Daliyun=central
```

同样的道理，使用网易镜像，则执行：

```sh
mvn help:effective-settings -Dnetease=central
```

### maven 在构建多模块项目中，指定位置进行构建应用

通过查看 mvn -h 命令，可以了解其他命令及其用途；

```text
-am --also-make            同时构建所列模块的依赖模块；
-amd -also-make-dependents 同时构建依赖于所列模块的模块；
-pl --projects `<arg>`     构建制定的模块，模块间用逗号分隔；
-rf -resume-from `<arg>`   从指定的模块恢复反应堆。
```

## 遇到的问题

### mvn 命令必须在 pom 文件目录下执行吗

不是，可以 -f 指定 pom。

```sh
 -f,--file <arg>                        Force the use of an alternate POM
                                        file (or directory with pom.xml)
```

### 报错：was cached in the local repository, resolution will not be reattempted until the update

在使用公司内部的 maven 仓库编译项目时，由于新加入了几个依赖包，第一次编译失败了，可能原因是 maven 私服找不到相关 jar。此后在修复了公司内部 maven 仓库后编译项目出现错误

* 方法一：查看本地仓库对应 jar 包所在目录的 lastUpdated 文件，进一步查看报错信息，尝试删除后再次运行原 maven 命令或进行代码的拉取。

* 方法二：在 repository 的 release 或者 snapshots 版本中新增/修改 updatePolicy 属性，它的可选项有”always”、”daily” (默认)、”interval:XXX” (分钟)或”never”。这里可以设置为 always，表示强制每次都更新依赖库。

* 方法三：maven 命令后加 -U，如 mvn package -U【推荐】

### 单元测试编写好, 但是不执行

根据约定优于配置。在默认情况下，“maven-surefire-plugin” 插件将自动执行项目 “src/test/java” 路径下的测试类，但测试类需要遵从以下命名模式，Maven 才能自动执行它们：

* Test*.java ：以 Test 开头的 Java 类；
* *Test.java ：以 Test 结尾的 Java 类;
* *TestCase.java：以 TestCase 结尾的 Java 类。

### Maven 3.8.x 报错 Blocked mirror for repositories

```text
[ERROR] Failed to execute goal on project test: Could not resolve dependencies for project xxx: Failed to collect dependencies at my.test:dependency:version -> my.test.transitive:transitive:version: Failed to read artifact descriptor for my.test.transitive:transitive:jar:version: Could not transfer artifact my.test.transitive:transitive:pom:version from/to maven-default-http-blocker (http://0.0.0.0/): Blocked mirror for repositories: [blocked-repository-id (http://blocked.repository.org, default, releases+snapshots)]
```

解决办法有:

* 将依赖性版本升级到新版本，用 HTTPS 版本替换过时的 HTTP 存储库 URL
* 保留依赖版本，但在设置中定义一个镜像。
* 注释掉 `$MAVEN_HOME/conf/settings.xml` 中的拦截标签。

```xml

```

### 使用 maven 打包失败，报 Unknown lifecycle phase “.test.skip=true“

windows 环境下使用 powershell 会这样，请将命令从

```sh
mvn clean package -Dmaven.test.skip=true
```

改为

```sh
mvn clean package '-Dmaven.test.skip=true'
```

### 【WARNING】The POM for com.alibaba:druid:jar:1.1.21 is invalid 警告问题

执行 install 命令并添加 -X 参数，方便排查。

```sh
# cmd 输出 DEBUG 信息
mvn clean install -X
# 或者直接把 DEBUG 信息输出到本地的 debug.txt 文件
mvn clean install -X > debug.txt
```

### File encoding has not been set, using platform encoding GBK, i.e. build is platform dependent

在 pom.xml 中，properties 中新增 project.build.sourceEncoding:

```xml
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

### Non-parseable POM

spring boot 项目，pom 文件报错……< /head> must be the same as start tag < meta>……，进入父pom所在目录一看发现是个 html 文件

原因：stackoverflow 上找到了答案，大意是公司的网络把下载父 pom 文件的请求拦截了，然后出于某种错误，把 html 页面当成了父 pom

### build.plugins.plugin.version' for org.apache.maven.plugins:maven-compiler-plugin is missing

原因
没有设置 maven-compiler-plugin 版本

解决办法
在 pom.xml 文件中，找到 maven-compiler-plugin 设置版本

## 参考

maven 中配置多个 mirror 的问题 - 知乎 <https://zhuanlan.zhihu.com/p/69695365>
