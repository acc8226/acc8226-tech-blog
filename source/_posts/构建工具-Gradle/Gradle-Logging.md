日志是构建工具的主要“ UI”。 如果太冗长，那么真正的警告和问题很容易被隐藏起来。 另一方面，你需要相关的信息来判断事情是否出了问题。 Gradle 定义了6个日志级别，如日志级别所示。 除了通常可以看到的日志级别之外，还有两个 gradle 特定的日志级别。 这些层次是安静和生命周期。 后者是默认的，用于报告构建进度。


ERROR	
Error messages

QUIET	
Important information messages

WARNING	
Warning messages

LIFECYCLE	
Progress information messages

INFO	
Information messages

DEBUG	
Debug messages

> 无论使用何种日志级别，都会显示控制台的丰富组件(生成状态和进度区域中的工作)。 在 Gradle 4.0之前，这些富组件只显示在日志级 LIFECYCLE 或更低的级别。

## [Choosing a log level 选择一个日志级别](https://docs.gradle.org/6.3/userguide/logging.html#sec:choosing_a_log_level)

![](https://upload-images.jianshu.io/upload_images/1662509-f1ba115ee0dbdcf8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以使用日志级别命令行选项中显示的命令行开关来选择不同的日志级别。 您还可以使用 Gradle.properties 配置日志级别，请参见 Gradle 属性。 在 Stacktrace 命令行选项中，可以找到影响 Stacktrace 日志记录的命令行开关。

## [Writing your own log messages 写你自己的日志消息](https://docs.gradle.org/6.3/userguide/logging.html#sec:sending_your_own_log_messages)

在构建文件中登录的一个简单选项是将消息写入标准输出。 在 QUIET 日志级别，Gradle 将写入标准输出的任何内容重定向到其日志系统。

示例1. 使用 stdout 写日志消息
build.gradle
```
println 'A message which is logged at QUIET level'
```

Gradle 还为构建脚本提供了一个 Logger 属性，这是 Logger 的一个实例。 该接口扩展了 SLF4J Logger 接口，并添加了一些 Gradle 特定的方法。 下面是一个在构建脚本中如何使用的例子:

build.gradle

```
logger.quiet('An info log message which is always logged.')
logger.error('An error log message.')
logger.warn('A warning log message.')
logger.lifecycle('A lifecycle info log message.')
logger.info('An info log message.')
logger.debug('A debug log message.')
logger.trace('A trace log message.')
```

使用典型的 SLF4J 模式将占位符替换为日志消息中的实际值。

build.gradle

```
logger.info('A {} log message', 'info')
```

您还可以从构建中使用的其他类(例如 buildSrc 目录中的类)中连接到 Gradle 的日志系统。 只需使用 SLF4J 记录器。 您可以像在构建脚本中使用提供的记录器一样使用这个记录器。

```
import org.slf4j.LoggerFactory

def slf4jLogger = LoggerFactory.getLogger('some-logger')
slf4jLogger.info('An info log message logged using SLF4j')
```

## [Logging from external tools and libraries 从外部工具和库中记录日志](https://docs.gradle.org/6.3/userguide/logging.html#sec:external_tools)

在内部，Gradle 使用 Ant 和 Ivy。 两者都有自己的记录系统。 Gradle 将他们的日志输出重定向到 Gradle 日志系统。 从 ant / ivy 日志级别到 Gradle 日志级别有1:1的映射，但 ant / ivy TRACE 日志级别映射到 Gradle DEBUG 日志级别。 这意味着默认的 Gradle 日志级别不会显示任何 ant / ivy 输出，除非它是一个错误或警告。

现在仍然有许多工具使用标准输出进行日志记录。 默认情况下，Gradle 将标准输出重定向到 QUIET 日志级别，将标准错误重定向到 ERROR 级别。 此行为是可配置的。 项目对象提供了一个 LoggingManager，它允许您在评估构建脚本时更改标准输出或错误重定向到的日志级别。

```
logging.captureStandardOutput LogLevel.INFO
println 'A message which is logged at INFO level'
```

若要在任务执行期间更改标准输出或错误的日志级别，任务还提供 LoggingManager。
```
task logInfo {
    logging.captureStandardOutput LogLevel.INFO
    doFirst {
        println 'A task message which is logged at INFO level'
    }
}
```

还提供了与 javautillogging、 Jakarta Commons Logging 和 Log4j 日志工具包的集成。 您的构建类使用这些日志工具包写入的任何日志消息都将被重定向到 Gradle 的日志系统。

## [Changing what Gradle logs 修改 Gradle 日志](https://docs.gradle.org/6.3/userguide/logging.html#sec:changing_what_gradle_logs)

你可以用自己的日志界面替换 Gradle 的大部分日志界面。 例如，如果您希望以某种方式自定义 UI ——记录更多或更少的信息，或更改格式，则可以这样做。 您可以使用 Gradle.useLogger (java.lang。 对象)方法。 这可以从构建脚本、 init 脚本或通过嵌入 API 访问。 注意，这将完全禁用 Gradle 的默认输出。 下面是一个 init 脚本示例，它改变了记录任务执行和生成完成的方式。

customLogger.init.gradle
```
useLogger(new CustomEventLogger())

class CustomEventLogger extends BuildAdapter implements TaskExecutionListener {

    void beforeExecute(Task task) {
        println "[$task.name]"
    }

    void afterExecute(Task task, TaskState state) {
        println()
    }

    void buildFinished(BuildResult result) {
        println 'build completed'
        if (result.failure != null) {
            result.failure.printStackTrace()
        }
    }
}
```

```
$ gradle -I customLogger.init.gradle build

> Task :compile
[compile]
compiling source


> Task :testCompile
[testCompile]
compiling test source


> Task :test
[test]
running unit tests


> Task :build
[build]

build completed
3 actionable tasks: 3 executed
```

记录器可以实现下面列出的任何侦听器接口。 注册日志程序时，只替换它实现的接口的日志记录。 其他接口的日志记录保持不变。 您可以在 Build 生命周期事件中找到关于侦听器接口的更多信息。

*   [BuildListener](https://docs.gradle.org/6.3/javadoc/org/gradle/BuildListener.html)

*   [ProjectEvaluationListener](https://docs.gradle.org/6.3/javadoc/org/gradle/api/ProjectEvaluationListener.html)

*   [TaskExecutionGraphListener](https://docs.gradle.org/6.3/javadoc/org/gradle/api/execution/TaskExecutionGraphListener.html)

*   [TaskExecutionListener](https://docs.gradle.org/6.3/javadoc/org/gradle/api/execution/TaskExecutionListener.html)

*   [TaskActionListener](https://docs.gradle.org/6.3/javadoc/org/gradle/api/execution/TaskActionListener.html)
