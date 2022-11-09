我们之前说过，Gradle 的核心是一种基于依赖性编程的语言。 在 Gradle 术语中，这意味着您可以定义任务和任务之间的依赖关系。 Gradle 保证这些任务按照其依赖项的顺序执行，并且每个任务只执行一次。 这些任务形成了一个有向无环图。 有一些构建工具可以在执行任务时建立这样的依赖关系图。 在执行任何任务之前，Gradle 构建完整的依赖关系图。 这位于 Gradle 的心脏地带，使许多事情成为可能，否则这些事情是不可能实现的。

您的构建脚本配置这个依赖关系图。因此，严格地说，它们是构建配置脚本。

## [Build phases 构建阶段](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:build_phases)

一个 Gradle 构建有三个不同的阶段。

* Initialization 初始化
* Configuration 配置
* Execution 执行

## [Settings file 设置文件](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:settings_file)

在构建脚本文件旁边，Gradle 定义了一个设置文件。 设置文件由 Gradle 通过一个变数命名原则文件夹确定。 这个文件的默认名称是 settings.gradle。 在本章的后面，我们将解释 Gradle 如何查找设置文件。

设置文件在初始化阶段执行。 多项目构建必须在多项目层次结构的根项目中有 settings.gradle 文件。 这是必需的，因为设置文件定义了哪些项目正在参与多项目构建(参见创作多项目构建)。 对于单项目生成，设置文件是可选的。 除了定义所包含的项目之外，您可能还需要它将库添加到构建脚本类路径中(请参见 organizinggradle 项目)。 让我们首先用一个单独的项目构建做一些反思:

settings.gradle

```groovy
println 'This is executed during the initialization phase.'
```

build.gradle

```groovy
println 'This is executed during the configuration phase.'

task configured {
    println 'This is also executed during the configuration phase.'
}

task test {
    doLast {
        println 'This is executed during the execution phase.'
    }
}

task testBoth {
	doFirst {
	  println 'This is executed first during the execution phase.'
	}
	doLast {
	  println 'This is executed last during the execution phase.'
	}
	println 'This is executed during the configuration phase as well.'
}
```

```sh
> gradle test testBoth
This is executed during the initialization phase.

> Configure project :
This is executed during the configuration phase.
This is also executed during the configuration phase.
This is executed during the configuration phase as well.

> Task :test
This is executed during the execution phase.

> Task :testBoth
This is executed first during the execution phase.
This is executed last during the execution phase.

BUILD SUCCESSFUL in 0s
2 actionable tasks: 2 executed
```

对于生成脚本，属性访问和方法调用被委托给项目对象。 类似地，设置文件中的属性访问和方法调用也被委派给设置对象。 有关更多信息，请查看 API 文档中的 Settings 类。

## [Multi-project builds 多项目建设](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:lifecycle_multi_project_builds)

多项目生成是在 Gradle 的单次执行期间生成多个项目的生成。 您必须在设置文件中声明参与多项目生成的项目。 关于多项目构建，在本主题的章节中还有很多要说的(请参阅创作多项目构建)。

多项目构建总是由具有单个根的树来表示。 树中的每个元素代表一个项目。 项目有一条路径，它表示项目在多项目生成树中的位置。 在大多数情况下，项目路径与项目在文件系统中的物理位置一致。 但是，此行为是可配置的。 项目树是在 settings.gradle 文件中创建的。 默认情况下，假定设置文件的位置也是根项目的位置。 但是您可以在设置文件中重新定义根项目的位置。

### [Building the tree](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sub:building_the_tree)

在设置文件中，您可以使用一组方法来生成项目树。 层次化和扁平化的物理布局得到了特殊的支持。

#### [Hierarchical layouts 分层布局](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:hierarchical_layouts)

settings.gradle

```groovy
include 'project1', 'project2:child', 'project3:child1'
```

Include 方法将项目路径作为参数。 假设项目路径等于相对物理文件系统路径。 例如，默认情况下，路径“ services: api”映射到文件夹“ services / api”(相对于项目根目录)。 您只需指定树的叶子。 这意味着包含服务: 酒店: api 的路径将导致创建3个项目: 服务、服务: 酒店和服务: 酒店: api。 关于如何使用项目路径的更多示例可以在 Settings.include (java.lang)的 DSL 文档中找到。 String []).

#### [Flat layouts 平面布局](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:flat_layouts)

settings.gradle

```groovy
includeFlat 'project3', 'project4'
```

Includeflat 方法将目录名作为参数。 这些目录需要作为根项目目录的兄弟目录存在。 这些目录的位置被认为是多项目树中根项目的子项目。

### [Modifying elements of the project tree 修改项目树的元素](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sub:modifying_element_of_the_project_tree)

在设置文件中创建的多项目树由所谓的项目描述符组成。 您可以随时在设置文件中修改这些描述符。 要访问描述符，你可以这样做:
settings.gradle

```groovy
println rootProject.name
println project(':projectA').name
```

使用此描述符，您可以更改项目的名称、项目目录和生成文件。

settings.gradle

```groovy
rootProject.name = 'main'
project(':projectA').projectDir = new File(settingsDir, '../my-project-a')
project(':projectA').buildFileName = 'projectA.gradle'
```

* [Initialization 初始化](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:initialization)
* [Configuration and execution of a single project build 单个项目生成的配置和执行](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#sec:configuration_and_execution_of_a_single_project_build)
* [Responding to the lifecycle in the build script 在构建脚本中响应生命周期](https://docs.gradle.org/6.3/userguide/build_lifecycle.html#build_lifecycle_events)
