Maven 翻译为"专家"、"内行"，是 Apache 下的一个纯 Java 开发的开源项目。基于项目对象模型（缩写：POM）概念，Maven 利用一个中央信息片断能管理一个项目的构建、报告和文档等步骤。

Maven 是一个项目管理工具，可以对 Java 项目进行构建、依赖管理。

Maven 也可被用于构建和管理各种项目，例如 C#，Ruby，Scala 和其他语言编写的项目。Maven 曾是 Jakarta 项目的子项目，现为由 Apache 软件基金会主持的独立 Apache 项目。

> Maven is a software project management and comprehension tool. Based on the concept of a Project Object Model (POM), Maven can manage a project's build, reporting and documentation from a central piece of information.

## maven 安装

**环境配置**
磁盘要求: Maven 自身安装需要大约 10 MB 空间。除此之外，额外的磁盘空间将用于你的本地 Maven 仓库。你本地仓库的大小取决于使用情况，但预期至少 500 MB。

Maven is downloadable as a zip file at [https://maven.apache.org/download.cgi](https://maven.apache.org/download.cgi). Only the binaries are required, so look for the link to apache-maven-*{version}*-bin.zip or apache-maven-*{version}*-bin.tar.gz.

1) Unpack the archive where you would like to store the binaries, e.g.:
    Unix-based operating systems (Linux, Solaris and Mac OS X) `tar zxvf apache-maven-3.x.y.tar.gz`
    Windows `unzip apache-maven-3.x.y.zip`

2) A directory called "apache-maven-3.x.y" will be created.

3) Add the bin directory to your PATH, e.g.:

Unix-based operating systems (Linux, Solaris and Mac OS X)
`export PATH=/opt/apache-maven-3.x.y/bin:$PATH`
Windows
`set PATH="C:\Program Files\apache-maven-3.x.y\bin";%PATH%`

4) Make sure JAVA_HOME is set to the location of your JDK

5) Run "mvn --version" to verify that it is correctly installed.

**关于第三点的说明**
从网上查找资料，得知除了直接运行 命令，也可以直接配置文件，效果是一样的：

1. mac 下的配置
`~/.bash_profile`下增加第三点内容并运行`source ~/.bash_profile`使环境变量生效：
2. Linux 下的配置
编辑`/etc/profile`保存文件，并运行上述命令使环境变量生效：`# source /etc/profile`
3. Windows下的配置环境变量
Windows下的配置M2_HOME 和 PATH下新增M2_HOME/bin 目录

## Maven核心概念

**Maven插件**
Maven的核心仅仅定义了抽象的生命周期，具体的任务都是交由插件完成的每个插件都能实现多个功能，每个功能就是一个插件目标

Maven的生命周期与插件目标相互绑定，以完成某个具体的构建任务, Maven的插件在:.m2\repository\org\apache\maven\plugins

**Maven坐标**
类似在平面几何中坐标（x,y）可以标识平面中唯一的一点, Maven世界拥有大量构建，我们需要找一个用来唯一标识一个构建的统一规范　。拥有了统一规范，就可以把查找工作交给机器
　　　　　　groupId：定义当前Maven项目隶属项目  (实际对应JAVA的包的结构, 是main目录里java的目录结构)
　　　　　　artifactId：定义实际项目中的一个模块(项目的唯一的标识符,实际对应项目的名称,就是项目根目录的名称)
　　　　　　version：定义当前项目的当前版本
**Maven仓库**
　　　　何为Maven仓库：用来统一存储所有Maven共享构建的位置就是仓库
　　　　Maven配置jar包的路径为：groupId/artifactId/version/artifactId-version
　　　　本地仓库(~/.m2/repository/)：每个用户只有一个本地仓库
　　　　中央仓库(Maven默认的远程仓库)：Maven默认的远程仓库下载地址为：https://repo1.maven.org/maven2
　　　　私服：是一种特殊的远程仓库, 它是架设在局域网内的仓库, 主要是为了团队协作开发
　　　　镜像：用来替代中央仓库, 速度一般比中央仓库快
**软件构建生命周期,maven软件构建的生命周期**

清除--> 编译-->测试-->报告-->打包（jar\war）-->安装-->部署。

maven生命周期命令插件（命令：mvn clean）：clean--compile--test--package--install-deploy。

maven坐标：maven通过坐标的概念来唯一标识 jar 包或者 war 包。

## Maven目录分析

![](https://upload-images.jianshu.io/upload_images/1662509-cf40b3cad4ebc31b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* bin：含有mvn运行的脚本
* boot：含有plexus-classworlds类加载器框架
* conf：含有settings.xml配置文件
* lib：含有Maven运行时所需要的java类库
* settings.xml 中默认的用户库: ${user.home}/.m2/repository[通过maven下载的jar包都会存储到指定的本地仓库中]

Maven默认仓库下载地址在: maven的lib目录下 maven-model-builder-3.0.4.jar 的 pom.xml中

## Maven 构建生命周期

Maven 构建生命周期定义了一个项目构建跟发布的过程。

一个典型的 Maven 构建（build）生命周期是由以下几个阶段的序列组成的：
Maven 有以下三个标准的生命周期：
clean：项目清理的处理
default(或 build)：项目部署的处理
site：项目站点文档创建的处理

## pom.xml 示例说明

建立 pom.xml 文件

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <!-- 当前 pom 的版本号 -->
  <modelVersion>4.0.0</modelVersion>
  <!-- groupId: 当前 jar 所属的命名空间 -->
  <groupId>cn.bie.maven</groupId>
  <!-- 当前项目模块名称 -->
  <artifactId>Hello</artifactId>
  <!-- 当前项目的版本, SNAPSHOT 镜像版 -->
  <version>0.0.1-SNAPSHOT</version>
    <!-- 当前模块需要依赖的相关jar包,也称为依赖管理, 所有被依赖的包都是通过"坐标"定位的 -->
    <dependencies>
        <!-- 需要依赖junit 通过 groupId+artifactId+version来查找,如果本地没有则到中央仓库下载 -->
        <dependency>
            <!-- 当前jar所属的命名空间 -->
            <groupId>junit</groupId>
            <!-- 依赖的项目模块的名称 -->
            <artifactId>junit</artifactId>
            <!-- 依赖的版本号 -->
            <version>4.1.2</version>
            <!-- 依赖的范围, 有 test compile privlege。test 依赖的 jar 包的使用范围，当测试的时候使用该jar包，正式发布，删除这个 -->
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

## Maven 与 IDE 的配套插件

### Maven Eclipse

Eclipse 提供了一个很好的插件 [**m2eclipse **](http://www.eclipse.org/m2e/)，该插件能将 Maven 和 Eclipse 集成在一起。在最新的 Eclipse 中自带了 Maven。

下面列出 m2eclipse 的一些特点：

* 可以在 Eclipse 环境上运行 Maven 的目标文件。
* 可以使用其自带的控制台在 Eclipse 中直接查看 Maven 命令的输出。
* 可以在 IDE 下更新 Maven 的依赖关系。
* 可以使用 Eclipse 开展 Maven 项目的构建。
* Eclipse 基于 Maven 的 pom.xml 来实现自动化管理依赖关系。
* 它解决了 Maven 与 Eclipse 的工作空间之间的依赖，而不需要安装到本地 Maven 的存储库（需要依赖项目在同一个工作区）。
* 它可以自动地从远端的 Maven 库中下载所需要的依赖以及源码。
* 它提供了向导，为建立新 Maven 项目，pom.xml 以及在已有的项目上开启 Maven 支持。
* 它提供了远端的 Maven 存储库的依赖的快速搜索。

### Maven NetBeans

NetBeans 6.7 及更新的版本已经内置了 Maven。 关于 NetBeans 的一些特性如下：

* 可以通过 NetBeans 来运行 Maven 目标。
* 可以使用 NetBeans 自身的控制台查看 Maven 命令的输出。
* 可以更新 Maven 与 IDE 的依赖。
* 可以在 NetBeans 中启动 Maven 的构建。
* NetBeans 基于 Maven 的 pom.xml 来实现自动化管理依赖关系。
* NetBeans 可以通过自己的工作区解决 Maven 的依赖问题，而无需安装到本地的 Maven 仓库，虽然需要依赖的项目在同一个工作区。
* NetBeans 可以自动从远程 Moven 库上下载需要的依赖和源码。
* NetBeans 提供了创建 Maven 项目，pom.xml 文件的向导。
* NetBeans 提供了 关于Maven 仓库的浏览器，使您可以查看本地存储库和注册在外部的 Maven 仓库。

**NetBeans 里打开一个 Maven 项目**

* 打开 NetBeans
* 选择 **File Menu > Open Project** 选项
* 选择项目的路径，即使用 Maven 创建一个项目时的存储路径。

### IntelliJ IDEA 自带 Maven 插件且默认已启用

特性如下：
可以通过 IntelliJ IDEA 来运行 Maven 目标。
可以在 IntelliJ IDEA 自己的终端里查看 Maven 命令的输出结果。
可以在 IDE 里更新 Maven 的依赖关系。
可以在 IntelliJ IDEA 中启动 Maven 的构建。
IntelliJ IDEA 基于 Maven 的 pom.xml 来实现自动化管理依赖关系。
IntelliJ IDEA 可以通过自己的工作区解决 Maven 的依赖问题，而无需安装到本地的 Maven 仓库，虽然需要依赖的项目在同一个工作区。
IntelliJ IDEA 可以自动从远程 Maven 仓库上下载需要的依赖和源码。
IntelliJ IDEA 提供了创建 Maven 项目，pom.xml 文件的向导。

### Maven for Java - Visual Studio Marketplace

Features:
Maven extension for VS Code. It provides a project explorer and shortcuts to execute Maven commands, improving user experience for Java developers who use Maven.
•Support to generate projects from Maven Archetype.
•Support to generate effective POM.
•Provide shortcuts to common goals, plugin goals and customized commands.
•Preserve command history to fast re-run.

<https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-maven>

## 相关网址

* 官网地址：<https://maven.apache.org>
* Maven 库搜索：<http://mvnrepository.com>
* Maven镜像国内站：<https://repo.huaweicloud.com/apache/maven/maven-3/>
* Index of /maven/maven-3 <https://downloads.apache.org/maven/maven-3/>

## 参考

[Maven的下载，安装，配置，测试，初识以及Maven私服-博客-云栖社区-阿里云](
https://yq.aliyun.com/articles/310615?spm=a2c4e.11153940.blogcont621196.27.244ab4f5HZAxRe)
