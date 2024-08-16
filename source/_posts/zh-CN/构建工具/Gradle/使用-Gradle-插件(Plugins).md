---
title: 使用-Gradle-插件(Plugins)
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

## [What plugins do 插件的作用](https://docs.gradle.org/6.3/userguide/plugins.html#sec:what_plugins_do)

在项目中应用插件可以扩展项目的能力，它可以做以下事情:

* 扩展 Gradle 模型(例如，添加可配置的新 DSL 元素)
* 根据约定配置项目(例如添加新任务或配置合理的默认值)
* 应用特定的配置(例如添加组织存储库或执行标准)

## [Types of plugins 插件的类型](https://docs.gradle.org/6.3/userguide/plugins.html#sec:types_of_plugins)

在 Gradle 有两种通用的插件，脚本插件和二进制插件。 脚本插件是附加的构建脚本，用于进一步配置构建，并通常实现操作构建的声明性方法。 它们通常在构建中使用，尽管它们可以外部化并从远程位置访问。 二进制插件是实现 Plugin 接口并采用编程方法来操作构建的类。 二进制插件可以驻留在构建脚本中、项目层次结构中或外部插件罐中。

<!-- more -->

一个插件通常从一个脚本插件开始(因为它们很容易编写) ，然后，随着代码变得更有价值，它被迁移到一个二进制插件，可以很容易地在多个项目或组织之间进行测试和共享。

## [Using plugins 使用插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:using_plugins)

要使用封装在插件中的构建逻辑，Gradle 需要执行两个步骤。 首先，它需要解决插件，然后需要将插件应用到目标上，通常是一个项目。

解决一个插件意味着找到包含给定插件的 jar 的正确版本，并将其添加到脚本类路径。 一旦解析了一个插件，它的 API 就可以用在构建脚本中。 脚本插件是自我解析的，因为它们是在应用时从特定的文件路径或 URL 解析出来的。 作为 Gradle 发行版的一部分提供的核心二进制插件会自动解析。

应用插件意味着实际执行插件的插件。 应用插件是幂等的。 也就是说，您可以安全地多次应用任何插件而不会产生副作用。

使用插件最常见的用例是解析插件并将其应用于当前项目。 因为这是一个非常常见的用例，所以建议构建作者在一个步骤中使用 DSL 来解决和应用插件。

## [Script plugins 脚本插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:script_plugins)

```groovy
apply from: 'other.gradle'
```

脚本插件是自动解析的，可以从本地文件系统或远程位置的脚本应用。 文件系统位置是相对于项目目录的，而远程脚本位置是通过 HTTP URL 指定的。 多个脚本插件(任何一种形式)都可以应用于给定的目标。

## [Binary plugins 二进制插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:binary_plugins)

你可以通过插件 id 来应用插件，这是插件的全局唯一标识符名称。 核心 Gradle 插件的特殊之处在于它们提供了简短的名称，比如 JavaPlugin 核心的‘ java’。 所有其他的二进制插件都必须使用插件 id 的完全限定形式(例如 com.github. foo.bar) ，尽管一些遗留插件仍然使用简短的非限定形式。 你把插件 id 放在哪里取决于你是否正在使用插件 DSL 或者构建脚本块。

插件就是实现 Plugin 接口的任何类。 Gradle 提供了核心插件(例如 JavaPlugin)作为其发行版的一部分，这意味着它们会自动解析。 然而，非核心的二进制插件需要解决之前，他们可以应用。 这可以通过多种方式实现:

### [Applying plugins with the plugins DSL 使用 DSL 插件应用插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:plugins_block)

Dsl 插件提供了一种简洁方便的方式来声明插件的依赖关系。 它与 Gradle 插件门户网站一起工作，提供对核心插件和社区插件的简单访问。 这些插件的 DSL 块配置了一个 pluginintervenciesspec 的实例。

要应用核心插件，可以使用简短的名称:

```groovy
plugins {
    id 'java'
}
```

要从门户网站应用社区插件，必须使用完全合格的插件 id:

```groovy
plugins {
    id 'com.jfrog.bintray' version '0.4.1'
}
```

#### [Limitations of the plugins DSL 插件 DSL 的局限性](https://docs.gradle.org/6.3/userguide/plugins.html#plugins_dsl_limitations)

这种向项目中添加插件的方式远不止是一种更方便的语法。 这些插件的 DSL 处理方式使得 Gradle 能够很早很快地确定使用中的插件。 这使得 Gradle 能够做一些明智的事情，比如:

* 优化插件类的加载和重用。
* 允许不同的插件使用不同版本的依赖关系。
* 为编辑辅助提供编译脚本中关于潜在属性和值的编辑器详细信息。

这要求在执行构建脚本的其余部分之前，以 Gradle 可以轻松快速提取的方式指定插件。 它还要求使用的插件的定义多少是静态的。

在插件{}块机制和“传统的” apply ()方法机制之间有一些关键的区别。 还存在一些制约因素，其中一些是临时性的制约因素，而这一机制仍在发展之中，另一些则是新办法所固有的。

插件{}块不支持任意代码。 它是约束的，以便是幂等的(产生相同的结果每次)和副作用自由(安全的 Gradle 执行在任何时候)。

```groovy
plugins {
    id «plugin id»
    id «plugin id» version «plugin version» [apply «false»]
}
```

* 对于已经可用于构建脚本的核心 Gradle 插件或插件
* 需要解决的二进制 Gradle 插件

在“ plugin id”和“ plugin version”必须为常量的情况下，可以使用文字、字符串和带有布尔值的 apply 语句禁用立即应用插件的默认行为(例如，您希望只在子项目中应用它)。 不允许使用其他语句; 它们的存在将导致编译错误。

如果你想使用一个变量来定义一个插件版本，请参阅插件版本管理。

插件{}块也必须是构建脚本中的顶级语句。 它不能嵌套在另一个构造中(例如 if-statement 或 for-loop)。

##### [Can only be used in build scripts and settings file 只能在构建脚本和设置文件中使用](https://docs.gradle.org/6.3/userguide/plugins.html#sec:build_scripts_only)

插件{}块目前只能在项目的构建脚本和 settings.gradle 文件中使用。 它不能在脚本插件或 init 脚本中使用。

未来版本的 Gradle 将取消这一限制。

如果插件{}块的限制是禁止的，建议的方法是使用内建脚本{}块应用插件。

#### [Applying plugins to subprojects 将插件应用到子项目中](https://docs.gradle.org/6.3/userguide/plugins.html#sec:subprojects_plugins_dsl)

如果您有一个多项目构建，您可能希望将插件应用于构建中的部分或全部子项目，而不是应用于根项目或主项目。 插件{}块的默认行为是立即解析和应用插件。 但是，你可以使用 apply false 语法告诉 Gradle 不要在当前项目中使用插件，然后在子项目块中使用 apply plugin: “ plugin id” ，或者在子项目构建脚本中使用插件{}块:

#### [Applying plugins from the 应用来自*buildSrc* directory 目录](https://docs.gradle.org/6.3/userguide/plugins.html#sec:buildsrc_plugins_dsl)

您可以应用驻留在项目的 buildSrc 目录中的插件，只要它们有一个已定义的 ID。 下面的示例演示如何将 buildSrc 中定义的插件实现类 my.MyPlugin 绑定到 ID“ my-plugin” :

```groovy
plugins {
    id 'java-gradle-plugin'
}

gradlePlugin {
    plugins {
        myPlugins {
            id = 'my-plugin'
            implementationClass = 'my.MyPlugin'
        }
    }
}
```

应用来自 buildSrc 的插件

```groovy
plugins {
    id 'my-plugin'
}
```

#### [Plugin Management 插件管理](https://docs.gradle.org/6.3/userguide/plugins.html#sec:plugin_management)

Pluginmanagement {}块可能只出现在 settings.gradle 文件中，其中它必须是文件中的第一个块，或者出现在初始化脚本中。

```groovy
pluginManagement {
    plugins {
    }
    resolutionStrategy {
    }
    repositories {
    }
}
```

```groovy
settingsEvaluated { settings ->
    settings.pluginManagement {
        plugins {
        }
        resolutionStrategy {
        }
        repositories {
        }
    }
}
```

##### [Custom Plugin Repositories 自定义插件库](https://docs.gradle.org/6.3/userguide/plugins.html#sec:custom_plugin_repositories)

默认情况下，插件{} DSL 解析来自公共 Gradle Plugin Portal 的插件。 许多构建作者也希望解决来自私有 Maven 或 Ivy 存储库的插件，因为这些插件包含专有的实现细节，或者仅仅是为了对他们的构建中可用的插件有更多的控制权。

要指定自定义插件库，use the `repositories {}` block inside `pluginManagement {}`:

示例: 使用自定义插件库中的插件
settings.gradle

```groovy
pluginManagement {
    repositories {
        maven {
            url '../maven-repo'
        }
        gradlePluginPortal()
        ivy {
            url '../ivy-repo'
        }
    }
}
```

这告诉 Gradle 首先查看 Maven 存储库。`../maven-repo` 解析插件，然后检查 Gradle Plugin Portal 是否在 Maven 存储库中没有找到插件。 如果不希望搜索 Gradle Plugin Portal，可以省略 gradlePluginPortal ()行。 最后，位于。 . 我们会检查 ivy-repo。

##### [Plugin Version Management 插件版本管理](https://docs.gradle.org/6.3/userguide/plugins.html#sec:plugin_version_management)

在 pluginManagement {}内部的一个插件{}块允许在一个位置定义构建的所有插件版本。 插件可以通过 id 通过插件{}块应用到任何构建脚本。

以这种方式设置插件版本的一个好处是，pluginManagement.plugins {}与构建脚本插件{}块不具有相同的约束语法。 这使得插件版本可以从 gradle.properties 获取，或者通过其他机制加载。

#### [Plugin Resolution Rules 插件解析规则](https://docs.gradle.org/6.3/userguide/plugins.html#sec:plugin_resolution_rules)

插件解析规则允许您修改插件{}块中的插件请求，例如更改所请求的版本或显式指定实现构件的坐标。

要添加解析规则，请在 pluginManagement {}块中使用 resolutionStrategy {} :

settings.gradle

```groovy
pluginManagement {
    resolutionStrategy {
        eachPlugin {
            if (requested.id.namespace == 'org.gradle.sample') {
                useModule('org.gradle.sample:sample-plugins:1.0.0')
            }
        }
    }
    repositories {
        maven {
            url '../maven-repo'
        }
        gradlePluginPortal()
        ivy {
            url '../ivy-repo'
        }
    }
}
```

这告诉 Gradle 使用指定的插件实现构件，而不是使用它内置的从插件 ID 到 maven / ivy 坐标的默认映射。

自定义 Maven 和 Ivy 插件库除了实际实现插件的工件外，还必须包含插件标记工件。 有关将插件发布到自定义存储库的更多信息，请阅读 Gradle Plugin Development Plugin。

### [Plugin Marker Artifacts 插件标记工件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:plugin_markers)

由于插件{} DSL 块只允许通过全局唯一的插件 id 和版本属性声明插件，Gradle 需要一种方法来查找插件实现工件的坐标。 为此，Gradle 将使用 Plugin.id: Plugin.id.Gradle.Plugin: Plugin.version 寻找一个插件标记工件。 这个标记需要依赖于实际的插件实现。 Java-gradle-plugin 可以自动发布这些标记。

例如，下面来自示例插件项目的完整示例演示了如何使用 java-gradle-plugin、 Maven-publish 插件和 Ivy-publish 插件向 Ivy 和 Maven 库发布 org.gradle.sample.hello 插件和 org.gradle.sample.goodbye 插件。

build.gradle

```groovy
plugins {
    id 'java-gradle-plugin'
    id 'maven-publish'
    id 'ivy-publish'
}

group 'org.gradle.sample'
version '1.0.0'

gradlePlugin {
    plugins {
        hello {
            id = 'org.gradle.sample.hello'
            implementationClass = 'org.gradle.sample.hello.HelloPlugin'
        }
        goodbye {
            id = 'org.gradle.sample.goodbye'
            implementationClass = 'org.gradle.sample.goodbye.GoodbyePlugin'
        }
    }
}

publishing {
    repositories {
        maven {
            url '../../consuming/maven-repo'
        }
        ivy {
            url '../../consuming/ivy-repo'
        }
    }
}
```

在 sample 目录中运行 gradle publish 会导致以下的 repo 布局存在:
![](https://upload-images.jianshu.io/upload_images/1662509-327d14b5802fc9d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### [Legacy Plugin Application 遗留插件应用程序](https://docs.gradle.org/6.3/userguide/plugins.html#sec:old_plugin_application)

随着 DSL 插件的引入，用户应该没有什么理由使用应用插件的遗留方法。 这里有文档说明，以防构建作者由于当前工作方式的限制而无法使用这些插件 DSL。

#### [Applying Binary Plugins 应用二进制插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:applying_binary_plugins)

build.gradle

```groovy
apply plugin: 'java'
```

插件可以使用插件 id 来应用。 在上面的例子中，我们使用简称‘ java’来应用 JavaPlugin。

与使用插件 id 不同，插件也可以通过简单地指定插件的类来应用:
build.gradle

```groovy
apply plugin: JavaPlugin
```

上面示例中的 JavaPlugin 符号引用了 JavaPlugin。 此类不需要严格导入，因为所有构建脚本中都会自动导入 org.gradle.api.plugins 包(请参阅默认导入)。

#### [Applying plugins with the buildscript block 使用构建脚本块应用插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:applying_plugins_buildscript)

通过将插件添加到构建脚本类路径中，然后应用插件，可以将已经发布为外部 jar 文件的二进制插件添加到项目中。 可以使用构建脚本的外部依赖项中描述的内建脚本{}块将外部 jar 添加到构建脚本类路径中。

应用一个带有内建脚本块的插件

build.gradle

```groovy
buildscript {
    repositories {
        jcenter()
    }
    dependencies {
        classpath 'com.jfrog.bintray.gradle:gradle-bintray-plugin:0.4.1'
    }
}

apply plugin: 'com.jfrog.bintray'
```

## [Finding community plugins 寻找社区插件](https://docs.gradle.org/6.3/userguide/plugins.html#sec:finding_community_plugins)

有一个充满活力的插件开发者社区，他们为各种各样的功能贡献插件。 Gradle 插件门户提供了一个用于搜索和探索社区插件的界面。

## [More on plugins 更多关于插件的信息](https://docs.gradle.org/6.3/userguide/plugins.html#sec:more_on_plugins)

本章旨在介绍插件和 Gradle 以及它们所扮演的角色。 有关插件内部工作的更多信息，请参见[自定义插件](https://docs.gradle.org/6.3/userguide/custom_plugins.html#custom_plugins)。
