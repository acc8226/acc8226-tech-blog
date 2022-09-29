## 第一个 Gradle 命令

```sh
gradle -h
```

查看帮助信息
```
USAGE: gradle [option...] [task...]
```

## 构建 Setup tasks

init - Initializes a new Gradle build.
wrapper - Generates Gradle wrapper files.

```
gradle init
```

```
Options
     --dsl     Set the build script DSL to be used in generated scripts.
               Available values are:
                    groovy
                    kotlin
```

![](https://upload-images.jianshu.io/upload_images/1662509-740b3956410537ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Gradle 提供了通过 Groovy 或基于 kotlin 的 DSL 创建和配置任务的 api。 Project 包括一组 Tasks，每个 Tasks 执行一些基本操作。

```
gradle wrapper
```

```
Options
     --distribution-type     The type of the Gradle distribution to be used by the wrapper.
                             Available values are:
                                  ALL
                                  BIN
     --gradle-version     The version of the Gradle distribution required by the wrapper.
```

## gradle help

首先可以`gradle help` 了解一下常用的命令。前提是该目录已经是一个 gradle 项目，否则需要事先进行初始化。

```
gradle help

> Task :help

Welcome to Gradle 7.2.

To run a build, run gradle <task> ...
To see a list of available tasks, run gradle tasks
To see a list of command-line options, run gradle --help
To see more detail about a task, run gradle help --task <task>
```

## gradle tasks

Tasks 命令列出了可以调用的 Gradle 任务，包括由基础插件添加的任务，以及刚刚添加的自定义任务。

要查看所有任务和更多细节，请运行 `gradle tasks --all`

## 快速入门- [Analyze and debug your build](https://guides.gradle.org/creating-new-gradle-builds/#analyze_and_debug_your_build)

Gradle 提供了一个简单的 Java 项目，您可以使用它来演示构建扫描功能。 如果你想使用它，克隆或下载存储库。

```
$ git clone https://github.com/gradle/gradle-build-scan-quickstart
Cloning into 'gradle-build-scan-quickstart'...
$ cd gradle-build-scan-quickstart
```

从 Gradle 4.3开始，您可以启用构建扫描，而无需在构建脚本中进行任何附加配置。 当使用命令行选项—— scan 发布构建扫描时，所需的构建扫描插件将自动应用。 在构建结束之前，您被要求在命令行上接受许可协议。 下面的控制台输出演示了该行为。
```
$ ./gradlew build --scan
```

如果你浏览你的构建扫描，你应该能够很容易地找出什么任务被执行，他们花了多长时间，哪些插件被应用，等等。 下次在 StackOverflow 上调试某些内容时，考虑共享构建扫描。

## 自定义 copy 任务

Gradle 提供了一个任务库，您可以在自己的项目中进行配置。 例如，有一种名为 Copy 的核心类型，它将文件从一个位置复制到另一个位置。 Copy 任务非常有用(有关详细信息，请参阅文档) ，但是在这里，让我们再次保持它的简单性。 执行以下步骤:

1. 创建一个名为 src 的目录。
2. 在 src 目录中添加名为 myfile.txt 的文件。 内容是任意的(甚至可以为空) ，但为了方便起见，添加单行 Hello，World！ 对它。
3. 在 build.gradle 文件中，在构建文件中定义一个名为 `type: Copy` (注意大写字母)的任务，该任务将 src 目录复制到名为 dest 的新目录。 (您不必创建 dest 目录ー任务会为您完成。)

```
mkdir src
echo HelloWorld > src/myfile.txt
```

```
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory") {
    from "src"
    into "dest"
}
```

在这里，`group`和`description`可以是任何你想要的。 您甚至可以省略它们，但这样做也会在任务报告中省略它们，以后再使用。

现在执行新的复制任务:
```
gradle copy
```

## zip 命令

包括了一系列插件，更多的插件可以在 Gradle 插件门户网站上找到。 发行版中包含的插件之一是 `basic` 插件。 结合名为 `Zip` 的核心类型，可以使用已配置的名称和位置创建项目的 Zip 归档。
```
plugins {
    id "base"
}

task zip(type: Zip, group: "Archive", description: "Archives sources in a zip file") {
    from "src"
    setArchiveFileName "basic-demo-1.0.zip"
}
```

基础插件使用设置在 build / distribution 文件夹中创建一个名为 basic-demo-1.0.zip 的归档文件。

```
gradle zip
```

### Discover available properties 发现可用属性

```
gradle properties
```

输出是广泛的，下面是一些可用的属性:
```
> Task :properties

------------------------------------------------------------
Root project
------------------------------------------------------------

buildDir: /Users/.../basic-demo/build
buildFile: /Users/.../basic-demo/build.gradle
description: null
group:
name: basic-demo
projectDir: /Users/.../basic-demo
version: unspecified

BUILD SUCCESSFUL

```
Buildfile 属性是构建脚本的完全限定路径名，默认情况下位于 projectDir 中。

您可以更改许多属性。 例如，您可以尝试将以下行添加到构建脚本文件中，并重新执行 gradle 属性。
```
description = "A trivial Gradle build"
version = "1.0"
```
