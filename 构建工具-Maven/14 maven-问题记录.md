## 遇到的问题

### Maven 错误：was cached in the local repository, resolution will not be reattempted until the update

在使用公司内部的 maven 仓库编译项目时，由于新加入了几个依赖包，第一次编译失败了，可能原因是 maven 私服找不到相关jar。此后在修复了公司内部 maven 仓库后编译项目出现错误

* 方法一：查看本地仓库对应 jar 包所在目录的 lastUpdated 文件，进一步查看报错信息，尝试删除后再次运行原 maven 命令或进行代码的拉取。

* 方法二：在repository 的 release 或者 snapshots 版本中新增 updatePolicy 属性，设置为”always”、”daily” (默认)、”interval:XXX” (分钟)或”never”。这里设置为 always，表示强制每次都更新依赖库。

* 方法三：maven命令后加 -U，如 mvn package -U【推荐】

### 单元测试编写好, 但是不执行

根据约定优于配置。在默认情况下，“maven-surefire-plugin”插件将自动执行项目“src/test/java”路径下的测试类，但测试类需要遵从以下命名模式，Maven才能自动执行它们：　　
Test*.java ：以 Test 开头的 Java 类；
*Test.java ：以 Test 结尾的 Java 类;
*TestCase.java：以 TestCase 结尾的 Java 类。

### Maven 3.8.1 报错 Blocked mirror for repositories

```text
[ERROR] Failed to execute goal on project test: Could not resolve dependencies for project xxx: Failed to collect dependencies at my.test:dependency:version -> my.test.transitive:transitive:version: Failed to read artifact descriptor for my.test.transitive:transitive:jar:version: Could not transfer artifact my.test.transitive:transitive:pom:version from/to maven-default-http-blocker (http://0.0.0.0/): Blocked mirror for repositories: [blocked-repository-id (http://blocked.repository.org, default, releases+snapshots)]
```

解决办法有:

* 将依赖性版本升级到新版本，用 HTTPS 版本替换过时的 HTTP 存储库 URL
* 保留依赖版本，但在设置中定义一个镜像。
* 注释掉 $MAVEN_HOME/conf/settings.xml 中的拦截标签。

### 使用maven打包失败，报Unknown lifecycle phase “.test.skip=true“

将命令从

```sh
mvn clean package -Dmaven.test.skip=true
```

改为

```sh
mvn clean package '-Dmaven.test.skip=true'
```

## 一些记录

### 跳过测试用例的执行

* -DskipTests，不执行测试用例，但编译测试用例类生成相应的 class 文件至 target/test-classes下。
* -Dmaven.test.skip=true，不执行测试用例，也不编译测试用例类。

### Maven 的 Snapshot 版本与 Release 版本的区别

Maven 的 Snapshot 版本与 Release 版本

1、Snapshot 版本代表不稳定、尚处于开发中的版本。
2、Release 版本则代表稳定的版本。
3、什么情况下该用 SNAPSHOT?
协同开发时，如果 A 依赖构件 B，由于 B 会更新，B 应该使用 SNAPSHOT 来标识自己。这种做法的必要性可以反证如下：
a. 如果 B 不用 SNAPSHOT，而是每次更新后都使用一个稳定的版本，那版本号就会升得太快，每天一升甚至每个小时一升，这就是对版本号的滥用。
b.如果 B 不用 SNAPSHOT, 但一直使用一个单一的 Release 版本号，那当 B 更新后，A 可能并不会接受到更新。因为 A 所使用的 repository 一般不会频繁更新 release 版本的缓存（即本地 repository)，所以B以不换版本号的方式更新后，A在拿B时发现本地已有这个版本，就不会去远程 Repository 下载最新的 B

4、 不用 Release 版本，在所有地方都用 SNAPSHOT 版本行不行？
不行。正式环境中不得使用 snapshot 版本的库。 比如说，今天你依赖某个 snapshot 版本的第三方库成功构建了自己的应用，明天再构建时可能就会失败，因为今晚第三方可能已经更新了它的 snapshot 库。你再次构建时，Maven 会去远程 repository 下载 snapshot 的最新版本，你构建时用的库就是新的 jar 文件了，这时正确性就很难保证了。

### 【用处不大】从 Maven 项目中导出项目依赖的jar包

一、导出到默认目录 targed/dependency
　　从Maven项目中导出项目依赖的jar包：进入工程pom.xml 所在的目录下，执行如下命令：
　　1、mvn dependency:copy-dependencies，则 maven 项目所依赖的 jar 包会导出到 target/dependency 目录中。

二、导出到自定义目录中
　　在maven项目下创建lib文件夹，输入以下命令：
　　1、mvn dependency:copy-dependencies -DoutputDirectory=lib；
　　2、maven 项目所依赖的 jar 包都会复制到项目目录下的lib目录下。

三、设置依赖级别
　　同时可以设置依赖级别，通常使用 compile 级别
　　mvn dependency:copy-dependencies -DoutputDirectory=lib -DincludeScope=compile

### maven 中配置多个 mirror 的问题

有个小伙伴遇到一个疑问：他的工作笔记本，在公司用部门搭建的maven私服做镜像，回到家用 aliyun 的镜像，每次都要改配置文件，很麻烦，希望能够不改动配置文件的情况下，动态切换 mirror 配置。

我们知道 settings.xml 中可以使用变量，可以尝试使用变量解决。

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

我们知道，默认情况下配置多个 mirror 的情况下，只有第一个生效。那么我们可以将最后一个作为默认值，前面配置的使用环境变量动态切换。

默认情况下，执行： `mvn help:effective-settings` 可以看到使用的是私服。

如果希望使用阿里云镜像，如下执行：

```sh
mvn help-effective-settings -Daliyun=central
```

同样的道理，使用网易镜像，则执行：

```sh
mvn help:effective-settings -Dnetease=central
```

### maven 在构建多模块项目中，从选择性的指定位置进行构建应用

> 参考 Maven 常用命令 - 构建反应堆中指定模块_jason5186 的博客-CSDN博客
<https://blog.csdn.net/jason5186/article/details/39530087>
>
> 通过查看 mvn -h命令，可以了解其他命令及其用途；
-am --also-make            同时构建所列模块的依赖模块；
-amd -also-make-dependents 同时构建依赖于所列模块的模块；
-pl --projects `<arg>`     构建制定的模块，模块间用逗号分隔；
-rf -resume-from `<arg>`   从指定的模块恢复反应堆。

## 参考

maven 中配置多个 mirror 的问题 - 知乎 <https://zhuanlan.zhihu.com/p/69695365>
