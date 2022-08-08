---
title: 15 mvnd - the Maven Daemon
categories:
  - 构建工具
  - Maven
tags:
- 构建工具
- Maven
---

Index of /maven/mvnd
<https://downloads.apache.org/maven/mvnd/>

maven-mvnd 是 Apache Maven 团队借鉴了 Gradle 和 Takari 后衍生出的更快的构建工具。mvnd 内嵌了 Maven，也正是因为这个原因我们可以无缝地将 Maven 切换为 mvnd（也不需要单独安装Maven）。

在设计上，在 mvnd 中会生成一个或多个的守护进程来服务构建请求以此来达到并行构建的效果。另外在 VM 的选择上，mvnd 使用了 GraalVM来代替传统的 JVM，与之相比 GraalVM 启动速度更快，占用的内存更少。

根据文档描述，与传统的 Maven 相比 mvnd 具有以下优势：

运行构建的 JVM 不需要为每个构建重新启动。

Maven 插件类的类加载器缓存在多个构建中，插件 jars 只会被读取和解析一次。
JVM 中 JIT 生成的本机代码会被保留。与 Maven 相比，JIT 编译花费的时间更少。在重复构建期间，JIT 优化的代码立即可用。这不仅适用于来自 Maven 插件和Maven内核的代码，也适用于来自 JDK 本身的所有代码。
默认情况下，mvnd 使用多个 CPU 内核并行构建模块。使用的内核数由公式 Math.max(Runtime.getRuntime().availableProcessors() - 1, 1) 给出。 如果您的源代码树不支持并行构建，请在命令行上传递 -T1 以使您的构建串行。

【可选】在解压后根目录的 conf 文件夹下找到 mvnd.properties 配置文件，配置 maven.settings 属性值为 maven 配置文件 settings.xml 的文件路径。注意：此 settings.xml 文件存放位置不受限制。

查看帮助
mvnd --help

## 参考

apache/maven-mvnd: Apache Maven Daemon
<https://github.com/apache/maven-mvnd>
