## [The Gradle build language Gradle 构建语言](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:the_gradle_build_language)

Gradle 提供了一种领域特定语言(DSL)来描述构建，这种构建语言在 Groovy 和 Kotlin 都可以使用。

Groovy 构建脚本可以包含任何 Groovy 语言元素。 Kotlin 构建脚本可以包含任何 Kotlin 语言元素。 Gradle 假设每个构建脚本都使用 UTF-8进行编码。

## [The Project API 电视宣传短片](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:project_api)

实际上，构建脚本中的几乎所有顶级属性和块都是 `Project` api 的一部分。 为了演示，看看这个示例构建脚本，它输出项目的名称，该脚本通过 Project.name 属性访问:

```
println name
println project.name
```

```
> gradle -q check
projectApi
projectApi
```

两个 println 语句打印出相同的属性。 第一个方法使用顶层对 Project 对象的 name 属性的引用。 另一个语句使用任何生成脚本可用的项目属性，该脚本返回关联的 Project 对象。 只有当您定义的属性或方法与 Project 对象的成员具有相同的名称时，才需要使用 Project 属性。

| Name | Type | Default Value |
| --- | --- | --- |
| `project` | [Project](https://docs.gradle.org/6.3/dsl/org.gradle.api.Project.html) | The `Project` instance
| `name` | `String` | The name of the project directory.
|`path` | `String` | The absolute path of the project.
|`description` | `String` | A description for the project.
| `projectDir` | `File` | The directory containing the build script.
|`buildDir` | `File` | `*projectDir*/build`
| `group` | `Object` | `unspecified`
| `version` | `Object` | `unspecified`
 |`ant` | [AntBuilder](https://docs.gradle.org/6.3/javadoc/org/gradle/api/AntBuilder.html) | An `AntBuilder` instance

> 这里描述的构建脚本针对 Project 对象。 还有分别针对 Settings 和 Gradle 对象的设置脚本和 init 脚本。

## [The script API 脚本 API](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:the_script_api)

当 Gradle 执行 Groovy 构建脚本时(。 Gradle) ，它将脚本编译成一个实现 Script 的类。 这意味着脚本接口声明的所有属性和方法在脚本中都可用。

当 Gradle 执行 Kotlin 构建脚本时(。 Kts) ，它将脚本编译成 KotlinBuildScript 的子类。 这意味着 KotlinBuildScript 类型声明的所有可见属性和函数都可以在脚本中使用。 还可以分别查看用于设置脚本和 init 脚本的 KotlinSettingsScript 和 KotlinInitScript 类型。

## [Declaring variables 声明变量](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:declaring_variables)

可以在构建脚本中声明两种类型的变量: 局部变量和额外属性。

### [Local variables 局部变量](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:local_variables)

使用 def 关键字声明局部变量。 它们只能在声明它们的范围内可见。 局部变量是底层 Groovy 语言的一个特性。

```
def dest = "dest"

task copy(type: Copy) {
    from "source"
    into dest
}
```

### [Extra properties 额外属性](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:extra_properties)

Gradle 域模型中的所有增强对象都可以包含额外的用户定义属性。 这包括但不限于项目、任务和源集。

可以通过所属对象的 ext 属性添加、读取和设置额外的属性。 或者，ext 块可以用来同时添加多个属性。

```
plugins {
    id 'java'
}

ext {
    springVersion = "3.1.0.RELEASE"
    emailNotification = "build@master.org"
}

sourceSets.all { ext.purpose = null }

sourceSets {
    main {
        purpose = "production"
    }
    test {
        purpose = "test"
    }
    plugin {
        purpose = "production"
    }
}

task printProperties {
    doLast {
        println springVersion
        println emailNotification
        sourceSets.matching { it.purpose == "production" }.each { println it.name }
    }
}
```

```sh
> gradle -q printProperties
3.1.0.RELEASE
build@master.org
main
plugin
```

在此示例中，ext 块向项目对象添加两个额外的属性。 此外，通过将 ext.purpose 设置为 null (null 是允许的值) ，名为 purpose 的属性被添加到每个源集中。 一旦添加了属性，就可以像预定义的属性那样读取和设置它们。

通过要求添加属性的特殊语法，当尝试设置(预定义的或额外的)属性但该属性拼写错误或不存在时，Gradle 可能很快失败。 额外的属性可以从任何可以访问它们所属对象的地方访问，这使得它们的范围比局部变量更广。 从项目的子项目中可以看到项目的额外属性。

有关额外属性及其 API 的详细信息，请参阅 API 文档中的  [ExtraPropertiesExtension](https://docs.gradle.org/6.3/dsl/org.gradle.api.plugins.ExtraPropertiesExtension.html) 类。

## [Configuring arbitrary objects 配置任意对象](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:configuring_arbitrary_objects)

您可以用以下非常易读的方式配置任意对象。

```java
import java.text.FieldPosition

task configure {
    doLast {
        def pos = configure(new FieldPosition(10)) {
            beginIndex = 1
            endIndex = 5
        }
        println pos.beginIndex
        println pos.endIndex
    }
}
```

## [Configuring arbitrary objects using an external script 使用外部脚本配置任意对象](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:configuring_arbitrary_objects_using_an_external_script)
build.gradle

```gradle
task configure {
    doLast {
        def pos = new java.text.FieldPosition(10)
        // Apply the script
        apply from: 'other.gradle', to: pos
        println pos.beginIndex
        println pos.endIndex
    }
}
```

other.gradle

```groovy
// Set properties.
beginIndex = 1
endIndex = 5
```

## [Some Groovy basics 一些 Groovy 的基础知识](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#groovy-dsl-basics)

Groovy 语言为创建 dsl 提供了大量特性，Gradle 构建语言利用了这些特性。 理解构建语言是如何工作的将有助于您编写构建脚本，特别是当您开始编写自定义插件和任务时。

### [Groovy JDK](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:groovy_jdk)

Groovy 为标准 Java 类添加了许多有用的方法。 例如，Iterable 得到一个 each 方法，它遍历 Iterable 的元素:

```
configurations.runtimeClasspath.each { File f -> println f }
```

### [Property accessors 属性访问器](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:property_accessors)

Groovy 自动将属性引用转换为对适当的 getter 或 setter 方法的调用。
```
// Using a getter method
println project.buildDir
println getProject().getBuildDir()

// Using a setter method
project.buildDir = 'target'
getProject().setBuildDir('target')
```

### [Optional parentheses on method calls 方法调用中可选的括号](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:optional_parentheses_on_method_calls)

```
test.systemProperty 'some.prop', 'value'
test.systemProperty('some.prop', 'value')
```

### [List and map literals 列表和映射文字](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:list_and_map_literals)

Groovy 为定义 List 和 Map 实例提供了一些快捷方式。 这两种类型的文字都很简单，但是` map literals `有一些有趣的转折。

例如，“ apply”方法(通常用于应用插件)实际上需要一个 map 参数。 然而，当你有一行“ apply plugin: ‘ java’”时，你实际上并没有使用 map literal，而是使用了“ named parameters” ，它的语法和 map literal 几乎完全相同(没有包装括号)。 当方法被调用时，命名参数列表将被转换为映射，但它不是以映射开始的。

```
// List literal
test.includes = ['org/gradle/api/**', 'org/gradle/internal/**']

List<String> list = new ArrayList<String>()
list.add('org/gradle/api/**')
list.add('org/gradle/internal/**')
test.includes = list

// Map literal.
Map<String, String> map = [key1:'value1', key2: 'value2']

// Groovy will coerce named arguments
// into a single map argument
apply plugin: 'java'
```

### [Closures as the last parameter in a method 闭包作为方法的最后一个参数](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:closures_as_the_last_parameter_in_a_method)

Gradle DSL 在许多地方使用闭包。 你可以在这里找到更多关于闭包的信息。 当方法的最后一个参数是闭包时，你可以在方法调用之后放置闭包:

```
repositories {
    println "in a closure"
}
repositories() { println "in a closure" }
repositories({ println "in a closure" })
```

### [Closure delegate 结束代表](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#sec:closure_delegate)

每个闭包都有一个委托对象，Groovy 使用这个对象查找变量和方法引用，这些变量和方法引用不是闭包的局部变量或参数。 Gradle 将此用于配置闭包，其中将 delegate 对象设置为要配置的对象。

```
dependencies {
    assert delegate == project.dependencies
    testImplementation('junit:junit:4.12')
    delegate.testImplementation('junit:junit:4.12')
}
```

## [Default imports 默认导入](https://docs.gradle.org/6.3/userguide/writing_build_scripts.html#script-default-imports)

为了使构建脚本更简洁，Gradle 自动向 Gradle 脚本添加一组 import 语句。 这意味着不使用 throw new org.gradle.api.tasks。 Stopexecutionexception ()可以直接键入 throw new StopExecutionException ()。

下面列出了添加到每个脚本中的导入:

```text
import org.gradle.*
import org.gradle.api.*
import org.gradle.api.artifacts.*
import org.gradle.api.artifacts.component.*
import org.gradle.api.artifacts.dsl.*
import org.gradle.api.artifacts.ivy.*
import org.gradle.api.artifacts.maven.*
import org.gradle.api.artifacts.query.*
import org.gradle.api.artifacts.repositories.*
import org.gradle.api.artifacts.result.*
import org.gradle.api.artifacts.transform.*
import org.gradle.api.artifacts.type.*
import org.gradle.api.artifacts.verification.*
import org.gradle.api.attributes.*
import org.gradle.api.attributes.java.*
import org.gradle.api.capabilities.*
import org.gradle.api.component.*
import org.gradle.api.credentials.*
import org.gradle.api.distribution.*
import org.gradle.api.distribution.plugins.*
import org.gradle.api.execution.*
import org.gradle.api.file.*
import org.gradle.api.initialization.*
import org.gradle.api.initialization.definition.*
import org.gradle.api.initialization.dsl.*
import org.gradle.api.invocation.*
import org.gradle.api.java.archives.*
import org.gradle.api.logging.*
import org.gradle.api.logging.configuration.*
import org.gradle.api.model.*
import org.gradle.api.plugins.*
import org.gradle.api.plugins.antlr.*
import org.gradle.api.plugins.quality.*
import org.gradle.api.plugins.scala.*
import org.gradle.api.provider.*
import org.gradle.api.publish.*
import org.gradle.api.publish.ivy.*
import org.gradle.api.publish.ivy.plugins.*
import org.gradle.api.publish.ivy.tasks.*
import org.gradle.api.publish.maven.*
import org.gradle.api.publish.maven.plugins.*
import org.gradle.api.publish.maven.tasks.*
import org.gradle.api.publish.plugins.*
import org.gradle.api.publish.tasks.*
import org.gradle.api.reflect.*
import org.gradle.api.reporting.*
import org.gradle.api.reporting.components.*
import org.gradle.api.reporting.dependencies.*
import org.gradle.api.reporting.dependents.*
import org.gradle.api.reporting.model.*
import org.gradle.api.reporting.plugins.*
import org.gradle.api.resources.*
import org.gradle.api.services.*
import org.gradle.api.specs.*
import org.gradle.api.tasks.*
import org.gradle.api.tasks.ant.*
import org.gradle.api.tasks.application.*
import org.gradle.api.tasks.bundling.*
import org.gradle.api.tasks.compile.*
import org.gradle.api.tasks.diagnostics.*
import org.gradle.api.tasks.incremental.*
import org.gradle.api.tasks.javadoc.*
import org.gradle.api.tasks.options.*
import org.gradle.api.tasks.scala.*
import org.gradle.api.tasks.testing.*
import org.gradle.api.tasks.testing.junit.*
import org.gradle.api.tasks.testing.junitplatform.*
import org.gradle.api.tasks.testing.testng.*
import org.gradle.api.tasks.util.*
import org.gradle.api.tasks.wrapper.*
import org.gradle.authentication.*
import org.gradle.authentication.aws.*
import org.gradle.authentication.http.*
import org.gradle.build.event.*
import org.gradle.buildinit.plugins.*
import org.gradle.buildinit.tasks.*
import org.gradle.caching.*
import org.gradle.caching.configuration.*
import org.gradle.caching.http.*
import org.gradle.caching.local.*
import org.gradle.concurrent.*
import org.gradle.external.javadoc.*
import org.gradle.ide.visualstudio.*
import org.gradle.ide.visualstudio.plugins.*
import org.gradle.ide.visualstudio.tasks.*
import org.gradle.ide.xcode.*
import org.gradle.ide.xcode.plugins.*
import org.gradle.ide.xcode.tasks.*
import org.gradle.ivy.*
import org.gradle.jvm.*
import org.gradle.jvm.application.scripts.*
import org.gradle.jvm.application.tasks.*
import org.gradle.jvm.platform.*
import org.gradle.jvm.plugins.*
import org.gradle.jvm.tasks.*
import org.gradle.jvm.tasks.api.*
import org.gradle.jvm.test.*
import org.gradle.jvm.toolchain.*
import org.gradle.language.*
import org.gradle.language.assembler.*
import org.gradle.language.assembler.plugins.*
import org.gradle.language.assembler.tasks.*
import org.gradle.language.base.*
import org.gradle.language.base.artifact.*
import org.gradle.language.base.compile.*
import org.gradle.language.base.plugins.*
import org.gradle.language.base.sources.*
import org.gradle.language.c.*
import org.gradle.language.c.plugins.*
import org.gradle.language.c.tasks.*
import org.gradle.language.coffeescript.*
import org.gradle.language.cpp.*
import org.gradle.language.cpp.plugins.*
import org.gradle.language.cpp.tasks.*
import org.gradle.language.java.*
import org.gradle.language.java.artifact.*
import org.gradle.language.java.plugins.*
import org.gradle.language.java.tasks.*
import org.gradle.language.javascript.*
import org.gradle.language.jvm.*
import org.gradle.language.jvm.plugins.*
import org.gradle.language.jvm.tasks.*
import org.gradle.language.nativeplatform.*
import org.gradle.language.nativeplatform.tasks.*
import org.gradle.language.objectivec.*
import org.gradle.language.objectivec.plugins.*
import org.gradle.language.objectivec.tasks.*
import org.gradle.language.objectivecpp.*
import org.gradle.language.objectivecpp.plugins.*
import org.gradle.language.objectivecpp.tasks.*
import org.gradle.language.plugins.*
import org.gradle.language.rc.*
import org.gradle.language.rc.plugins.*
import org.gradle.language.rc.tasks.*
import org.gradle.language.routes.*
import org.gradle.language.scala.*
import org.gradle.language.scala.plugins.*
import org.gradle.language.scala.tasks.*
import org.gradle.language.scala.toolchain.*
import org.gradle.language.swift.*
import org.gradle.language.swift.plugins.*
import org.gradle.language.swift.tasks.*
import org.gradle.language.twirl.*
import org.gradle.maven.*
import org.gradle.model.*
import org.gradle.nativeplatform.*
import org.gradle.nativeplatform.platform.*
import org.gradle.nativeplatform.plugins.*
import org.gradle.nativeplatform.tasks.*
import org.gradle.nativeplatform.test.*
import org.gradle.nativeplatform.test.cpp.*
import org.gradle.nativeplatform.test.cpp.plugins.*
import org.gradle.nativeplatform.test.cunit.*
import org.gradle.nativeplatform.test.cunit.plugins.*
import org.gradle.nativeplatform.test.cunit.tasks.*
import org.gradle.nativeplatform.test.googletest.*
import org.gradle.nativeplatform.test.googletest.plugins.*
import org.gradle.nativeplatform.test.plugins.*
import org.gradle.nativeplatform.test.tasks.*
import org.gradle.nativeplatform.test.xctest.*
import org.gradle.nativeplatform.test.xctest.plugins.*
import org.gradle.nativeplatform.test.xctest.tasks.*
import org.gradle.nativeplatform.toolchain.*
import org.gradle.nativeplatform.toolchain.plugins.*
import org.gradle.normalization.*
import org.gradle.platform.base.*
import org.gradle.platform.base.binary.*
import org.gradle.platform.base.component.*
import org.gradle.platform.base.plugins.*
import org.gradle.play.*
import org.gradle.play.distribution.*
import org.gradle.play.platform.*
import org.gradle.play.plugins.*
import org.gradle.play.plugins.ide.*
import org.gradle.play.tasks.*
import org.gradle.play.toolchain.*
import org.gradle.plugin.devel.*
import org.gradle.plugin.devel.plugins.*
import org.gradle.plugin.devel.tasks.*
import org.gradle.plugin.management.*
import org.gradle.plugin.use.*
import org.gradle.plugins.ear.*
import org.gradle.plugins.ear.descriptor.*
import org.gradle.plugins.ide.*
import org.gradle.plugins.ide.api.*
import org.gradle.plugins.ide.eclipse.*
import org.gradle.plugins.ide.idea.*
import org.gradle.plugins.javascript.base.*
import org.gradle.plugins.javascript.coffeescript.*
import org.gradle.plugins.javascript.envjs.*
import org.gradle.plugins.javascript.envjs.browser.*
import org.gradle.plugins.javascript.envjs.http.*
import org.gradle.plugins.javascript.envjs.http.simple.*
import org.gradle.plugins.javascript.jshint.*
import org.gradle.plugins.javascript.rhino.*
import org.gradle.plugins.signing.*
import org.gradle.plugins.signing.signatory.*
import org.gradle.plugins.signing.signatory.pgp.*
import org.gradle.plugins.signing.type.*
import org.gradle.plugins.signing.type.pgp.*
import org.gradle.process.*
import org.gradle.swiftpm.*
import org.gradle.swiftpm.plugins.*
import org.gradle.swiftpm.tasks.*
import org.gradle.testing.base.*
import org.gradle.testing.base.plugins.*
import org.gradle.testing.jacoco.plugins.*
import org.gradle.testing.jacoco.tasks.*
import org.gradle.testing.jacoco.tasks.rules.*
import org.gradle.testkit.runner.*
import org.gradle.vcs.*
import org.gradle.vcs.git.*
import org.gradle.work.*
import org.gradle.workers.*
```
