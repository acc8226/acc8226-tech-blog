## Set up the project

在您选择的项目目录中，创建以下子目录结构; 例如，使用  `mkdir -p src/main/java/hello` on *nix systems.

`src/main/java/hello/HelloWorld.java`

```java
package hello;

public class HelloWorld {
  public static void main(String[] args) {
  Greeter greeter = new Greeter();
  System.out.println(greeter.sayHello());
  }
}
```

`src/main/java/hello/Greeter.java`

```java
package hello;

public class Greeter {
  public String sayHello() {
  return "Hello world!";
  }
}
```

## Install Gradle

Now that you have a project that you can build with Gradle, you can install Gradle.
It’s highly recommended to use an installer:

* [SDKMAN](https://sdkman.io/)
* [Homebrew](https://brew.sh/) (brew install gradle)

作为最后的手段，如果这两个工具都不适合您的需要，您可以从 https://www.gradle.org/downloads 下载二进制文件。 只需要二进制文件，因此查找 gradle-version-bin.zip 的链接。 (您还可以选择 gradle-version-all.zip 来获取源代码和文档以及二进制文件。)

Unzip the file to your computer, and add the bin folder to your path.

To test the Gradle installation, run Gradle from the command-line:

```sh
gradle
```

If all goes well, you see a welcome message:

```text

:help

Welcome to Gradle 2.3.

To run a build, run gradle <task> ...

To see a list of available tasks, run gradle tasks

To see a list of command-line options, run gradle --help

BUILD SUCCESSFUL

Total time: 2.675 secs
```

### Find out what Gradle can do

现在已经安装了 Gradle，看看它能做什么。 在为项目创建 build.gradle 文件之前，可以询问它有哪些任务可用:`gradle tasks`

您应该看到可用任务的列表。 假设你在一个没有 build.Gradle 文件的文件夹中运行 Gradle，你会看到一些非常基本的任务.

即使这些任务是可用的，如果没有项目构建配置，它们也不会提供太多价值。 当您充实 build.gradle 文件时，一些任务会更有用。 随着你添加插件 build.gradle，任务列表将会增加，所以你偶尔会想要再次运行任务来查看哪些任务是可用的。

说到添加插件，接下来你需要添加一个插件来实现基本的 Java 构建功能。

### Build Java code

Starting simple, create a very basic `build.gradle` file in the `<project folder>` you created at the beginning of this guide. Give it just just one line:

```groovy
apply plugin: 'java'
```

This single line in the build configuration brings a significant amount of power. Run gradle tasks again, and you see new tasks added to the list, including tasks for building the project, creating JavaDoc, and running tests.

您将经常使用 gradle 构建任务。 此任务编译、测试并将代码组装到一个 JAR 文件中。 你可以这样运行它:

```sh
gradle build
```

几秒钟后，“ BUILD SUCCESSFUL”表示构建已经完成。
要查看构建工作的结果，请查看构建文件夹。 其中你会发现几个目录，包括这三个显要的文件夹:

* classes. The project’s compiled .class files.
* reports. Reports produced by the build (such as test reports).
* libs. Assembled project libraries (usually JAR and/or WAR files).

### Declare dependencies

First, change HelloWorld.java to look like this:

```java
package hello;

import org.joda.time.LocalTime;

public class HelloWorld {
  public static void main(String[] args) {
    LocalTime currentTime = new LocalTime();
    System.out.println("The current local time is: " + currentTime);

    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}
```

For starters, you need to add a source for 3rd party libraries.

```groovy
repositories {
    mavenCentral()
}
```

现在我们已经为第三方库做好了准备，让我们声明一些。

```groovy
sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile "joda-time:joda-time:2.2"
    testCompile "junit:junit:4.12"
}
```

Finally, let’s specify the name for our JAR artifact.

```groovy
jar {
    baseName = 'gs-gradle'
    version =  '0.1.0'
}
```

Jar 块指定如何命名 JAR 文件。 在本例中，它将呈现 gs-gradle-0.1.0.jar。

现在，如果您运行 Gradle build，Gradle 应该解决来自 Maven Central 存储库的 Joda Time 依赖关系，构建将会成功。

### Build your project with Gradle Wrapper 使用 Gradle 包装器构建项目

Gradle 包装器是启动 Gradle 构建的首选方式。 它由一个用于 Windows 的批处理脚本和一个用于 OS x 和 Linux 的 shell 脚本组成。 这些脚本允许您运行 Gradle 构建，而不需要在系统上安装 Gradle。 这曾经是一些添加到你的构建文件，但它已经被折叠到 Gradle，所以不再有任何需要。 相反，您只需使用以下命令。

```sh
gradle wrapper --gradle-version 2.13
```

此任务完成后，您将注意到一些新文件。 这两个脚本位于文件夹的根目录中，而包装 jar 和属性文件已经添加到一个新的 gradle / wrapper 文件夹中。

```text
└── <project folder>
    └── gradlew
    └── gradlew.bat
    └── gradle
        └── wrapper
            └── gradle-wrapper.jar
            └── gradle-wrapper.properties
```

Gradle 包装器现在可用于构建您的项目。 将它添加到您的版本控制系统中，克隆您的项目的每个人都可以同样地构建它。 它可以用完全相同的方式作为一个安装版本的 Gradle。 运行包装器脚本来执行构建任务，就像你之前做的那样:

```sh
./gradlew build
```

第一次为指定的 Gradle 版本运行包装器时，它会下载并缓存该版本的 Gradle 二进制文件。 Gradle Wrapper 文件被设计用于源代码控制，这样任何人都可以构建这个项目，而无需首先安装和配置一个特定版本的 Gradle。

在这个阶段，你已经构建了你的代码，你可以在这里看到结果。

```text
build
├── classes
│   └── main
│       └── hello
│           ├── Greeter.class
│           └── HelloWorld.class
├── dependency-cache
├── libs
│   └── gs-gradle-0.1.0.jar
└── tmp
    └── jar
        └── MANIFEST.MF
```

类文件被捆绑在一起。 需要注意的是，即使您声明了 joda-time 作为一个依赖项，这里也不包括这个库。 而且 JAR 文件也不能运行。

为了使代码可运行，我们可以使用 gradle 的应用插件。 添加到你的 build.gradle 文件中。

```groovy
apply plugin: 'application'

mainClassName = 'hello.HelloWorld'
```

然后你就可以运行这个应用了！

```sh
$ ./gradlew run
:compileJava UP-TO-DATE
:processResources UP-TO-DATE
:classes UP-TO-DATE
:run
The current local time is: 16:16:20.544
Hello world!

BUILD SUCCESSFUL

Total time: 3.798 secs
```

把依赖关系捆绑起来需要更多的思考。 例如，如果我们要构建一个 WAR 文件，这种格式通常与第三方依赖关系中的打包相关，我们可以使用 gradle 的 WAR 插件。 如果您正在使用 springboot 并希望获得一个可运行的 JAR 文件，Spring-Boot-gradle-plugin 非常方便。 在这个阶段，gradle 对你的系统了解不够，无法做出选择。 但是现在，这已经足够开始使用 gradle 了。

下面是完整的 build.gradle 文件:

```groovy
apply plugin: 'java'
apply plugin: 'application'

mainClassName = 'hello.HelloWorld'

// tag::repositories[]
repositories {
    mavenCentral()
}
// end::repositories[]

// tag::jar[]
jar {
    baseName = 'gs-gradle'
    version =  '0.1.0'
}
// end::jar[]

// tag::dependencies[]
sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile "joda-time:joda-time:2.2"
    testCompile "junit:junit:4.12"
}
// end::dependencies[]
```

## 参考

Building Java Applications Sample
<https://docs.gradle.org/current/samples/sample_building_java_applications.html#run_the_application>
