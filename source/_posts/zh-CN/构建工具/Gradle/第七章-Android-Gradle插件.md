从这章开始我们就开始介绍 Android Gradle 插件了，会通过几章由浅入深的详细的介绍 Android Gradle，本章会简单的介绍下 Android Gradle 插件，然后通过一个例子对其有大概的了解，最后讲下如果从原来基于 Eclipse 进行 Android 开发的方式，转到基于 Android Studio，使用 Android Gradle 插件开发的新方式

### 7.1 Android Gradle插件简介

从 Gradle 的角度看，我们知道 Android 其实就是 Gradle 的一个第三方插件，他是由 Google 的 Android 团队开发的，但是从Android 的角度看，Android 插件是基于 Gradle 构建的，和Android Studio完美无缝搭配的新一代构建系统，它不同于 Eclipse+Ant 的搭配，相比于旧的构建系统，它更灵活，更容易配置，还能很方便的创建衍生的版本--也就是我们常用的多渠道包。让我们看看 Android 官方对它的推崇程度：

1. 可以很容易的重用代码和资源
2. 可以很容易的创建应用的衍生版本，所以不管你是创建多个apk，还是不同功能的应用都很方便
3. 可以很容易的配置、扩展以及自定义构建过程
4. 和 IDE 无缝整合

上面说的 IDE 就是 Android Studio，真是 Android Gradle + Android Studio 搭配，工作不累。

### 7.2 Android Gradle插件分类

Android Gradle 插件的分类其实是根据 Android工程的属性分类的，在Android中有三类工程，一类是App应用工程，它可以生成一个可运行的 APK 应用；一类是 Library 库工程，它可以生成AAR包给其他的App工程公用，就和我们的Jar 一样，但是它包含了 Android 的资源等信息，是一个特殊的 Jar 包；最后一类是Test测试工程，用于对App工程或者 Library 库工程进行单元测试。

1. App 插件 id：com.android.application
2. Library 插件 id：com.android.library
3. Test 插件 id：com.android.test

通过应用以上三种不同的插件，就可以配置我们的工程是一个 Android App工程，还是一个 Android Library 工程，或者是一个 Android Test 测试工程，然后配合着 Android Studio，就可以分别对他们进行编译、测试、发布等操作。

### 7.3 应用Android Gradle 插件

在讲 Gradle 插件的时候，我们讲了要应用一个插件，必须要知道他们的插件id，除此之外，如果是第三方的插件，还要配置他们的依赖 classpath。Android Gradle 插件就是属于第三方插件，它托管在Jcenter上，所以在应用他们之前，我们要先配置依赖 classpath，这样当我们应用插件的时候，Gradle系统才能找到他们。

![](http://upload-images.jianshu.io/upload_images/1662509-d490a1c580cc5667.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们配置里仓库为 jcenter，这样当我们配置依赖的时候，gradle 就会去这个仓库里寻找我们的依赖。

然后我们在dependencies{}配置里我们需要的是 Android Gradle1.5.0 版本的插件。

buildscript{}这部分配置可以写到根工程的 build.gradle 脚本文件中，这样所有的子工程就不用重复配置了。

以上配置好之后，我们就可以应用我们的 Android Gradle 插件了。

![](http://upload-images.jianshu.io/upload_images/1662509-fa62816a00cc67fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

android{} 是 Android 插件提供的一个扩展类型，可以让我们自定义Android Gradle 工程。compileSdkVersion是编译所依赖的 Android SDK 的版本，这里是 API Level；buildToolsVersion 是构建该 Android 工程所以的构建工具的版本。

以前应用的是一个 App 工程插件，应用 Android Library 插件和 Android Test 插件也类似的，只需要换成相应的id即可。

### 7.4 Android Gradle 工程示例

Android Gradle 插件继承于 Java 插件，具有所有 Java 插件的特性，它也需要在 Setting 文件里通过 include 配置包含的子工程，也需要应用Android插件等等。

下面我们就通过一个 App 工程的示例，来演示下App的工程目录结构以及相关的Android Gradle配置。

我们可以通过Android Studio创建一个App工程，创建后我们可以看到其大概工程目录结构如下：

![](http://upload-images.jianshu.io/upload_images/1662509-fd646eb56624247c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其目录结构和 Java 工程相比没有太大的变化，proguard-rules.pro 是一个混淆配置文件；src 目录下的 androidTest、main、test 分别是三个 SourceSet，分别对应 Android 单元测试代码、Android App主代码和资源、普通的单元测试代码。我们注意到 main 文件夹，相比 Java 的，多了 AndroidManifest.xml，res这两个属于Android 特有的文件目录，用于描述 Android App 的配置和资源文件。

下面我们来看看 Android Gradle的build.gradle 配置文件

Android Gradle 工程的配置，都是在 android{} 中，这是唯一的一个入口，通过它，可以对 Android Gradle 工程进行自定义的配置，其具体实现是 com.android.build.gradle.AppExtension，是 Project 的一个扩展，创建原型如下：

![](http://upload-images.jianshu.io/upload_images/1662509-d12f94b1ffa83930.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在 com.android.application 插件中，getExtensionClass()返回的就是 com.android.build.gradle.AppExtension，所以关于 android 的很多配置可以从这个类里去找，参考我们前面讲的Gradle知识，可以找到很多试用的配置或者可以利用的对象、方法或者属性等等，而这些并没有在Android文档里介绍的，这就是可以看源代码的好处。

##### 7.4.1 compileSdkVersion

compileSdkVersion 23，是配置我们编译 Android 工程的SDK，这里的 23 是 Android SDK 的 API Level，对应的是Android6.0的SDK，这个大家都清楚的。该配置的原型是一个 compileSdkVersion 方法

![](http://upload-images.jianshu.io/upload_images/1662509-207fee7d105a8bee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

除此之外，他还有一个 set 方法，所以我们可以把它当成 android 的一个属性使用。

![](http://upload-images.jianshu.io/upload_images/1662509-e3ccc04101053e43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用方式是：

![](http://upload-images.jianshu.io/upload_images/1662509-bd8ec2023e0f9b62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这就是 Gradle 的灵活支出，通过不同的方法，就可以达到不同的配置方式。

### 7.4.2 buildToolsVersion

buildToolsVersion "23.0.1"表示我们使用的Android 构建工具的版本，我们可以在Android SDK目录里看到，它是一个工具包，包括appt，dex等工具。它的原型也是一个方法。

![](http://upload-images.jianshu.io/upload_images/1662509-bb528264f3b41fa2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从以上的方法原型中可以看到，我们可以通过 buildToolsVersion 方法赋值，也可以通过android.buildToolsVersion 这个属性读写它的值。

##### 7.4.3 defaultConfig

defaultConfig 是默认的配置，它是一个 ProductFlavor，ProductFlavor 允许我们根据不同的情况同时生成多个不同的APK包，比如我们后面介绍的多渠道打包。如果不针对我们自定义的 ProductFlavor 单独配置的话，会为这个ProductFlavor使用**默认的defaultConfig**的配置。

例子中applicationId是配置我们的包名，这里是 org.flysnow.app.example74

minSdkVersion 是最低支持的 Android 系统的API Level，这里是14
targetSdkVersion 表明我们是基于哪个Android版本开发的，这里是23
versionCode 我们的 App 应用内部版本号，一般用于控制App升级
versionName 我们的 App 应用的版本名称，用户可以看到，就是我们发布的版本，这里是1.0

以上所有配置对应的都是ProductFlavor类里的方法或者属性。

##### 7.4.4 buildTypes

buildTypes 是一个 NamedDomainObjectContainer 类型，是一个域对象，还记得我们讲的 SourceSet 吗？这个和那个一样。SourceSet里有main、test 等，同样的 buildTypes 里有 release，debug 等，我们可以在 buildTypes{}里新增任意多个我们需要构建的类型，比如debug，Gradle会帮我们自动创建一个对应的BuildType，名字就是我们定义的名字。

release 就是一个 BuildType，后面章节我们会详细介绍BuildType，例子中我们用到了两个配置

minifyEnabled 是否为该构建类型启用混淆，我们这里是 false 表示不启用，如果想要启用可以设置为true

proguardFiles，当我们启用混淆时，所使用的 proguard 的配置文件，我们可以通过它配置我们如何进行proguard混淆，比如混淆的级别，哪些类或者方法不进行混淆等等。它对应 BuildType的proguardFiles 方法，可以接受一个可变参数，所以我们同时可以配置多个配置文件，比如我们例子中的
`proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'`

getDefaultProguardFile 是 android 扩展的一个方法，它可以获取你的 Android SDK 目录下的默认的 proguard 配置文件，在android-sdk/tools/proguard/ 目录下，文件名就是我们传入的参数的名字proguard-android.txt。

其他还有很多有用的配置，我们后面的章节都会一一介绍，这里只简单的介绍入门示例，让大家对Android Gradle有一个大概的了解

### 7.5 Android Gradle任务

我们说过 Android 插件是基于 Java 插件，所以 Android 插件基本上包含里所有 Java 插件的功能，包括继承的任务，比如assemble、check、build 等等，除此之外，Android 在大类上还添加了 connectedCheck、deviceCheck、lint、install、uninstall等任务，这些是属于 Android 特有的功能。

connectedCheck 在所有链接的设备或者模拟器上运行 check 检查

deviceCheck 通过 API 连接远程设备运行 checks。它被用于 CI(译者注:持续集成)服务器上。

lint 在所有的 ProductFlavor 上运行lint检查。

install 和 uninstall 类的任务可以直接在我们已链接的设备上安装或者卸载你的App。

除此之外，还有一些不太常用的任务，比如signingReport 可以打印App的签名；androidDependencies 可以打印android的依赖，还有其他一些类似的任务，大家可以通过./gradlew tasks来查看。

一般我们常用的任务是 build、assemble 、clean、lint、以及check等，通过这些任务我们可以打包生成我们的Apk，对现有的 Android 工程进行lint检查等等。

### 7.6 从 Eclipse 迁移到 Android Gradle 工程

最开始的时候还没有 Android Studio，也没有 Android Gradle 这个插件，我们都是使用 Eclipse+ADT+Ant 进行Android 开发，用过Ant的，再和我们的 Gradle 对比一下，就会发现 Gradle 的灵活，还有Android Studio这个强大的IDE和Android Gradle完美配合，会使得我们开发效率大大提高，所以很多人都迫不及待的想从原来基于Eclipse+ADT+Ant，迁移到我们的Android Studio+Gradle，这一小结我们就简单的讲下如何迁移。

从Eclipse迁移到Android Studio有两种方式，一种是使用Android Studio直接导入Eclipse工程，另外一种使用Eclipse导出Android Gradle配置文件，转换为一个Gradle工程，然后再使用Android Studio把它作为一个Gradle工程导入。

##### 7.6.1 使用Android Studio 导入

这种方式比较简单，要导入到 Android Studio，我们打开 Android Studio，选择 File->Import Project,然后会弹出一个对话框，选择我们的 Eclipse ADT 工程的目录，然后就会打开一个向导，按向导一步步操作，最后完成的时候，会打开一个 "import-summary.txt" 文件，里面描述的我们这次导入涉及到的文件迁移和改变等等，我们再根据我们上面讲的 Android Gradle 工程结构做调整即可。

以上是我导入的一个例子生成的 import-summary.txt，我们可以看到有一段 Moved Files，也就是说，这种导入方式，会把我们原来Eclipse+ADT项目的目录结构转换成了 Android Studio 的目录结构，破坏了原来的目录结构，如果对于目录结构有严格要求的，就不要使用这种方式了，可以使用我们下面讲的第二种方式，如果没有严格要求的，建议采用这种方式，因为这是Android Studio默认推荐的目录结构，也可以熟悉下，为以后的新的功能，甚至团队间的协作也方便，因为它毕竟是 Android Studio 的一种默认的约定，大家都熟悉，沟通交流简单。

##### 7.6.2 从Eclipse+ADT中导出

从Eclipse导出，也非常简单，我们首先打开Eclipse，然后在其中找到我们要导出的工程，右击->Export，导出之前确保你的ADT越新越好，因为可能有些BUG会在新版里修复。

选择导出之后，会看到一个对话框，我们在其中展开Android，然后会看到 Generate Gradle Build Files 选项，选择它即可，然后就会打开一个向导，我们按找向导操作，就会生成 Gradle Android 工程需要的Setting和build脚本文件。

![](http://upload-images.jianshu.io/upload_images/1662509-68b5b214364c9aad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后我们再打开Android Studio，然后选择 File->Import Project，选择我们刚刚导出的 Android 工程目录，然后 Next，一步步即可导入到Android Studio中。

下面我们看下这种方式生成的build.gradle脚本示例

![](http://upload-images.jianshu.io/upload_images/1662509-9d14dbea29f95d5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这种方式保留了原来项目的目录结构，为了达到这个目的，又让Android Studio可以识别该项目，所以 Eclipse Export 功能对生成的 build.gradle 脚本文件做了处理，从上面的例子中我们可以看到，重写了main这个SourceSet，为Android Studio 指明我们的 java 文件、res 资源文件、assets 文件、aidl 文件以及 manifest 文件在项目中的位置，这中Android Studio 才能识别他们，进而作为一个 Android 工程进行编译构建。

以前的 Eclipse+ADT 的工程结构，单元测试是放在 tests 目录下的，所以在这里对其单元测试目录进行了重新设置，指定我们原来的 tests 目录为其单元测试根目录。debug、和 release 这两个 Build Type 也类似。

以上两种迁移方式，大家根据自己的情况选择，不过还是**建议大家选择第一种**，迁移后就用 Android Studio 的目录结构来开发，不然会有很多兼容性的 build 脚本代码，以后Android Gradle插件升级也不容易，因为有时候会有一些兼容，导致以后的任何变动都要小心翼翼。

### 7.7 小结

这一章介绍了 Android Gradle 插件，让大家对 Android Gradle 以及 Android Studio 工程有一个简单而全面的了解，也可以基于这些知识新建自己的 Android Gradle 工程，并进行开发，是一个整体的认识，了解其中的一些基本的概念。

下几章会从一些现实中的项目使用到的情况来介绍 Android Gradle，比如多工程打包，比如发布库工程，比如多渠道打包等等，等这些介绍完之后，相信大家已经非常熟悉和使用 Android Gradle 了，然后会用一章对 Android Gradle 做一个全面的介绍，到时候会有很多你没有见过的配置和功能等等。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
