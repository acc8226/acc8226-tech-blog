我们已经知道，Gradle 是一个非常灵活的构建框架，他提供了构建的基础核心，为了对具体的业务进行构建，Gradle在此基础上提供了插件的概念，这样就能基于 Gradle 进行很好的扩展，而不改变其核心基础，又能满足不同业务的需要，这也是我们在架构中参考的。

我们做过Java开发都了解，它的大体流程都差不多，无非就是依赖第三方库，编译源文件，进行单元测试，打包发布等等，每个Java工程都差不多，Gradle为了不让我们在每个Java工程里都做这些重复的劳动工作，为了我们提供了非常核心、常用的Java,我们只要应用它，就可以非常轻松的构建出一个项目了。

### 6.1 如何应用

基于我们之前讲的应用插件章节，很容易的应用 Java 插件，我们常用的方式就是使用简称应用：

`apply plugin: 'java'`

通过以上脚本应用之后，Java 插件会为你的工程添加很多有用的默认设置和约定，比如源代码的位置，单元测试代码的位置，资源文件的位置等等，一般情况下我们最好都遵循它的默认设置，这样做的好处一来是我们不用写太多的脚本来自定义，二来便于团队协作，因为这是约定俗成的，大家都容易理解。

### 6.2 Java 插件约定的项目结构

我们前面的章节讲了 Gradle 的插件会为我们做一些默认设置和约定，这些约定很泛很杂，现在我们讲讲 Java 插件中为我们约定的 Java 的项目结构是怎样的，只有我们遵循了这些约定，Java 插件才能找到我们的 Java类，找到我们的资源进行编译，找到我们的单元测试类进行单元测试等等。

![](http://upload-images.jianshu.io/upload_images/1662509-03b622835e123f93.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

默认情况下，Java 插件约定 src/main/java 下为我们的项目源代码存放目录；src/main/resources 为要打包的文件存放目录，比如一些 Properties 配置文件和图片等；src/test/java为我们的单元测试用例存放目录，我们执行单元测试的时候，Gradle会在这个目录下搜索我们的单元测试用例执行；src/test/resources里存放的是我们单元测试中使用的文件。

main 和 test 是 Java 插件为我们内置的两个**源代码集合**，那么我们可以不可以自己添加一些呢，比如我有一个vip版本，是不是可以添加一个vip的目录来存放 vip 相关的 java 源码和文件呢，这个是完全可以的，如果要实现这个目的，我们在build脚本里这么配置

![](http://upload-images.jianshu.io/upload_images/1662509-244c3a374368af23.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

添加一个 vip 的源代码集合（源集），然后我们在 src 下新建 vip/java/vip/resources 目录就可以分别存放 vip 相关的源代码和资源文件了。仿照例子我们可以添加很多的源集，他们默认的目录结构是：

```text
src/sourceSet/java
src/sourceSet/resources
```

看到这里，读者有没有发现这个和我们 Android 多渠道打包发布很像（Android 插件详细介绍）。关于源集的改变我们后面是详细讲，这里大家知道先这样使用。

以上是Java默认定义的文件目录，特殊情况下我们可以改变他们，所以不建议这么做，下面我们说说改变的方法，只需要在 build 脚本配置对应目录即可。

![](http://upload-images.jianshu.io/upload_images/1662509-5984dbb196989de9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一般从Eclipse工程迁移过来的时候，我们的目录结构还是src这样的，一时不好去改变目录，所以可以采用这种配置，更改Java插件默认的目录即可。

### 6.3  如何配置第三方依赖

作为一个 Java 项目，不可避免的会依赖很多第三方 Jar，这也是值得提倡的，因为有很多优秀的开源工具和框架让我们更高效的研发，而不是重复发明轮子。

要想使用这些第三方依赖，你要告诉 Gradle 如何找到这些依赖，也就是我们要讲的依赖配置。一般情况下我们都是从仓库中查找我们需要的 Jar 包，在 Gradle 中要配置一个仓库的Jar依赖，首先我们得告诉 Gradle 我们要使用什么类型的仓库，这些仓库的位置在哪里，这里 Gradle 从知道从哪里去搜寻我们依赖的 Jar。

以上脚本我们配置了一个 Maven 中心库，告诉 Gradle 可以在 Maven 中心库中搜寻我们依赖的 Jar，初次之外，我们也可以从 jcenter 库、ivy 库、本地 Maven 库 mavenLocal、自己搭建的 Maven 私服库等等中搜寻，甚至我们本地配置的文件夹也可以作为一个仓库，由此可见，Gradle 支持的仓库非常丰富，也可以多个库一起使用，比如一些公共的开源框架可以从 mavenCentral 上下载，一些我们公司自己的私有 Jar 可以在我们公司自己搭建的Maven私服上下载：

![](http://upload-images.jianshu.io/upload_images/1662509-487ce0252b7ac2e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

好了，有了仓库，就需要通过配置来告诉 Gradle 我们需要依赖什么：

![](http://upload-images.jianshu.io/upload_images/1662509-2c6b88c378a79f4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上面例子中我们配置了一个 okhttp 的依赖，其中 compile 是依赖名称，它的意思表示我们在编译 Java 源文件时需要依赖okhttp；group、name、以及 version，看他们的名字和顺序，我们熟悉 Maven 的非常熟悉，他们就是 Maven 中的 GAV(groupid、artifactid、version)，这是 Maven 非常重要的组成文件，他们三个合起来标记一个唯一的构件。

是不是觉得每次写 group、name、version 非常麻烦，是的，我也是，Gradle 这么好用的工具不会想不到，所以为我们提供了简写的方式：

![](http://upload-images.jianshu.io/upload_images/1662509-7bc92f02e9bf3388.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

前面我们刚刚提了 compile 这个依赖，他是一个编译时依赖，那么有没有专门针对单元测试代码编译的依赖呢，比如junit4，我正常的代码编译时根本用不上，如果强制使用 compile 也可以，但是会junit4就会被打包到发布的产品中，这不能增加了产品的大小，也为维护带来了不变，所以 Gradle 为我们提供了**testCompile依赖**，它只会在编译单元测试用例是使用，不会打包到发布的产品中，职责分明。现在我们看看还为我们提供了哪些依赖。

![](http://upload-images.jianshu.io/upload_images/1662509-e31e9d4b6c251b44.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

除此之外，Java 插件可以为不同的源集在编译时和运行时指定不同的依赖，比如 main 源集指定一个编译时的依赖，vip源集可以指定另外一个不同的依赖。

![](http://upload-images.jianshu.io/upload_images/1662509-bc07cc777145cc5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![他们的通用使用格式](http://upload-images.jianshu.io/upload_images/1662509-b85ad97a2de7bbcb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们刚刚讲的基于库的这种依赖是外部模块的依赖，一般都会配置一个仓库，不管 是Maven，还是 Ivy 等。除了外部依赖之外，常用的还有项目依赖以及文件依赖。

项目依赖依赖的是一个 Gradle 项目，是在 Settings Build 文件中配置过的，依赖一个项目非常简单，比如

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1662509-54dd52e7ffef2710.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这就是一个项目依赖，依赖后，这个项目中的java类等就会为你所用，就像使用自己项目中的类一样。

其次还有文件依赖，这种一般是依赖一个 Jar 包，由于各种原因，我们不能把这个 jar 发布到 Maven 中心库中，也没有自己搭建 Maven 私服，所以只能放在项目中，加入就放在libs文件夹下吧，现在我们就需要依赖它，然后才能使用它提供的功能：

![](http://upload-images.jianshu.io/upload_images/1662509-00b9f0ad348122a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就配置了依赖，成功的引入了这两个 jar 包。但是有时候我们 libs 文件夹里的类太多，不能一个个这么写啊，太多了，这种情况 Gradle 也为我们考虑到了

![](http://upload-images.jianshu.io/upload_images/1662509-4dff1a4c2539997a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样配置后，libs 文件加下的扩展名为 jar 的都会被依赖，非常方便，这里用到的是 Project的fileTree 方法，而不是上面用的 files 方法。

### 6.4 如何构建一个 Java 项目

在 Gradle 中，执行任何操作都是任务驱动的，构建 Java 项目也不例外。Java 插件为我们提供了很多任务，通过运行他们来达到我们构建J ava 项目的目的。最常用任务是 build 任务，运行它会构建你的整个项目，我们可以通过 ./gradlew build 执行，然后 gradle 就会编译你的源码文件，处理你的资源文件，打成jar包，然后编译测试用例代码，处理测试资源，最后运行单元测试。下面我们运行下看看效果：

![](http://upload-images.jianshu.io/upload_images/1662509-b7762df1f1767921.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看下任务运行的顺序，就能看出我们在构建整个 Java 项目的时候，Java 插件都做了哪些事情。最后在 build/libs 生成 jar包。

除了 build 任务，还有一些其他常用的任务，比如 clean，这个是删除build目录以及其他构建生成的文件，如果编译中有问题，可以先执行 clean，然后再重新 build。

还有 assemble 任务，该任务不会执行单元测试，只会编译和打包，这个任务在 Android 里也有，执行它可以打 apk 包，所以它不止会打 jar 包，其实它算是一个引导类的任务，根据不同的项目类型打出不同的包。

还有check任务，它只会执行单元测试，有时候还会做一些质量检查，不会打jar包，也是个引导任务。

javadoc任务，可以为我们生成java格式的doc api文档。

通过运行不同的任务，进行不同的构建，达到不同的目的。

### 6.5 源码集合(SourceSet)概念

SourceSet-源代码集合-源集，是Java插件用来描述和管理源代码及其资源的一个抽象概念，是一个 Java 源代码文件和资源文件的集合。通过源集，我们可以非常方便的访问源代码目录，设置源集的属性，更改源集的java目录或者资源目录等等。

有了源集，我们就能针对不同的业务和应用对我们源代码进行分组，比如用于主要业务产品的main以及用于单元测试的test，职责分明清晰。他们两个也是 Java 插件默认内置的两个标准源集。

Java插件 在 Project 下为我们提供了一个 sourceSet 属性以及一个 sourceSets {}闭包来访问和配置源集。sourceSets是是一个SourceSetContainer，我们可以参见它的API，看它有哪些方法和属性供我们使用。sourceSets{}闭包配置的都是SourceSet对象，下面我们会讲它有哪些配置。

![](http://upload-images.jianshu.io/upload_images/1662509-9407f3225486e32a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

源集有很多有用的属性，通过这些属性我们可以很方便的访问或者对源集进行配置。下面列出一些常用的

![](http://upload-images.jianshu.io/upload_images/1662509-f24dd977ee830170.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 6.6 Java 插件添加的任务

Java插件为我们添加了很多有用的任务，我们已经介绍了一些，这一小结再详细介绍一些。

![](http://upload-images.jianshu.io/upload_images/1662509-6963a76eedfff4fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上这些是对所有Java项目都适用的任务，对于内置的main和test源集甚至我们自己的新增的源集也新增了一些任务

![](http://upload-images.jianshu.io/upload_images/1662509-9d60b494639246df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

运行任务的时候，列表中的任务名称中的**sourceSet**要换成你的源集的名称，比如main源集的就是compileMainJava。

此外还有一些用于描述整个构建生命周期的任务，比如 assemble，build，check 等等，这里就不一一介绍了，想具体了解的可以参考相关文档。

### 6.7 Java插件添加的属性

Java插件添加了很多常用的属性，这些属性都被添加到Project中，我们可以直接使用他们，比如我们前面已经用到的sourceSets。

![](http://upload-images.jianshu.io/upload_images/1662509-7605e2adf20805b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上这些都是我们常用的属性，注意看它的类型，然后对比Gradle API 文档看他没有有哪些可以使用的方法或者属性。

### 6.8 多项目构建

多项目构建，其实就是多个 Gradle 项目一起构建，比如我们本书的例子已经是一个多项目了，他们一起通过Settings.gradle 配置管理，每个项目里都有一个Build文件对该项目进行配置，然后采用项目依赖，就可以实现多个项目协作，这对于我们大项目的，模块化非常有用。

下面我们以一个多项目构建的例子，来说明多个项目之间如果依赖构建。

![](http://upload-images.jianshu.io/upload_images/1662509-002e4687c5021e45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上是目录结构，app是我们的主项目，base是我们的基础依赖项目。下面我们在Settings.gradle里配置他们。

![](http://upload-images.jianshu.io/upload_images/1662509-88cccf59e01dcf9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

现在这两个项目已经被我们加入到Gradle项目中了，做为Gradle项目。他们分别有自己的build文件，都是应用了Java插件，表明他们都是Java项目。
其中我们在base项目中定义了Person类以供app项目的HelloWorld使用，要使用其他项目中的类，我们需要在项目中的build文件中配置项目依赖。

app/build.gradle

![](http://upload-images.jianshu.io/upload_images/1662509-76bf43e3c56efebc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

配置依赖后，我们就可以在app项目中随意使用base项目中的类了，就像我们在引用一个jar包一样。

![](http://upload-images.jianshu.io/upload_images/1662509-3ba9ff5838b3914f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就完成了一个多项目中的构建，项目之间相互协作在Gradle中变得如此容易，别惊讶还有更炫的功能，有没有注意到我们的项目都是 Java 项目，应用的都是 Java 插件，对于这类公用的配置，Gradle 为我们提供了基于根项目对其所有的子项目通用配置的方法。**Gradle的根项目可以理解为一个所有子项目的容器**，我们可以在根项目中遍历所有的子项目，在遍历的过程中为其配置通用配置。

![](http://upload-images.jianshu.io/upload_images/1662509-41de53362874ea42.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上配置就是让其所有子项目应用了 Java 插件，所以所有的子项目都是 Java 项目，这比我们一个个的对每个子项目配置要方便的多，除了应用插件我们可以配置其他公用配置，比如仓库.
还比如配置我们的 Java 项目都使用 junit 进行单元测试

![](http://upload-images.jianshu.io/upload_images/1662509-d1216d31493de711.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

subprojects 可以对其所有的子项目进行配置，如果想对包括根项目在内的所有项目进行统一配置，我们可以使用allprojects，用法和 subprojects一样，就不举例子了，大家可以自己尝试一下。

### 6.9 如何发布构件

有时候我们的项目是一个库工程，要发布 Jar 给其他工程使用，Gradle 为我们提供了非常方便、功能抢到的发布功能，通过配置，我们可以把我们的jar包发布到本地目录、Maven库，Ivy 库等等中。

### 6.10 生成 Idea 和 Eclipse 配置

Gradle 为我们提供了 idea 和 eclips 插件来帮助我们生成不同 IDE 下的配置文件，这样我们就能直接使用不同的IDE导入项目即可，满足我们不同 IDE 下的快速配置开发。

![](http://upload-images.jianshu.io/upload_images/1662509-f1e92ec024adedbd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们执行./gradlew :example610:idea 就可以生成 idea 相关的工程配置文件，让我们使用IDEA可以直接把它作为IDEA工程导入；相似的执行 ./gradlew :example610:eclipse就能生成供 Eclipse 直接导入的 Eclipse 工程配置文件。

### 6.11 小结

Java 工程是我们最熟悉最常用的工程，Java 插件对此支持非常好，我们花了 10 个小节介绍 Java，但是由于篇幅所限，还是有非常多的功能不能一一介绍，比如单元测试报告，Jar 包的 Manifest 清单配置等等，如果大家有兴趣，可以想看相关文档，加深对 Java 插件的理解，理解了 Java 插件后，对于我们理解下章 Android 插件就容易多了。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
