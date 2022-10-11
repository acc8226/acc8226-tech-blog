## [Projects and tasks 项目和任务](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:projects_and_tasks)

每个 Gradle 构建都由一个或多个项目组成。一个项目代表什么取决于你在 Gradle 上做什么。例如，一个项目可能表示一个库 JAR 或一个 web 应用程序。它可以表示从其他项目生成的 jar 组装起来的发行版 ZIP。一个项目并不一定代表要构建的东西。它可能代表要做的事情，比如将应用程序部署到登台或生产环境。不要担心，如果这看起来有点含糊现在。Gradle 的按惯例构建支持为项目增加了一个更具体的定义。

Gradle 可以在一个项目上完成的工作由一个或多个任务定义。任务表示构建执行的某些原子工作。这可能是编译一些类、创建一个 JAR、生成 Javadoc 或者将一些存档发布到存储库。

通常，任务是通过应用插件提供的，这样你就不必自己定义它们了。尽管如此，为了让您了解什么是任务，我们将在本章讨论用一个项目在构建中定义一些简单的任务。

## [Hello world 你好，世界](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:hello_world)
要进行尝试，请创建以下名为 build.gradle 的构建脚本。

```groovy
task hello {
    doLast {
        println 'Hello world!'
    }
}
```

在命令行 shell 中，移动到包含目录并使用 `gradle-q hello` 执行构建脚本:

> 本用户指南中的大多数示例都使用 -q 命令行选项运行。 这会抑制 Gradle 的日志消息，因此只显示任务的输出。 这使得用户指南中的示例输出更加清晰。 如果你不想使用这个选项，你就不需要使用它。 有关影响 Gradle 输出的命令行选项的详细信息，请参阅日志记录。

```
> gradle -q hello
Hello world!
```

这是怎么回事？ 这个构建脚本定义一个称为 hello 的任务，并向其添加一个操作。 当运行 Gradle hello 时，Gradle 执行 hello 任务，而 hello 任务又执行所提供的操作。 操作只是一个包含要执行的代码的块。

## [Build scripts are code 构建脚本就是代码](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:build_scripts_are_code)

Gradle 的构建脚本为您提供了 Groovy 和 Kotlin 的全部功能:
```
task upper {
    doLast {
        String someString = 'mY_nAmE'
        println "Original: $someString"
        println "Upper case: ${someString.toUpperCase()}"
    }
}

task count {
    doLast {
        4.times { print "$it " }
    }
}
```

## [Task dependencies 任务依赖性](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:task_dependencies)

正如您可能已经猜到的，您可以声明依赖于其他任务的任务。
```
task hello {
    doLast {
        println 'Hello world!'
    }
}
task intro {
    dependsOn hello
    doLast {
        println "I'm Gradle"
    }
}
```

 懒惰依赖——另一个任务还不存在
```
task taskX {
    dependsOn 'taskY'
    doLast {
        println 'taskX'
    }
}
task taskY {
    doLast {
        println 'taskY'
    }
}
```

## [Dynamic tasks 动态任务](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:dynamic_tasks)

Groovy 或 Kotlin 的强大功能不仅仅用于定义任务的功能。 例如，您还可以使用它动态创建任务。

```
4.times { counter ->
    task "task$counter" {
        doLast {
            println "I'm task number $counter"
        }
    }
}
```

```
> gradle -q task1
I'm task number 1
```

## [Manipulating existing tasks 操纵现有的任务](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:manipulating_existing_tasks)

一旦创建了任务，就可以通过 API 访问它们。 例如，您可以使用它在运行时动态地向任务添加依赖项。 蚂蚁不允许这样的事情发生。
```
4.times { counter ->
    task "task$counter" {
        doLast {
            println "I'm task number $counter"
        }
    }
}
task0.dependsOn task2, task3
```

```
> gradle -q task0
I'm task number 2
I'm task number 3
I'm task number 0
```

## Example 9. Accessing a task via API - adding behaviour  通过 API 添加行为访问任务
```
task hello {
    doLast {
        println 'Hello Earth'
    }
}
hello.doFirst {
    println 'Hello Venus'
}
hello.configure {
    doLast {
        println 'Hello Mars'
    }
}
hello.configure {
    doLast {
        println 'Hello Jupiter'
    }
}
```

```
> gradle -q hello
Hello Venus
Hello Earth
Hello Mars
Hello Jupiter
```

Dofirst 和 doast 调用可以多次执行。 它们将一个动作添加到任务的动作列表的开始或结束处。 执行任务时，按顺序执行操作列表中的操作。

## [Groovy DSL shortcut notations Groovy DSL 快捷符号](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:shortcut_notations)
有一种方便的符号可用于访问现有任务。 每个任务都作为构建脚本的属性可用:
```
task hello {
    doLast {
        println 'Hello world!'
    }
}
hello.doLast {
    println "Greetings from the $hello.name task."
}
```

> gradle -q hello
Hello world!
Greetings from the hello task.

## [Extra task properties 额外的任务属性](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:extra_task_properties)
您可以将自己的属性添加到任务中。 若要添加名为 myProperty 的属性，请将 ext.myProperty 设置为初始值。 从那时起，可以像预定义的任务属性那样读取和设置该属性。
```
tasks.register("myTask") {
    extra["myProperty"] = "myValue"
}

tasks.register("printTaskProperties") {
    doLast {
        println(tasks["myTask"].extra["myProperty"])
    }
}
```

```
> gradle -q printTaskProperties
myValue
```

额外属性并不仅限于任务。您可以在[Extra properties](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:extra_properties) 中了解更多相关信息。

## [Using Ant Tasks 使用 Ant 任务](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:using_ant_tasks_tutorial)

Ant 是 Gradle 的一等公民。 通过简单地依赖 Groovy，Gradle 为 Ant 任务提供了优秀的集成。 Groovy 附带了神奇的 AntBuilder。 在 Gradle 使用 Ant 任务比在 build.xml 文件中使用 Ant 任务更方便、更强大。 而且在 Kotlin 也可以使用。 从下面的示例中，您可以学习如何执行 Ant 任务以及如何访问 Ant 属性:

```
task loadfile {
    doLast {
        def files = file('./antLoadfileResources').listFiles().sort()
        files.each { File file ->
            if (file.isFile()) {
                ant.loadfile(srcFile: file, property: file.name)
                println " *** $file.name ***"
                println "${ant.properties[file.name]}"
            }
        }
    }
}
```

```
> gradle -q loadfile
 *** agile.manifesto.txt ***
Individuals and interactions over processes and tools
Working software over comprehensive documentation
Customer collaboration  over contract negotiation
Responding to change over following a plan
 *** gradle.manifesto.txt ***
Make the impossible possible, make the possible easy and make the easy elegant.
(inspired by Moshe Feldenkrais)
```

## [Using methods 使用方法](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:using_methods)

使用方法组织构建逻辑
```
task checksum {
    doLast {
        fileList('./antLoadfileResources').each { File file ->
            ant.checksum(file: file, property: "cs_$file.name")
            println "$file.name Checksum: ${ant.properties["cs_$file.name"]}"
        }
    }
}

task loadfile {
    doLast {
        fileList('./antLoadfileResources').each { File file ->
            ant.loadfile(srcFile: file, property: file.name)
            println "I'm fond of $file.name"
        }
    }
}

File[] fileList(String dir) {
    file(dir).listFiles({file -> file.isFile() } as FileFilter).sort()
}
```

```
Output of 产量gradle -q loadfile
> gradle -q loadfile
I'm fond of agile.manifesto.txt
I'm fond of gradle.manifesto.txt
```

## [Default tasks 默认任务](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:default_tasks)

Gradle 允许您定义一个或多个在没有指定其他任务的情况下执行的默认任务。
```
defaultTasks 'clean', 'run'

task clean {
    doLast {
        println 'Default Cleaning!'
    }
}

task run {
    doLast {
        println 'Default Running!'
    }
}

task other {
    doLast {
        println "I'm not a default task!"
    }
}
```

```
> gradle -q
Default Cleaning!
Default Running!
```

这相当于运行 gradle clean run。 在多项目构建中，每个子项目都可以有自己特定的默认任务。 如果子项目未指定默认任务，则使用父项目的默认任务(如果已定义)。

## [Configure by DAG 配置由 DAG 完成](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#configure-by-dag)

正如我们后面详细描述的(请参阅构建生命周期) ，Gradle 有一个配置阶段和一个执行阶段。 在配置阶段之后，Gradle 知道应该执行的所有任务。 Gradle 为你提供了一个利用这些信息的钩子。 这样做的用例是检查发布任务是否在要执行的任务之中。 根据这一点，您可以为某些变量分配不同的值。

在下面的示例中，分发和发布任务的执行导致 version 变量的值不同。

```
task distribution {
    doLast {
        println "We build the zip with version=$version"
    }
}

task release {
    dependsOn 'distribution'
    doLast {
        println 'We release now'
    }
}

gradle.taskGraph.whenReady { taskGraph ->
    if (taskGraph.hasTask(":release")) {
        version = '1.0'
    } else {
        version = '1.0-SNAPSHOT'
    }
}
```

```
> gradle -q distribution
We build the zip with version=1.0-SNAPSHOT
```

```
> gradle -q release
We build the zip with version=1.0
We release now
```

重要的是，`whenReady ` 在执行发布任务之前影响发布任务。 即使发布任务不是 *primary* 任务(即，传递给 gradle 命令的任务) ，这种方法也可以工作。

> 此示例之所以有效，是因为版本值只在执行时读取。 在实际的构建中使用类似的构造时，您必须确保在配置期间不要急切地读取值。 否则，在配置和执行之间，构建可能对属性使用不同的值。

## [External dependencies for the build script 构建脚本的外部依赖项](https://docs.gradle.org/6.3/userguide/tutorial_using_tasks.html#sec:build_script_external_dependencies)

如果构建脚本需要使用外部库，可以将它们添加到构建脚本本身中的脚本类路径中。 您可以使用 buildscript ()方法进行此操作，传入一个声明构建脚本类路径的块。

```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath group: 'commons-codec', name: 'commons-codec', version: '1.2'
    }
}
```

传递给 buildscript ()方法的块配置一个 scriptandler 实例。 通过向类路径配置添加依赖项，可以声明构建脚本类路径。 这与声明 Java 编译类路径的方式相同，例如。 您可以使用除项目依赖项以外的任何依赖项类型。

在声明了构建脚本类路径之后，您可以像使用类路径中的任何其他类一样使用构建脚本中的类。 下面的示例添加到前面的示例中，并使用来自构建脚本类路径的类。

具有外部依赖关系的构建脚本
```
import org.apache.commons.codec.binary.Base64

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath group: 'commons-codec', name: 'commons-codec', version: '1.2'
    }
}

task encode {
    doLast {
        def byte[] encodedString = new Base64().encode('hello world\n'.getBytes())
        println new String(encodedString)
    }
}
```

```
> gradle -q encode
aGVsbG8gd29ybGQK
```

对于多项目构建，项目的 buildscript ()方法声明的依赖关系可用于其所有子项目的构建脚本。

构建脚本依赖可能是 Gradle 插件。请参考使用 Gradle 插件获取更多关于 Gradle 插件的信息。

每个项目都自动具有 BuildEnvironmentReportTask 类型的 buildEnvironment 任务，可以调用该任务来报告构建脚本依赖关系的解析。
