Gradle 是一款非常优秀的构建系统工具,它的 DSL 基于 Groovy 实现,可以让你很方便的通过代码控制这些 DSL 来达到你构建的目的，其构建的大部分功能都是通过插件的方式来实现，所以非常灵活方便，如果内置插件不能满足你的需求你可以自定义自己的插件。

## 配置 Gradle 环境

### Linux下搭建 Gradle 构建环境

Gradle 可运行在所有主流的操作系统上，只需要安装一个 Java JDK 或 JRE 8或更高版本即可。

运行 `java -version` 将检查 Java 环境:

```bash
$ java -version
java version "1.8.0_121"
```

先到 Gradle 官网 https://gradle.org/ 下载 Gradle。这里区分 binary-only 版或者 complete 版(with docs and sources)

将发行版 zip 文件解压缩到你选择的目录中，例如:

```sh
mkdir /opt/gradle
unzip -d /opt/gradle gradle-6.3-bin.zip
```

配置你的 PATH / 环境变量包含解压缩发行版的 bin 目录，例如:

```sh
GRADLE_HOME=/opt/gradle/gradle-6.3
PATH=$PATH:${GRADLE_HOME}/bin
export GRADLE_HOME PATH
```

要运行 Gradle，必须把 GRADLE_HOME/bin 目录添加到你的环境变量 PATH 的路径里才可以。在 Linux 下，如果你只想为你当前登陆的用户配置可以运行Gradle，那么可以编辑～/.bashrc文件添加以下内容：然后在终端输入 source ~/.bashrc 回车执行让刚刚的配置生效。

如果你想让所有用户都可以使用gradle，那么你就需要在/etc/profile中添加以上内容，在这里添加后，对所有用户都生效，这种方式的添加，必须要重启电脑才可以

输入**gradle -v**命令查看即可，如果能正确显示gradle版本号、Groovy版本号、JVM等相关信息，那么说明你已经配置成功了.

### Window下搭建Gradle构建环境

环境变量配置项，添加 GRADLE_HOME 环境变量，然后把GRADLE_HOME\bin添加到PATH系统变量里保存即可。完成后打开CMD运行gradle -v来进行验证，整体和Linux差不多，这里就不在一一详述。

### Mac下搭建Gradle构建环境

同 Linux 类似。在终端中输入：`open -e ~/.bash_profile`，打开.bash_profile文件

```bash
GRADLE_HOME=/Users/ale/opt/gradle/gradle-7.2
export GRADLE_HOME
export PATH=$PATH:$GRADLE_HOME/bin
```
Reload your terminal to see this change reflected or run the following command:
`$ source ~/.bash_profile`

Verify your installation

```bash
gradle -v
```

## Gradle 版 Hello World

新建好一个目录，然后在该目录下创建一个名为 build.gradle 的文件，打开编辑该文件，输入以下内容：

```groovy
task hello{
    doLast{
        println'Hello world!'
    }
}
```

cd 到对应目录，使用 gradle -q hello 命令来执行构建脚本：
`gradle -q hello`

看到 gradle -q hello 这段运行命令，意思是要执行build.gradle脚本中定义的名为hello的Task，-q参数用于控制gradle输出的日志级别，哪些日志可以输出被看到。

看到 println 'Hello World!' 了吗，它会输出 Hello World!，通过名字相信大家已经猜出来了，它其实就是System.out.println("Hello World!")的简写方式。Gradle 可以识别它，是因为 Groovy 已经把 println() 这个方法添加到 java.lang.Object，而在 Groovy 中，方法的调用可以省略签名中的括号，以一个空格分开即可，所以就有了上面的写法。还有一点要说明的就是在 Groovy 中，单引号和双引号所包含的内容都是字符串，不像 Java 中，单引号是字符，双引号才是字符串。

## Gradle Wrapper

Wrapper，顾名思义，其实就是对Gradle的一层包装，便于在团队开发过程中统一Gradle构建的版本，这样大家都可以使用统一的Gradle版本进行构建，避免因为Gradle版本不统一带来的不必要的问题。

Gradle 提供了内置的 wrapper task 帮助我们自动生成 wrapper 所需的目录文件，在一个项目的根目录，输入gradle wrapper 即可生成。

![生成的文件](http://upload-images.jianshu.io/upload_images/1662509-77672dc3e620760e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

gradlew 和 gradlew.bat 分别是 Linux 和 Window 下的可执行脚本，他们的用法和gradle原生命令是一样的，gradle 怎么用，他们也就可以怎么用。gradle-wrapper.jar是具体业务逻辑实现的jar包，gradlew 最终还是使用 java 执行的这个jar包来执行相关 gradle 操作。gradle-wrapper.properties 是配置文件，用于配置使用哪个版本的 gradle 等。

这些生成的wrapper文件可以作为你项目工程的一部分提交到代码版本控制系统里(git)，这样其他开发人员就会使用这里配置好的统一的gradle进行构建开发。

**自定义Wrapper Task**
前面我们讲了，gradle-wrapper.properties 是由 wrapper task 生成的，那么我们是否可以自定义配置该 Wrapper task 来达到我们配置 gradle-wrapper.properties的目的呢，答案是肯定的。我们可以在 build.gradle 构建文件中录入如下脚本：

![](http://upload-images.jianshu.io/upload_images/1662509-82f9ff0c8b30c608.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们再执行gradle wrapper的时候，就自定义了其他和默认生成 2.4 版本的wrapper

## Gradle日志

### 日志级别

![日志级别](http://upload-images.jianshu.io/upload_images/1662509-0457cbd8ee42bd3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```sh
# 输出 quiet 级别及其以上的日志
gradle -q tasks
# 输出 info 级别及其以上的日志
gradle -i tasks
```

### 输出错误堆栈信息

在使用 Gradle 构建的时候，难免会有这样或者那样的问题导致你的构建失败，这时就需要你根据日志分析解决问题。除了以上的日志信息之外，Gradle还提供了堆栈信息的打印，用过 Java 语言的相信大家都会很熟悉错误堆栈信息，他能帮助我们很好的定位和分析问题。

默认情况下，堆栈信息的输出是关闭的，需要我们通过命令行的堆栈信息开关打开它，这样在我们构建失败的时候，Gradle才会输出错误堆栈信息，便于我们定位分析和解决问题。

![](http://upload-images.jianshu.io/upload_images/1662509-97ee37401b143f94.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在编写 Gradle 脚本的过程中，我们有时候需要输出一些日志，来验证我们的逻辑或者一些变量的值是否正确，这时候我们就可以使用Gradle提供的日志功能。
通常情况下我们一般都是使用print系列方法，把日志信息输出到标准的控制台输出流（它被Gradle定向为QUIET级别日志）。

除了 print 系列方法之外，你也可以使用内置的 logger 更灵活的控制输出不同级别的日志信息。

![](http://upload-images.jianshu.io/upload_images/1662509-6b4022faf47f0016.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

logger 说是内置，其实是调用的 Project 的 getLogger() 方法获取的 Logger 对象的实例。

## Gradle命令行

### 记得使用帮助

命令行下的工具都有命令，刚开始我们不会用或者不知道有什么命令或者参数，这没事，但是我们可以通过帮助来了解，基本上所有的命令行工具都有帮助，查看帮助的方式也很简单，基本上都是在命令后跟-h或者--help，有的时候会有 -?,以Gradle Wrapper为例：

![](http://upload-images.jianshu.io/upload_images/1662509-4ff90c09b848193d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 查看所有可执行的 Tasks

有时候我们不知道如何构建一个功能，不知道执行哪个 Task，这时候就需要查看哪些 Task 可执行，都具备什么功能，通过运行./gradlew tasks命令

### gradle help 任务

除了上面我们说的每个命令行都有帮助外，Gradle还内置了一个help task，这个help可以让我们了解每一个task的使用帮助，
用法是 ./gradlew help --task <task name>，
比如 `./gradlew help --task tasks`，就可以显示tasks任务的帮助信息：

**强制刷新依赖**
我们一个功能不可避免的会依赖很多第三方库，像 Maven 这类工具都是有缓存的，因为不可能每次编译的时候都要重新下载第三方库，缓存就是这个目的，先使用缓存，没有再下载。默认情况下Maven这类工具会控制缓存的更新，但是也有例外，比如 Version 一样，但是里面的代码变了；还有就是联调测试时使用的snapshot 版本。以上两种情况我们在实际项目中都遇到过，最后就是通过强制刷新解决的。

强制刷新很简单，只要在命令行运行的时候加上--refresh-dependencies 参数就可以，这是IDE很难做到的（需要你了解配置），所以命令行的优势就体现出来了，非常简单。

`gradle --refresh-dependencies assemble`

### 多任务调用

有时候我们需要同事运行多个任务，比如在执行Jar之前先进行 clean，那么我们就需要先执行 clean 对 class文件清理，然后再执行jar生成一个jar包。通过命令行执行多个任务非常简单，**只需要按顺序以空格分开即可**，比如 gradle clean jar，这样就可以了，有更多的任务时，可以继续添加。

### 通过任务名字缩写执行执行

有的时候我们的任务名字很长，Gradle提供了**基于驼峰命名法**的缩写调用，比如 connectCheck，我们执行的时候可以使用 gradlew connectCheck, 也可以使用 gradlew cc这样的方式来执行。

## 参考

本文纯属自学历程 + 一些记录，绝大部分内容来自原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)。觉得对你有用，请支持原书。
