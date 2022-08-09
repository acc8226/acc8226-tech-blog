---
title: 13 Maven 常用命令和配置支持自动化部署
categories:
  - 构建工具
  - Maven
tags:
- Maven
---

## 自动化构建和发布

项目开发过程中，部署的过程包含需如下步骤：

* 将所的项目代码提交到 SVN 或者代码库中并打上标签。
* 从 SVN 上下载完整的源代码。
* 构建应用。
* 存储构建输出的 WAR 或者 EAR 文件到一个常用的网络位置下。
* 从网络上获取文件并且部署文件到生产站点上。
* 更新文档并且更新应用的版本号。

问题描述
通常情况下上面的提到开发过程中会涉及到多个团队。一个团队可能负责提交代码，另一个团队负责构建等等。很有可能由于涉及的人为操作和多团队环境的原因，任何一个步骤都可能出错。比如，较旧的版本没有在网络机器上更新，然后部署团队又重新部署了较早的构建版本。

解决方案

通过结合以下方案来实现自动化部署：

* 使用 Maven 构建和发布项目
* 使用 SubVersion， 源码仓库来管理源代码
* 使用远程仓库管理软件（Jfrog或者Nexus） 来管理项目二进制文件。

修改项目的 pom.xml
我们将会使用 Maven 发布的插件来创建一个自动化发布过程。

例如，bus-core-api 项目的 pom.xml 文件代码如下：

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/maven-4.0.0.xsd">
   <modelVersion>4.0.0</modelVersion>
   <groupId>bus-core-api</groupId>
   <artifactId>bus-core-api</artifactId>
   <version>1.0-SNAPSHOT</version>
   <packaging>jar</packaging>
   <scm>
      <url>http://www.svn.com</url>
      <connection>scm:svn:http://localhost:8080/svn/jrepo/trunk/
      Framework</connection>
      <developerConnection>scm:svn:${username}/${password}@localhost:8080:
      common_core_api:1101:code</developerConnection>
   </scm>
   <distributionManagement>
      <repository>
         <id>Core-API-Java-Release</id>
         <name>Release repository</name>
         <url>http://localhost:8081/nexus/content/repositories/
         Core-Api-Release</url>
      </repository>
   </distributionManagement>
   <build>
      <plugins>
         <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-release-plugin</artifactId>
            <version>2.0-beta-9</version>
            <configuration>
               <useReleaseProfile>false</useReleaseProfile>
               <goals>deploy</goals>
               <scmCommentPrefix>[bus-core-api-release-checkin]-<
               /scmCommentPrefix>
            </configuration>
         </plugin>
      </plugins>
   </build>
</project>
```

在 pom.xml 文件中，我们常用到的一些重要元素节点如下所示：

SCM：配置 SVN 的路径，Maven 将从该路径下将代码取下来。
repository：构建的 WAR 或 EAR 或JAR 文件的位置，或者其他源码构建成功后生成的构件的存储位置。
Plugin：配置 maven-release-plugin 插件来实现自动部署过程。

## mvn 集成项目用到的命令

不要忘了clean： clean能够保证上一次构建的输出不会影响到本次构建。

使用`-B`参数：该参数表示让 Maven 使用批处理模式构建项目，能够避免一些需要人工参与交互而造成的挂起状态。

使用 `-e` 参数：如果构建出现异常，该参数能让 Maven 打印完整的 stacktrace，以方便分析错误原因。

-T 2 是直接指定 2 线程；-T 1C 表示CPU线程的倍数。一般 1C 用的比较多，前提是多线程构建对项目无影响。

【可选】使用 `-U`参数： 该参数能强制让 Maven 检查所有 SNAPSHOT 依赖更新，确保集成基于最新的状态，如果没有该参数，Maven 默认以天为单位检查更新，而持续集成的频率应该比这高很多。

使用`-Dmaven.repo.local`参数：如果持续集成服务器有很多任务，每个任务都会使用本地仓库，下载依赖至本地仓库，为了避免这种多线程使用本地仓库可能会引起的冲突，可以使用 `-Dmaven.repo.local=/home/juven/ci/foo-repo/` 这样的参数为每个任务分配本地仓库。

综上，持续集成服务器上的集成命令应该为
`mvn clean deploy -B -e -U -Dmaven.repo.local=xxx`

此外，定期清理持续集成服务器的本地 Maven 仓库也是个很好的习惯，这样可以避免浪费磁盘资源，几乎所有的持续集成服务器软件都支持本地的脚本任务，你可以写一行简单的 shell 或 bat 脚本，然后配置以天为单位自动清理仓库。需要注意的是，这么做的前提是你有私有 Maven 仓库，否则每次都从 Internet 下载所有依赖会是一场噩梦。

## maven 多环境发布

可参考此篇文章，主要是设置了不同的 profile。然后用 -P 命令进行制定。
xuanm - 博客园 <https://www.cnblogs.com/grasp/p/12794707.html>

## idea 开启 maven 多线程编译的方法

![idea 配置 maven 多线程构建](./imgs/13%20Maven-%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4%E5%92%8C%E9%85%8D%E7%BD%AE%E6%94%AF%E6%8C%81%E8%87%AA%E5%8A%A8%E5%8C%96%E9%83%A8%E7%BD%B2/idea64_qFIIiH5qHu.png)
