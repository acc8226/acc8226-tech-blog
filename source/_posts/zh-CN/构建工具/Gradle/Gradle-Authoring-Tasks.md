---
title: Gradle-Authoring-Tasks
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

在入门教程中，您学习了如何创建简单的任务。 稍后您还学习了如何向这些任务添加额外的行为，并学习了如何在任务之间创建依赖关系。 这一切都是关于简单的任务，但 Gradle 把任务的概念更进一步。 Gradle 支持增强型任务，这些任务具有自己的属性和方法。 这与您习惯使用 Ant 目标的情况大不相同。 这些强化的任务要么是你提供的，要么是内置在 Gradle 的。

## [Task outcomes 任务结果](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:task_outcomes)

当 Gradle 执行一个任务时，它可以通过控制台 UI 和 toolingapi 将任务标记为不同的结果。 这些标签基于任务是否有要执行的操作，是否应该执行这些操作，是否确实执行了这些操作，以及这些操作是否做了任何更改。

## [Defining tasks 定义任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:defining_tasks)

在本章中，我们已经看到了如何使用任务名称的字符串来定义任务。 这种风格有一些变化，您可能需要在某些情况下使用。

1. 使用任务名的字符串定义任务

```groovy
task('hello') {
    doLast {
        println "hello"
    }
}

task('copy', type: Copy) {
    from(file('srcDir'))
    into(buildDir)
}
```

2. 使用 tasks
```
tasks.create('hello') {
    doLast {
        println "hello"
    }
}

tasks.create('copy', Copy) {
    from(file('srcDir'))
    into(buildDir)
}
```

最后，还有针对 Groovy 和 Kotlin DSL 的语言特定语法:
```
// Using Groovy dynamic keywords

task(hello) {
    doLast {
        println "hello"
    }
}

task(copy, type: Copy) {
    from(file('srcDir'))
    into(buildDir)
}
```

## [Locating tasks 定位任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:locating_tasks)
通常需要定位在生成文件中定义的任务，例如，配置它们或将它们用于依赖项。 有很多方法可以做到这一点。 首先，就像定义任务一样，Groovy 和 Kotlin DSL 也有特定于语言的语法:
```
println hello.name
println project.hello.name

println copy.destinationDir
println project.copy.destinationDir
```

 通过任务集合访问任务
```
println tasks.hello.name
println tasks.named('hello').get().name

println tasks.copy.destinationDir
println tasks.named('copy').get().destinationDir
```

通过路径访问任务

```groovy
project(':projectA') {
    task hello
}

task hello

println tasks.getByPath('hello').path
println tasks.getByPath(':hello').path
println tasks.getByPath('projectA:hello').path
println tasks.getByPath(':projectA:hello').path
```

## [Configuring tasks 配置任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:configuring_tasks)

作为一个例子，让我们看看 Gradle 提供的 Copy 任务。 要为生成创建一个 Copy 任务，您可以在生成脚本中声明:

```
task myCopy(type: Copy)
```

这将创建一个没有默认行为的复制任务。 任务可以使用其 API 进行配置(请参阅复制)。 下面的示例显示了实现相同配置的几种不同方法。

为了清楚起见，请认识到这个任务的名称是“ myCopy” ，但它的类型是“ Copy”。 您可以具有同一类型的多个任务，但名称不同。 您会发现，这为您实现跨特定类型的所有任务的横切关注点提供了很大的能力。

1. 使用 API 配置任务

```
Copy myCopy = tasks.getByName("myCopy")
myCopy.from 'resources'
myCopy.into 'target'
myCopy.include('**/*.txt', '**/*.xml', '**/*.properties')
```

这类似于我们在 Java 中配置对象的方式。 每次都必须在配置语句中重复上下文(myCopy)。 这是多余的，读起来不是很好。

还有另一种配置任务的方法。 它还保留了背景，可以说是最具可读性的。 它通常是我们的最爱。
2. 使用 DSL 特定语法配置任务
```
// Configure task using Groovy dynamic task configuration block
myCopy {
   from 'resources'
   into 'target'
}
myCopy.include('**/*.txt', '**/*.xml', '**/*.properties')
```

这对任何任务都适用。 Task access 只是 tasks.named ()(Kotlin)或 tasks.getByName ()(Groovy)方法的快捷方式。 需要注意的是，这里使用的块用于配置任务，并且在任务执行时不进行计算。

3. 用配置块定义任务
```
task copy(type: Copy) {
   from 'resources'
   into 'target'
   include('**/*.txt', '**/*.xml', '**/*.properties')
}
```

>  **不要忘记构建阶段**
> 任务同时具有配置和操作。 在使用 doLast 时，您只需使用一个快捷方式来定义一个操作。 任务的配置部分中定义的代码将在构建的配置阶段执行，而不管任务的目标是什么。 有关构建生命周期的更多细节，请参见构建生命周期。

## [Passing arguments to a task constructor 将参数传递给任务构造函数](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:passing_arguments_to_a_task_constructor)
与在创建 Task 后配置可变属性相反，您可以将参数值传递给 Task 类的构造函数。 为了将值传递给 Task 构造函数，必须用@javax 注释相关的构造函数。 注入。

## [Adding dependencies to a task 向任务添加依赖项](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:adding_dependencies_to_tasks)

有几种方法可以定义任务的依赖关系。 在“任务依赖项”中，介绍了如何使用任务名称定义依赖项。 任务名称可以引用与任务相同的项目中的任务，也可以引用其他项目中的任务。 若要引用另一个项目中的任务，请在任务名称前面加上它所属项目的路径作为前缀。 下面是一个例子，它增加了一个从 projectA: tasxx 到 projectB: taskY 的依赖项:

```groovy
project('projectA') {
    task taskX {
        dependsOn ':projectB:taskY'
        doLast {
            println 'taskX'
        }
    }
}

project('projectB') {
    task taskY {
        doLast {
            println 'taskY'
        }
    }
}
```

```text
> gradle -q taskX
taskY
taskX
```

2. 使用任务对象添加依赖项

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}

task taskY {
    doLast {
        println 'taskY'
    }
}

taskX.dependsOn taskY
```

```sh
> gradle -q taskX
taskY
taskX
```

对于更高级的用途，可以使用惰性块定义任务依赖项。 计算时，块将传递正在计算其依赖关系的任务。 惰性块应该返回单个 Task 或 Task 对象的集合，然后将其视为任务的依赖项。 下面的示例为名称以 lib 开头的项目中的所有任务添加从 tasxx 的依赖项:

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}

// Using a Groovy Closure
taskX.dependsOn {
    tasks.findAll { task -> task.name.startsWith('lib') }
}

task lib1 {
    doLast {
        println 'lib1'
    }
}

task lib2 {
    doLast {
        println 'lib2'
    }
}

task notALib {
    doLast {
        println 'notALib'
    }
}
```

## [Ordering tasks 安排任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:ordering_tasks)

在某些情况下，控制2个任务的执行顺序是有用的，而不需要在这些任务之间引入明确的依赖关系。 任务排序和任务依赖项之间的主要区别在于，排序规则不影响将执行哪些任务，而只影响执行这些任务的顺序。

有两个排序规则可用: “必须运行后”和“应该运行后”。

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}
task taskY {
    doLast {
        println 'taskY'
    }
}
taskY.mustRunAfter taskX
```

```
> gradle -q taskY taskX
taskX
taskY
```

添加一个应该在任务排序后运行

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}
task taskY {
    doLast {
        println 'taskY'
    }
}
taskY.shouldRunAfter taskX
```

```
> gradle -q taskY taskX
taskX
taskY
```

请注意，“ B.mustRunAfter (a)”或“ B.shouldRunAfter (a)”并不意味着任务之间存在任何执行依赖关系:

* 可以独立执行任务 a 和任务 b。 只有当两个任务都计划执行时，排序规则才有效。
* 当使用 -- continue 运行时，b 可以在 a 失败的情况下执行。

如果任务引入了一个订购周期，则忽略“应该在后面运行”的任务排序

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}
task taskY {
    doLast {
        println 'taskY'
    }
}
task taskZ {
    doLast {
        println 'taskZ'
    }
}
taskX.dependsOn taskY
taskY.dependsOn taskZ
taskZ.shouldRunAfter taskX
```

```
> gradle -q taskX
taskZ
taskY
taskX
```

## [Adding a description to a task 向任务添加描述](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:adding_a_description_to_a_task)

```groovy
task copy(type: Copy) {
   description 'Copies the resource directory to the target directory.'
   from 'resources'
   into 'target'
   include('**/*.txt', '**/*.xml', '**/*.properties')
}
```

## [Skipping tasks 跳过任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:skipping_tasks)

Gradle 提供了多种跳过任务执行的方法。

### [Using a predicate 使用谓词](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:using_a_predicate)

您可以使用 onlyIf ()方法将谓词附加到任务。 只有在谓词计算结果为 true 时才执行任务的操作。 将谓词实现为闭包。 闭包作为参数传递任务，如果任务应该执行，则返回 true，如果应该跳过任务，则返回 false。 谓词是在任务即将执行之前计算的。

```groovy
task hello {
    doLast {
        println 'hello world'
    }
}

hello.onlyIf { !project.hasProperty('skipHello') }
```

```
> gradle hello -PskipHello
> Task :hello SKIPPED

BUILD SUCCESSFUL in 0s
```

### [Using StopExecutionException 使用 StopExecutionException](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:using_stopexecutionexception)

如果跳过任务的逻辑不能用谓词表示，则可以使用 StopExecutionException。 如果该异常是由某个操作引发的，则跳过该操作的进一步执行以及该任务的任何后续操作的执行。 生成继续执行下一个任务。

```groovy
task compile {
    doLast {
        println 'We are doing the compile.'
    }
}

compile.doFirst {
    // Here you would put arbitrary conditions in real life.
    // But this is used in an integration test so we want defined behavior.
    if (true) { throw new StopExecutionException() }
}
task myTask {
    dependsOn('compile')
    doLast {
        println 'I am not affected'
    }
}
```

### [Enabling and disabling tasks 启用和禁用任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:enabling_and_disabling_tasks)

每个任务都有一个默认为 true 的启用标志。 将其设置为 false 可以防止执行任务的任何操作。 禁用的任务将被标记为“跳过”。

```groovy
task disableMe {
    doLast {
        println 'This should not be printed if the task is disabled.'
    }
}
disableMe.enabled = false
```

### [Task timeouts 任务超时](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:task_timeouts)

每个任务都有一个超时属性，可用于限制其执行时间。 当任务超时时，其任务执行线程将被中断。 任务将被标记为失败。 终结器任务仍将运行。 如果使用了 -- continue，则其他任务可以在它之后继续运行。 不对中断作出反应的任务不能超时。 Gradle 的所有内置任务都会及时响应超时。

```groovy
task hangingTask() {
    doLast {
        Thread.sleep(100000)
    }
    timeout = Duration.ofMillis(500)
}
```

* [Up-to-date checks (AKA Incremental Build) 最新检查(又名增量构建)](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:up_to_date_checks)

任何构建工具的一个重要部分是能够避免执行已经完成的工作。 考虑编译的过程。 一旦你的源文件已经被编译，就不需要重新编译它们，除非有什么变化影响了输出，比如修改源文件或者删除输出文件。 而且编译可能会花费大量的时间，因此在不需要时跳过这一步可以节省大量的时间。

Gradle 通过一个称为增量构建的特性支持这种开箱即用的行为。 几乎可以肯定您已经看到它在运行: 当您运行构建时，几乎每次 UP-TO-DATE 文本出现在任务名称旁边时，它都处于活动状态。 任务结果在任务结果中描述。

## [Task rules 任务规则](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:task_rules)

有时您希望有一个任务，其行为取决于大量或无限数量的参数值范围。 提供这些任务的一个非常好的表达方式是任务规则:

```groovy
tasks.addRule("Pattern: ping<ID>") { String taskName ->
    if (taskName.startsWith("ping")) {
        task(taskName) {
            doLast {
                println "Pinging: " + (taskName - 'ping')
            }
        }
    }
}
```

```
> gradle -q pingServer1
Pinging: Server1
```

String 参数用作规则的描述，这在 gradle 任务中显示。

规则不仅在从命令行调用任务时使用。 你也可以在基于规则的任务上创建 dependsOn 关系:

```groovy
tasks.addRule("Pattern: ping<ID>") { String taskName ->
    if (taskName.startsWith("ping")) {
        task(taskName) {
            doLast {
                println "Pinging: " + (taskName - 'ping')
            }
        }
    }
}

task groupPing {
    dependsOn pingServer1, pingServer2
}
```

> gradle -q groupPing
Pinging: Server1
Pinging: Server2

如果您运行“ gradle-q tasks” ，您不会找到名为“ pingServer1”或“ pingServer2”的任务，但是这个脚本正在基于运行这些任务的请求执行逻辑。

## [Finalizer tasks 终结器任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:finalizer_tasks)

当计划运行最终完成的任务时，终结器任务将自动添加到任务图中。

```groovy
task taskX {
    doLast {
        println 'taskX'
    }
}
task taskY {
    doLast {
        println 'taskY'
    }
}

taskX.finalizedBy taskY
```

即使最终确定的任务失败，也将执行终结器任务。

## [Lifecycle tasks 生命周期任务](https://docs.gradle.org/6.3/userguide/more_about_tasks.html#sec:lifecycle_tasks)

生命周期任务是本身不做工作的任务。 它们通常没有任何任务操作。

Base Plugin 定义了几个标准的生命周期任务，比如构建、组装和检查。 所有的核心语言插件，比如 Java 插件，都应用基础插件，因此具有相同的生命周期任务的基础集。

除非生命周期任务具有动作，否则其结果由其任务依赖性决定。 如果这些依赖项中的任何一个被执行，那么生命周期任务将被认为是 EXECUTED。 如果所有任务依赖项都是最新的、跳过的或来自缓存的，则生命周期任务将被视为 UP-TO-DATE。
