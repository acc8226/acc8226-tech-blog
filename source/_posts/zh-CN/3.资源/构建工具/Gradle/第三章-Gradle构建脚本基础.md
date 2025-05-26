---
title: 第三章-Gradle构建脚本基础
date: 2022-12-31 00:00:00
updated: 2022-12-31 00:00:00
categories:
  - 构建工具
  - Gradle
tags:
- Gradle
---

本章从整体构建脚本的角度介绍 Gradle，什么是 Settings文件，他有什么作用；什么是 Build 文件，它又有什么作用，我们可以新建多少Build文件。

然后会介绍 Gradle 的两个重要的概念：Project 和 Task，他们有什么作用，又有什么关系，如何创建一个Task，如何对 Task 进行配置，Task 之间如何建立依赖关系；Task如何使用 API 控制和 Task 之间的通信等等。

最后介绍的是自定义属性，他们有何作用，如何定义，什么时候会用到等等，最后最后强调的是脚本就是代码，以写代码的方式来写脚本，灵活运用。

### 3.1 Setting文件

在 Gradle 中，定义了一个设置文件，用于初始化以及工程树的配置。设置文件的默认名字是 settings.gradle，放在根工程目录下。

设置文件大多数的作用都是为了配置子工程。在 Gradle 多工程是通过工程树表示的，就相当于我们在 Android Studio 看到的 Project 和 Module 概念一样。根工程相当于 Android Studio 中的 Project，一个根工程可以有很多子工程，也就是很多 Module，这样就和 Android Studio 定义的 Module 概念对应上了。

<!-- more -->

### 3.2 Build文件

每个 Project 都会有一个 build 文件，该文件是该 Project 构建的入口，可以在这里针对该 Project 进行配置，比如配置版本，需要哪些插件，依赖哪些库等等。

既然每个 Project 都会有一个 build 文件，那么 Root Project 也不例外。Root Project 可以获取到所有的Child Project，所以在 Root Project 的 build 文件里我们可以对 Child Project 统一配置，比如应用的插件，依赖的 Maven 中心库等等。这一点 Gradle 早就考虑到了，为我们提供了便捷的方法进行配置，比如配置所有 Child Project 的的仓库为 jcenter，这样我们依赖的 jar 包就可以从 jcenter 中心库中下载了：

![](http://upload-images.jianshu.io/upload_images/1662509-44795ab65048f852.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

还比如我们在开发一个大型的Java工程，该工程被分为很多小模块，每个模块都是一个 Child Project，这些模块同样夜都是Java工程，这种情况下我们也可以统一配置，应用 Java 插件：

![](http://upload-images.jianshu.io/upload_images/1662509-751152427010d086.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这非常方便，省去了我们一个个 Project 去配置的情况，特别对于要管理很多的 Project 的大工程来说。除了提供的subprojects之外，还有allprojects，从其名字就可以看出来，是对所有 Project 的配置。

上面讲了很多配置，但是大家不要误以为 subprojects 和 allprojects 只能配置，他们只是两个方法，接受一个闭包作为参数，对工程进行遍历，遍历的过程中调用我们自定义的闭包，所以我们可以在闭包里配置，打印，输出，修改 Project 的属性都可以。

### 3.3 Projects 以及 tasks

其实一个 Project 就是在你的业务范围内，被你抽象出来的一个个独立的模块，你可以根据你的情况抽象归类，最后这一个个的Project 组成了你的整个 Gradle 构建。

从我们编码的角度讲，他们就是一个个独立的模块，好好利用他们吧，这样你的代码就能够做到低耦合、高内聚啦。

一个 Project 又包含很多个 Task，也就是说每个 Project 是由多个 Task 组成的。那么什么是 Task 呢？Task 就是一个操作，一个原子性的操作，比如打个jar包，拷贝一份文件，编译一次Java代码，上传一个 jar 到 Maven 中心库等等，这就是一个 Task，和 Ant 里的 Target，Maven 的 goal 是一样的。

### 3.4 创建一个任务

这里的 task 看着像一个关键字，其实他是 Project 对象的一个函数，原型为 create(String name, Closure configureClosure)

```groovy
task customTask1 {
	doFirst{
		println 'do first'
	}
	doLast{
		println 'doLast'
	}
}

//我们还可以通过 TaskContainer 创建任务，Project 对象已经默认定义好了 TaskContainer，这就是 tasks：
tasks.create('customTask2') {
	doFirst{
		println 'do first2'
	}
	doLast{
		println 'doLast2'
	}
}
```

### 3.5 任务依赖

任务之间使可以有依赖关系的，这样我们就能控制哪些任务先于哪些任务执行，哪些任务执行后，其他任务才能执行。比如我们运行 jar 任务之前，compile 任务一定要执行过，也就是 jar 依赖于 compile；Android 的 install 任务一定要一来 package 任务进行打包生成 apk，然后才能 install 设备里。

```groovy
task hello {
	doLast{
		println 'hello'
	}
}

task world {
	doLast{
		println 'world'
	}
}

task exTask(dependsOn: hello) {
	doLast{
		println '---Task end---'
	}
}

task exMultiTask {
	dependsOn hello, world
	doLast{
		println '---MultiTask end---'
	}
}
```

dependsOn 是 Task类的一个方法，可以接受多个依赖的任务作为参数。

### 3.6 任务间通过API控制、交互

创建一个任务和我们定义一个变量是一样的，变量名就是我们定义的任务名，类型是Task（参见Gradle API Doc），所以我们可以通过任务名，使用 Task 的 API 访问它的方法，属性，或者对任务重新配置等，这对于我们操纵任务是非常方便和灵活的，Ant的Target就没有这个这个特性。

和变量一样，要使用任务名操纵任务，必须先定义声明，因为脚本是顺序执行的。

![](http://upload-images.jianshu.io/upload_images/1662509-716b722f296e34a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如上示例，我们调用了doLast和First方法，在任务执行前后做一些事情。对于直接通过任务名操纵任务的原理是：Project在创建该任务的时候，同时把该任务对应的任务名注册为Project的一个属性，类型是Task。我们稍微改动下例子，看看是否有ex36Hello这个属性：

![](http://upload-images.jianshu.io/upload_images/1662509-5ba9383e4056d26b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们通过println project.hasProperty('ex36Hello')检查是否有这么个属性，运行后通过输出我们可以看到，打印的是TRUE，说明每一个任务都是Project的一个属性。
既然可以通过API操纵任务，那么当创建了多个任务时，同样也可以通过API让他们相互访问，比如可以增加一些依赖等等，就像两个两个变量相互访问一样.

### 3.7 自定义属性

Project 和 Task 都允许用户添加额外的自定义属性，要添加额外的属性，通过所属对应的 ext 属性即可，添加之后可以通过 ext 属性对自定义属性读取和设置，如果要同时添加多个自定义属性，可以通过 ext 代码块：

```groovy
//自定义一个Project的属性
ext.age = 18

//通过代码块同时定义多个自定义属性
ext{
	phone = 13874768888
	address = 'xiang'
}

task customProperty {
	ext.inner = 'innnnnner'

	doLast{
		println project.hasProperty('customProperty') //true
		println project.hasProperty('age') //true
		println project.hasProperty('inner')//返回fasle

		println "${age}"
		println "${phone}"
		println "${inner}"
	}
}
```

相比局部变量，自定义属性有更为广泛的作用域，你可以跨Project，跨Task访问这些自定义属性，只要你能访问这些属性所属的对象，那么这些属性都可以被访问到。
自定义属性不仅仅局限在 Project和Task上，还可以应用在SourceSet，这样等于每种SourceSet又多了一个可供配置的属性，想想我们Android Studio开发的时候，是不是有main SourceSet，当你使用productFlavors定义多个渠道的时候，还会新增其他很多的SourceSet。

### 3.8 脚本即代码，代码也是脚本

虽然我们在一个 gradle 文件中写脚本，但是我们写的都是代码，这一点一定要记清楚，这样你才能时刻的使用 Groovy、Java 以及 Gradle 的任何语法和 API 帮你完成你想做的事情，不要被脚本这两个字给限制死，是脚本吗？是的没错，但是不是简单的脚本，在这脚本文件上你可以定义 Class，内部类，导入包，定义方法，常量，接口，枚举等等，都是可以的，灵活运用，我们我们在项目中需要给生成的APK包以当前日期的格式命名，我们就定义了一个获取日期格式的方法，用于生成 APK 的文件名：
```
def buildTime(){
	def date = new Date()
	date.format('yyyy-MM-dd hh:ss')
}
```
这只是使用的一个例子，目的是让大家灵活搭配 Java、Groovy 和 Gradle，不要把它当成简单的脚本，所以它是一个脚本文件。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
