从这章开始我们就开始介绍Android Gradle插件了，会通过几章由浅入深的详细的介绍Android Gradle，本章会简单的介绍下Android Gradle插件，然后通过一个例子对其有大概的了解，最后讲下如果从原来基于Eclipse进行Android开发的方式，转到基于Android Studio，使用Android Gradle插件开发的新方式

### 7.1 Android Gradle插件简介

从Gradle的角度看，我们知道Android其实就是 Gradle 的一个第三方插件，他是由Google 的Android团队开发的，但是从Android的角度看，Android插件是基于 Gradle 构建的，和Android Studio完美无缝搭配的新一代构建系统，它不同于Eclipse+Ant的搭配，相比于旧的构建系统，它更灵活，更容易配置，还能很方便的创建衍生的版本--也就是我们常用的多渠道包。让我们看看Android官方对它的推崇程度：

1. 可以很容易的重用代码和资源
2. 可以很容易的创建应用的衍生版本，所以不管你是创建多个apk，还是不同功能的应用都很方便
3. 可以很容易的配置、扩展以及自定义构建过程
4. 和IDE无缝整合

上面说的IDE就是Android Studio，真是Android Gradle+Android Studio搭配，工作不累。

### 7.2 Android Gradle插件分类

Android Gradle插件的分类其实是根据Android工程的属性分类的，在Android中有三类工程，一类是App应用工程，它可以生成一个可运行的APK应用；一类是Library库工程，它可以生成AAR包给其他的App工程公用，就和我们的Jar一样，但是它包含了Android的资源等信息，是一个特殊的Jar包；最后一类是Test测试工程，用于对App工程或者Library库工程进行单元测试。

1. App插件id：com.android.application
2. Library插件id：com.android.library
3. Test插件id：com.android.test

通过应用以上三种不同的插件，就可以配置我们的工程是一个Android App工程，还是一个Android Library工程，或者是一个Android Test测试工程，然后配合着Android Studio，就可以分别对他们进行编译、测试、发布等操作。

### 7.3 应用Android Gradle 插件

在讲Gradle插件的时候，我们讲了要应用一个插件，必须要知道他们的插件id，除此之外，如果是第三方的插件，还要配置他们的依赖classpath。Android Gradle插件就是属于第三方插件，它托管在Jcenter上，所以在应用他们之前，我们要先配置依赖classpath，这样当我们应用插件的时候，Gradle系统才能找到他们。

![](http://upload-images.jianshu.io/upload_images/1662509-d490a1c580cc5667.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们配置里仓库为jcenter，这样当我们配置依赖的时候，gradle就会去这个仓库里寻找我们的依赖。

然后我们在dependencies{}配置里我们需要的是Android Gradle1.5.0版本的插件。

buildscript{}这部分配置可以写到根工程的build.gradle脚本文件中，这样所有的子工程就不用重复配置了。

以上配置好之后，我们就可以应用我们的Android Gradle插件了。

![](http://upload-images.jianshu.io/upload_images/1662509-fa62816a00cc67fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

android{}是Android插件提供的一个扩展类型，可以让我们自定义Android Gradle工程。compileSdkVersion是编译所依赖的Android SDK的版本，这里是API Level；buildToolsVersion是构建该Android工程所以的构建工具的版本。

以前应用的是一个App工程插件，应用Android Library插件和Android Test插件也类似的，只需要换成相应的id即可。

### 7.4 Android Gradle 工程示例

Android Gradle插件继承于Java插件，具有所有Java插件的特性，它也需要在Setting文件里通过include配置包含的子工程，也需要应用Android插件等等。

下面我们就通过一个App工程的示例，来演示下App的工程目录结构以及相关的Android Gradle配置。

我们可以通过Android Studio创建一个App工程，创建后我们可以看到其大概工程目录结构如下：

![](http://upload-images.jianshu.io/upload_images/1662509-fd646eb56624247c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其目录结构和Java工程相比没有太大的变化，proguard-rules.pro是一个混淆配置文件；src目录下的androidTest、main、test分别是三个SourceSet，分别对应Android单元测试代码、Android App主代码和资源、普通的单元测试代码。我们注意到main文件夹，相比Java的，多了AndroidManifest.xml，res这两个属于Android特有的文件目录，用于描述Android App的配置和资源文件。

下面我们来看看Android Gradle的build.gradle配置文件

Android Gradle工程的配置，都是在android{}中，这是唯一的一个入口，通过它，可以对Android Gradle工程进行自定义的配置，其具体实现是com.android.build.gradle.AppExtension，是Project的一个扩展，创建原型如下：

![](http://upload-images.jianshu.io/upload_images/1662509-d12f94b1ffa83930.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在com.android.application插件中，getExtensionClass()返回的就是com.android.build.gradle.AppExtension，所以关于android的很多配置可以从这个类里去找，参考我们前面讲的Gradle知识，可以找到很多试用的配置或者可以利用的对象、方法或者属性等等，而这些并没有在Android文档里介绍的，这就是可以看源代码的好处。

##### 7.4.1 compileSdkVersion

compileSdkVersion 23，是配置我们编译Android工程的SDK，这里的23是Android SDK的API Level，对应的是Android6.0的SDK，这个大家都清楚的。该配置的原型是一个compileSdkVersion方法

![](http://upload-images.jianshu.io/upload_images/1662509-207fee7d105a8bee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

除此之外，他还有一个set方法，所以我们可以把它当成android的一个属性使用。

![](http://upload-images.jianshu.io/upload_images/1662509-e3ccc04101053e43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用方式是：

![](http://upload-images.jianshu.io/upload_images/1662509-bd8ec2023e0f9b62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这就是Gradle的灵活支出，通过不同的方法，就可以达到不同的配置方式。

### 7.4.2 buildToolsVersion

buildToolsVersion "23.0.1"表示我们使用的Android 构建工具的版本，我们可以在Android SDK目录里看到，它是一个工具包，包括appt，dex等工具。它的原型也是一个方法。

![](http://upload-images.jianshu.io/upload_images/1662509-bb528264f3b41fa2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从以上的方法原型中可以看到，我们可以通过buildToolsVersion方法赋值，也可以通过android.buildToolsVersion这个属性读写它的值。

##### 7.4.3 defaultConfig

defaultConfig 是默认的配置，它是一个 ProductFlavor，ProductFlavor允许我们根据不同的情况同时生成多个不同的APK包，比如我们后面介绍的多渠道打包。如果不针对我们自定义的ProductFlavor单独配置的话，会为这个ProductFlavor使用**默认的defaultConfig**的配置。

例子中applicationId是配置我们的包名，这里是org.flysnow.app.example74

minSdkVersion 是最低支持的Android系统的API Level，这里是14

targetSdkVersion 表明我们是基于哪个Android版本开发的，这里是23

versionCode 我们的App应用内部版本号，一般用于控制App升级

versionName 我们的App应用的版本名称，用户可以看到，就是我们发布的版本，这里是1.0

以上所有配置对应的都是ProductFlavor类里的方法或者属性。

##### 7.4.4 buildTypes

buildTypes是一个NamedDomainObjectContainer类型，是一个域对象，还记得我们讲的SourceSet吗？这个和那个一样。SourceSet里有main、test等，同样的buildTypes里有release，debug等，我们可以在buildTypes{}里新增任意多个我们需要构建的类型，比如debug，Gradle会帮我们自动创建一个对应的BuildType，名字就是我们定义的名字。

release就是一个BuildType，后面章节我们会详细介绍BuildType，例子中我们用到了两个配置

minifyEnabled 是否为该构建类型启用混淆，我们这里是false表示不启用，如果想要启用可以设置为true

proguardFiles，当我们启用混淆时，所使用的proguard 的配置文件，我们可以通过它配置我们如何进行proguard混淆，比如混淆的级别，哪些类或者方法不进行混淆等等。它对应 BuildType的proguardFiles方法，可以接受一个可变参数，所以我们同时可以配置多个配置文件，比如我们例子中的
`proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'`

getDefaultProguardFile是android扩展的一个方法，它可以获取你的Android SDK目录下的默认的proguard配置文件，在android-sdk/tools/proguard/目录下，文件名就是我们传入的参数的名字proguard-android.txt。

其他还有很多有用的配置，我们后面的章节都会一一介绍，这里只简单的介绍入门示例，让大家对Android Gradle有一个大概的了解

### 7.5 Android Gradle任务

我们说过Android插件是基于Java插件，所以Android插件基本上包含里所有Java插件的功能，包括继承的任务，比如assemble、check、build等等，除此之外，Android在大类上还添加了connectedCheck、deviceCheck、lint、install、uninstall等任务，这些是属于Android特有的功能。

connectedCheck 在所有链接的设备或者模拟器上运行check检查

deviceCheck 通过API连接远程设备运行checks。它被用于CI(译者注:持续集成)服务器上。

lint 在所有的ProductFlavor上运行lint检查。

install和uninstall类的任务可以直接在我们已链接的设备上安装或者卸载你的App。

除此之外，还有一些不太常用的任务，比如signingReport 可以打印App的签名；androidDependencies 可以打印android的依赖，还有其他一些类似的任务，大家可以通过./gradlew tasks来查看。

一般我们常用的任务是build、assemble 、clean、lint、以及check等，通过这些任务我们可以打包生成我们的Apk，对现有的Android工程进行lint检查等等。

### 7.6 从Eclipse迁移到Android Gradle工程

最开始的时候还没有Android Studio，也没有Android Gradle这个插件，我们都是使用Eclipse+ADT+Ant进行Android开发，用过Ant的，再和我们的Gradle对比一下，就会发现Gradle的灵活，还有Android Studio这个强大的IDE和Android Gradle完美配合，会使得我们开发效率大大提高，所以很多人都迫不及待的想从原来基于Eclipse+ADT+Ant，迁移到我们的Android Studio+Gradle，这一小结我们就简单的讲下如何迁移。

从Eclipse迁移到Android Studio有两种方式，一种是使用Android Studio直接导入Eclipse工程，另外一种使用Eclipse导出Android Gradle配置文件，转换为一个Gradle工程，然后再使用Android Studio把它作为一个Gradle工程导入。

##### 7.6.1 使用Android Studio 导入

这种方式比较简单，要导入到Android Studio，我们打开Android Studio，选择File->Import Project,然后会弹出一个对话框，选择我们的Eclipse ADT工程的目录，然后就会打开一个向导，按向导一步步操作，最后完成的时候，会打开一个 "import-summary.txt" 文件，里面描述的我们这次导入涉及到的文件迁移和改变等等，我们再根据我们上面讲的Android Gradle工程结构做调整即可。

以上是我导入的一个例子生成的import-summary.txt，我们可以看到有一段Moved Files，也就是说，这种导入方式，会把我们原来Eclipse+ADT项目的目录结构转换成了Android Studio的目录结构，破坏了原来的目录结构，如果对于目录结构有严格要求的，就不要使用这种方式了，可以使用我们下面讲的第二种方式，如果没有严格要求的，建议采用这种方式，因为这是Android Studio默认推荐的目录结构，也可以熟悉下，为以后的新的功能，甚至团队间的协作也方便，因为它毕竟是Android Studio的一种默认的约定，大家都熟悉，沟通交流简单。

##### 7.6.2 从Eclipse+ADT中导出

从Eclipse导出，也非常简单，我们首先打开Eclipse，然后在其中找到我们要导出的工程，右击->Export，导出之前确保你的ADT越新越好，因为可能有些BUG会在新版里修复。

选择导出之后，会看到一个对话框，我们在其中展开Android，然后会看到Generate Gradle Build Files选项，选择它即可，然后就会打开一个向导，我们按找向导操作，就会生成Gradle Android工程需要的Setting和build脚本文件。

![](http://upload-images.jianshu.io/upload_images/1662509-68b5b214364c9aad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后我们再打开Android Studio，然后选择File->Import Project，选择我们刚刚导出的Android工程目录，然后Next，一步步即可导入到Android Studio中。

下面我们看下这种方式生成的build.gradle脚本示例

![](http://upload-images.jianshu.io/upload_images/1662509-9d14dbea29f95d5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这种方式保留了原来项目的目录结构，为了达到这个目的，又让Android Studio可以识别该项目，所以Eclipse Export功能对生成的build.gradle脚本文件做了处理，从上面的例子中我们可以看到，重写了main这个SourceSet，为Android Studio指明我们的java文件、res资源文件、assets文件、aidl文件以及manifest文件在项目中的位置，这中Android Studio才能识别他们，进而作为一个Android工程进行编译构建。

以前的Eclipse+ADT的工程结构，单元测试是放在tests目录下的，所以在这里对其单元测试目录进行了重新设置，指定我们原来的tests目录为其单元测试根目录。debug、和release这两个Build Type也类似。

以上两种迁移方式，大家根据自己的情况选择，不过还是**建议大家选择第一种**，迁移后就用Android Studio的目录结构来开发，不然会有很多兼容性的 build 脚本代码，以后Android Gradle插件升级也不容易，因为有时候会有一些兼容，导致以后的任何变动都要小心翼翼。

### 7.7 小结

这一章介绍了Android Gradle插件，让大家对 Android Gradle 以及Android Studio 工程有一个简单而全面的了解，也可以基于这些知识新建自己的Android Gradle工程，并进行开发，是一个整体的认识，了解其中的一些基本的概念。

下几章会从一些现实中的项目使用到的情况来介绍Android Gradle，比如多工程打包，比如发布库工程，比如多渠道打包等等，等这些介绍完之后，相信大家已经非常熟悉和使用Android Gradle了，然后会用一章对Android Gradle做一个全面的介绍，到时候会有很多你没有见过的配置和功能等等。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
