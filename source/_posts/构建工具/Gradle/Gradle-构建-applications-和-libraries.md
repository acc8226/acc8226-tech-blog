## 构建 Java applications
```
$ mkdir demo
$ cd demo
```

在新项目目录中，运行 init 任务，并在提示时选择 java-application 项目类型。 对于其他问题，按回车键使用默认值。
```
$ gradle init
> Task :wrapper

Select type of project to generate:
  1: basic
  2: application
  3: library
  4: Gradle plugin
Enter selection (default: basic) [1..4] 2

Select implementation language:
  1: C++
  2: Groovy
  3: Java
  4: Kotlin
  5: Swift
Enter selection (default: Java) [1..5] 3

Select build script DSL:
  1: Groovy
  2: Kotlin
Enter selection (default: Groovy) [1..2] 1

Select test framework:
  1: JUnit 4
  2: TestNG
  3: Spock
  4: JUnit Jupiter
Enter selection (default: JUnit 4) [1..4]

Project name (default: demo):

Source package (default: demo):


> Task :init
Get more help with your project: https://docs.gradle.org/5.4.1/userguide/tutorial_java_projects.html

BUILD SUCCESSFUL
2 actionable tasks: 2 executed
```

### [Execute the build 执行构建](https://guides.gradle.org/building-java-applications/#execute_the_build)

若要生成项目，请运行生成任务。 您可以使用常规的 `gradle ` 命令，但是当项目包含`wrapper`脚本时，使用它被认为是一种好的形式。

> The first time you run the wrapper script, 第一次运行包装器脚本时,`gradlew`, there may be a delay while that version of ，可能会有一个延迟，而该版本的gradle is downloaded and stored locally in your 下载并存储在您的~/.gradle/wrapper/dists folder. 文件夹

第一次运行构建时，Gradle 将检查在 ~ / 下的缓存中是否已经有 Guava 和 JUnit 库。 格莱德目录。 如果没有，图书馆将被下载并存储在那里。 下次运行构建时，将使用缓存的版本。 生成任务编译类、运行测试并生成测试报告。

您可以通过打开位于 `build / reports / tests / test / index. HTML` 中的 HTML 输出文件来查看测试报告。

### [Run the application 运行应用程序](https://guides.gradle.org/building-java-applications/#run_the_application)

因为 Gradle 构建使用了 Application 插件，所以可以从命令行运行应用程序。 首先，使用 tasks task 查看插件添加了哪些任务。

```
$ ./gradlew tasks
:tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Application tasks
-----------------
run - Runs this project as a JVM application

// ... many other tasks ...
```

Run 任务告诉 Gradle 在分配给 mainClassName 属性的类中执行 main 方法。

```
$ ./gradlew run
> Task :compileJava UP-TO-DATE
> Task :processResources NO-SOURCE
> Task :classes UP-TO-DATE

> Task :run
Hello world.

BUILD SUCCESSFUL
2 actionable tasks: 1 executed, 1 up-to-date
```

## 构建 Java libraries
```
$ mkdir demo
$ cd demo
```

```
$ gradle init
> Task :wrapper

Select type of project to generate:
  1: basic
  2: application
  3: library
  4: Gradle plugin
Enter selection (default: basic) [1..4] 3

Select implementation language:
  1: C++
  2: Groovy
  3: Java
  4: Kotlin
  5: Scala
  6: Swift
Enter selection (default: Java) [1..6] 3

Select build script DSL:
  1: Groovy
  2: Kotlin
Enter selection (default: Groovy) [1..2] 1

Select test framework:
  1: JUnit 4
  2: TestNG
  3: Spock
  4: JUnit Jupiter
Enter selection (default: JUnit 4) [1..4]

Project name (default: demo):

Source package (default: demo):


> Task :init
Get more help with your project: https://docs.gradle.org/5.0/userguide/java_library_plugin.html

BUILD SUCCESSFUL
2 actionable tasks: 2 executed
```


### [Assemble the library JAR 组装库 JAR](https://guides.gradle.org/building-java-libraries/#assemble_the_library_jar)

```
$ ./gradlew build
> Task :compileJava
> Task :processResources NO-SOURCE
> Task :classes
> Task :jar
> Task :assemble
> Task :compileTestJava
> Task :processTestResources NO-SOURCE
> Task :testClasses
> Task :test
> Task :check
> Task :build

BUILD SUCCESSFUL
4 actionable tasks: 4 executed
```

您可以在 build / libs 目录中找到新打包的 JAR 文件，其名称为 demo.JAR。 通过运行以下命令验证存档是否有效:
```
$ jar tf build/libs/demo.jar
META-INF/
META-INF/MANIFEST.MF
demo/
demo/Library.class
```

所有这些都不需要在构建脚本中进行任何额外的配置，因为 Gradle 的 java 库插件假设您的项目源代码是按照传统的项目布局安排的。 如果您希望按照用户手册中的描述自定义项目布局，则可以对其进行自定义。

### [Customize the library JAR 自定义库 JAR](https://guides.gradle.org/building-java-libraries/#customize_the_library_jar)

您通常希望 JAR 文件的名称包含库版本。 这可以通过在构建脚本中设置顶级版本属性轻松实现，如下所示:

build.gradle中增加
```
version = '0.1.0'
```

另一个常见的需求是自定义清单文件，通常是通过添加一个或多个属性。 让我们通过配置 jar 任务在清单文件中包含库名和版本。 在构建脚本的末尾添加以下内容:
```
jar {
    manifest {
        attributes('Implementation-Title': project.name,
                   'Implementation-Version': project.version)
    }
}
```

为了确认这些更改正常工作，再次运行 JAR 任务.
```
$ ./gradlew jar
```

> **了解更多关于配置 jar 的信息**
> 清单只是可以在 jar 任务上配置的许多属性之一。 要获得完整的列表，请参阅 Gradle Language Reference 的 Jar 部分以及 Gradle 用户手册的 Jar 和 Creating Archives 部分

### [Adding API documentation 添加 API 文档](https://guides.gradle.org/building-java-libraries/#adding_api_documentation)

Java 库插件通过 javadoc 任务内置支持 Java 的 API 文档工具。

Build Init 插件生成的代码已经在 Library.java 文件上放置了注释。 将注释修改为 javadoc 标记。

```
$ ./gradlew javadoc
```

您可以通过打开 build / docs / javadoc / index. HTML 文件来查看生成的 javadoc 文件。
