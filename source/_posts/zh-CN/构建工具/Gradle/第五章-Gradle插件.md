---
title: 第五章-Gradle插件
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

说起 Gradle 的插件，不得不感叹 Gradle 的设计。Gradle 的设计非常好，它本身提供一些基本的概念和整体核心的框架，其他用于描述真实的使用场景逻辑都以插件扩展的方式来实现，这样Gradle的设计者就可以抽象的方式提供一个核心的框架，其他具体的功能和业务等都通过插件扩展的方式来实现，比如构建Java应用，就是通过Java插件来实现的。

Gradle 本身内置了很多常用的插件，这些插件基本上能帮我们做大部分的工作，但是也有一些Gradle本身没有内置，这时候就需要我们自己去扩展现有的插件或者自己自定义的插件来达到我们的目的，比如Android Gradle插件就是基于内置的Java插件实现的

### 5.1 插件是什么

插件是为了解决某一问题域构建甚至各种问题，在 Gradle 的基础上，提供的可复用的扩展。

把插件应用到你的项目中，插件会扩展项目的功能，帮助你在项目的构建过程中做很多事情：

1. 可以添加任务到你的项目中，帮你完成一些事情，比如测试，比如编译，比如打包。
2. 可以添加依赖配置到你的项目中，我们可以通过他们配置我们项目在构建过程中需要的依赖，比如我们编译的时候依赖的第三方库等
3. 可以向项目中现有的对象类型添加新的扩展熟悉、方法等，让你可以使用他们帮助我们配置、优化构建。比如android{}这个配置块就是 Android Gradle 插件为 Project 对象添加的一个扩展。
4. 可以对项目进行一些约定，比如应用Java插件之后，约定src/main/java目录下是我们的源代码存放位置，在编译的时候也是编译这个目录下的Java源代文件。

这就是插件，我们只需要按照它约定的方式，使用它提供的任务、方法或者扩展，就可以对我们的项目进行构建。

### 5.2 如何应用一个插件

如何使用一个插件呢？在使用一个插件之前我们要先应用它，把它应用到我们的项目中，这样我们就可以使用它了，插件的应用都是通过Project.apply() 方法完成的，apply 方法有好几种用法，并且插件也分为**二进制插件**和**脚本插件**，下面我们就一一介绍。

##### 5.2.1 应用二进制插件

什么是二进制插件呢？二进制插件就是实现了org.gradle.api.Plugin接口的插件，他们可以有plugin id，下面我们看下如何应用一个java插件。

`apply plugin:'java'`

这样我们把java插件应用到我们的项目中了，其中 'java' 是 Java 插件的plugin id，他是唯一的，对于Gradle自带的核心插件都有一个容易记的短名称作为其 plugin id，比如这里的java，其实它对应类型的是org.gradle.api.plugins.JavaPlugin，所以通过该类型我们也可以应用这个插件。

![](http://upload-images.jianshu.io/upload_images/1662509-0ccc0c0110e9e959.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

又因为包org.gradle.api.plugins是默认导入的，所以我们可以去掉包名直接写为：

![](http://upload-images.jianshu.io/upload_images/1662509-1e8635af92f20291.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以前三种写法是等价的，不要我们第一种用的最多，因为它比较建议，容易记。第二种写法一般适用于我们在build文件中自定义的插件--也就是脚本插件。
二进制插件一般都是被打包在一个 jar 里独立发布的，比如我们自定义的插件，在发布的时候我们也可以为其指定plugin id，这个plugin id最好是一个全限定名称，就像你的包名一样，这样发布的插件 plugin id 就不会重复，比如 org.flysnow.tools.plugin.xxx。

##### 5.2.2 应用脚本插件

![](http://upload-images.jianshu.io/upload_images/1662509-79592fa86b10ce47.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其实这不能算一个插件，也不是一个插件，它指示一个脚本，应用脚本插件，其实就是把这个脚本加载进来，和二进制 插件不同的是它使用的是 from 关键字，后面紧跟的是一个脚本文件，可以是本地的，也可以是网络的，如果是网络上的话要使用 HTTP URL。

虽然它不是一个真正的插件，但是不能忽视它的作用，它是脚本文件模块化的基础，我们可以把庞大的脚本文件，进行分块、分段整理，拆分成一个个共用、职责分明的文件，然后使用 apply from 来引用他们，比如我们可以把常用的函数放在一个utils.gradle脚本里，供其他脚本文件引用。示例中我们把 App 的版本名称和版本号单独放在一个脚本文件里，这样我们每次只需要在这个文件修改App的版本名称和版本号即可，清晰、简单、方便、快捷，也可以使用自动化对该文件自动处理生成版本等等。

##### 5.2.3 apply方法的其他用法

Project.apply()方法有三种使用方式，他们是以接受参数的不同区分的。我们上面用的是接受一个Map类型参数的方式，下面讲下另外两种。

![](http://upload-images.jianshu.io/upload_images/1662509-eb931be0cba4a485.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**闭包的方式:**

```groovy
apply{
    plugin 'java'
}
```

该闭包被用来配置一个ObjectConfigurationAction对象，所以你可以在这里闭包里使用ObjectConfigurationAction对象的方法、属性等进行配置。示例的效果和我们前面的例子是一样的。

**Action的方式：**

![](http://upload-images.jianshu.io/upload_images/1662509-9d9cad9a10ae44b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Action的方式就是我们自己要new一个Action，然后在execute方法里进行配置。

##### 5.2.4 应用第三方发布的插件

第三方发布的作为 jar 的二进制插件，我们在应用的时候，必须要现在 buildscript{} 里配置其 classpath 才能使用，这个不像 Gradle为我们提供的内置插件。比如我们的 Android Gradle 插件，就属于 Android 发布的第三方插件，如果要使用他们我们先要进行配置。

```groovy
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    /**
     * The repositories {} block configures the repositories Gradle uses to
     * search or download the dependencies. Gradle pre-configures support for remote
     * repositories such as JCenter, Maven Central, and Ivy. You can also use local
     * repositories or define your own remote repositories. The code below defines
     * JCenter as the repository Gradle should use to look for its dependencies.
     */
    repositories {
        jcenter()
    }

    /**
     * The dependencies {} block configures the dependencies Gradle needs to use
     * to build your project. The following line adds Android Plugin for Gradle
     * version 2.2.3 as a classpath dependency.
     */
    dependencies {
        classpath 'com.android.tools.build:gradle:2.2.3'
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}
```

buildscript{}块是一个在构建项目之前，为项目进行前期准备和初始化相关配置依赖的地方，配置好所需的依赖，就可以应用插件了。

`apply plugin: 'com.android.application'`

如果没有提前在buildscript里配置依赖的classpath，会提示找不到这个插件的。

##### 5.2.5 使用plugins DSL应用插件

plugins dsl 是一种新的插件应用方式，Gradle2.1 以上版本才可以用。目前这个功能还在内测中以后可能会变，我们先了解以下，遇到这种写法我们也知道是什么意思。

```groovy
plugin{
    id 'java'
}
```

这样就应用了java插件，看着更简洁一些，更符合dsl规范。

还记得前面我们应用第三方插件的时候要先使用 buildscript 配置吧？使用 plugins 就有一种例外，如果该插件已经被托管在 https://plugins.gradle.org/网站上，我们就不用在 buildscript 里配置 classpa 依赖了，直接使用plugins就可以应用插件。

```groovy
plugin{
    id 'org.sonarqube' version "1.2"
}
```

##### 5.2.6 更多好用的插件

开源的力量是强大的，很多开发者为 Gradle 社区贡献了很多好用的插件，这些查看我们可以在 <https://plugins.gradle.org/> 上找到，也可以到 Github 上找。

### 5.3 自定义插件

很多是有我们可以根据自己的实际业务自定义一些插件，来辅助项目的构建。自定义插件涉及的知识点很多，比如创建任务、创建方法、进行约定等等，篇幅有限，我们这里以创建任务为例，对自定义插件进行简单的介绍，让大家对自定义插件有个大概的了解。

我们使用脚本写一个简单的插件，了解下自定义插件的工作原理。

```java
apply plugin: MyPlugin

class MyPlugin implements Plugin<Project>{
	//该方法在插件被应用的时候执行
	void apply(Project project){
		//创建一个'task1'的任务给项目用
		project.task('task1'){
			doLast{
				println '这是一个通过自定义插件方式创建的任务'
			}
		}
	}
}
```

以上是我们定义的一个简单的插件，是定义在 build 脚本文件里的，只能我们自己的项目用，如果我们想开发一个独立的插件给所有想用的人怎么做呢？这就需要我们单独创建一个 Groovy 工程作为开发自定义插件的工程了。
