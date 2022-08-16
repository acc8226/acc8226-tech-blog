对于研发来说，测试永远都是绕不开的，通过测试我们可以减少bug率，提高产品的质量。测试有黑白之分，我们这里主要讲白盒测试，也就是基于现有代码逻辑的测试，比如单元测试等。

Android为测试提供了很好的支持，既可以使用传统的Junit测试，又可以使用Android提供的Instrument测试，这一章我们主要讲Android Gradle和Android测试之间的配合和结合，期间会涉及一些单元测试用例或者对一些测试框架的使用，但是主要介绍点还是Android Gradle和Android测试，对于Android测试本身介绍不多，关于Android测试本身，比如Activity等四大组件测试、UI自动化测试、espresso UI测试框架等可以参考官方文档。

### 12.1 基本概念
在Android Gradle中，测试应用相关已经被作为项目的一部分，而不再是一个单元的测试工程了，这对我们一起管理引用代码比较方便。它是一个SourceSet，这个我们之前有过介绍，比如有main SourceSet，对测试来说有androidTest SourceSet。当我们使用Android Studio新建一个项目的时候，会帮我们默认生成main和androidTest SourceSet，路径和main相似，是src/androidTest/，当我们运行测试的时候，androidTest SourceSet会被构建成一个可以安装到设备上的测试Apk，这个测试Apk里有很多我们写好的测试用例，他们会被执行，来测试我们的App。

在androidTest SourceSet里我们可以依赖各种测试库，写很多方面的测试用例，比如单元测试的、集成测试的，espresso UI测试的，uiautomator自动化测试的等等。

既然它可以生成一个Apk，那么它一定有Apk的必备属性和文件，比如包名、比如AndroidManifest.xml文件等等，那么他们是怎么被配置的呢，还记得我们讲的ProductFlavor吗？它里面有很多以test开头的配置，这些就是我们用来配置测试Apk用的。一般测试Apk我们会统一配置，而不是针对每个渠道都配置，所以我们会在defaultConfig里来对测试Apk进行配置，让其自动生成所需要的包名、AndroidManifest.xml文件等信息，defaultConfig也可以这么配置，因为defaultConfig其实也是一个ProductFlavor。

1. testApplicationId 测试Apk的包名
2. testFunctionalTest 是否启用功能测试
3. testHandleProfiling 是否启用性能分析
4. testInstrumentationRunner 运行测试使用的Instrumentation Runner

这些配置我们在上一章多渠道里都有详细介绍，他们是用来配置Android测试的配置，帮助我们生成AndroidManifest.xml，其实主要是用来生成AndroidManifest的instrumentation这个标签。

![](http://upload-images.jianshu.io/upload_images/1662509-23532f5b6a70f2d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**最后会根据配置生成AndroidManifest.xml文件。**

![](http://upload-images.jianshu.io/upload_images/1662509-ffa5f8d9bb73eb12.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看到这里，我们应该发现一个现象，targetPackage这个属性我们并没有配置，怎么在AndroidManifest.xml也生成了呢，这是**Android Gradle自动帮我们做的**，它会使用被测试App的包名进行填充。

前面我们讲过，每一个SourceSet都可以配置它自己的dependencies依赖，androidTest也不例外，它也可以，并且它可以有自己的资源，配置等，和我们使用其他的SourceSet是一样的，该有的都有。

![](http://upload-images.jianshu.io/upload_images/1662509-0580915f6a575f90.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样只有Android测试的时候这些才会被编译到测试的Apk里，为我们测试所用，正式的Apk包里是没有这些Jar库的。

默认情况下测试Apk测试的目标Apk是debug模式下的，这有很大好处，第一个因为debug模式下的我们都不会混淆代码，对我们发现问题有帮助，第二个对我们查看测试的代码覆盖率有帮助，可以很容易的发现哪些没有覆盖到，如果想更改也很方便，Android Gradle为我们提供了testBuildType，可以更改要测试BuildType。

![](http://upload-images.jianshu.io/upload_images/1662509-ebe7b93068150e11.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样就改成测试的是release类型的Apk包了。testBuildType是android对象的一个属性，接受BuildType的名字作为参数，是一个String字符串。

![](http://upload-images.jianshu.io/upload_images/1662509-91fae7faf6dc8cb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从源代码里我们也可以看到，它的默认值是debug，也就是我们上面讲的测试的是debug类型的App包。

写好了测试的代码，我们怎么运行呢，测试需要我们手动执行来运行，使用./gradlew connectedCheck即可运行我们的测试，这个任务是一个引导性质的任务，它首先会使用androidAndroidTest任务构建好测试应用和被测试应用，其中被测试应用又是被assembleDebug任务构建的；然后通过install任务安装这两个应用；接着运行我们写好的测试用例，最后等运行完之后，写卸载两个应用。这个前提我们一定要有一台Android设备或者Android模拟器以供我们测试使用，如果你同时运行了多个设备，那么会在每个设备上都执行测试用例。

最后测试的结果会被保存在build/androidTest-results目录下，我们可以前往查看我们测试的结果。

以前讲的都是测试App，也就是Application项目，如果我们要测试一个库项目呢？其实和测试Application项目是一样的，配置、目录、依赖等都一样，唯一不同的是不会有被测试的Apk生成，只有一个测试Apk生成，我们库项目中的代码被作为一个依赖库添加到测试Apk中，库的AndroidManifest文件中的配置也会被合并到测试Apk的AndroidManifest中，有没有发现，其实一个Application项目引用库项目是一样的。运行测试方面也是一样的，执行命令行执行命令即可。

### 12.2 本地单元测试
今天到这里, .......



---
本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
