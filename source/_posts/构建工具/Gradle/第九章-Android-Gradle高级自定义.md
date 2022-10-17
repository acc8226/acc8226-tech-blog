这一章主要针对项目中可以用到的一些实用功能来介绍 Android Gradle，比如如何隐藏我们的证书文件，降低风险；如何批量修改生成的 apk 文件名，这样我们就可以修改成我们需要的，从文件名中就可以看到渠道，版本号以及生成日期等信息，这多方便啊；还有其他突破 65535 方法的限制等等。

### 9.1 使用共享库

android 的包，比如 android.app, android.content, android.view, 以及 android.widget等，这些是默认就包含在android sdk库里的，所有的应用都可以直接使用它们，系统会帮我们会自动链接他们，不会出现找不到相关类的情况。还有一些库，比如 com.google.android.maps、android.test.runner 等，这些库是独立的，并不会被系统自动链接，所以我们要使用他们的话，就需要单独进行生成使用，这类库我们称之为共享库。

在 AndroidManifest 文件中，我们可以通过<uses-library>来指定我们要使用的库

![](http://upload-images.jianshu.io/upload_images/1662509-48cdee2bb68aeeae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就声明了我们需要使用 maps 这个共享库，声明之后，在安装生成的APK包的时候，系统会根据我们的定义，帮我们检测我们的手机系统是否有我们需要的共享库，因为我们设置的android:required="true"，是必须，如果手机系统不满足，将不能安装该应用。

在Android 中，除了我们标准的 SDK，还存在两种库，一种是 add-ons 库，他们位于 add-ons 目录下，这些库大部分第三方厂商或者公司开发的，一般是为了让开发者使用，但是又不想暴漏具体标准实现的；第二类是optional可选库，他们位于 platforms/android-xx/optional目录下，一般是为了兼容旧版本的 API，比如 org.apache.http.legacy，这是一个 HttpClient 的库，从 API23 开始，标准的Android SDK中不再包含 HttpClient 库，如果还想使用 HttpClient 库，就必须使用 org.apache.http.legacy 这个可选库。

对第一类 add-ons 附件库来说，Android Gradle 会自动解析，帮我们添加到 classpath 里，但是第二类 optional可选库就不会了，我们看下关于这两种库的Android Gradle源码说明，位于IAndroidTarget.java文件中

![](http://upload-images.jianshu.io/upload_images/1662509-f3f2afad41350442.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这时候我们就需要自己把这个可选库添加到classpath中，为此，Android Gradle为我们提供了useLibrary方法，让我们可以把一个库添加到我们的classpath中，这样我们才能在代码中使用他们。

只要知道它的名字，我们就可以使用useLibrary把他们添加到classpath，这样我们的编译就可以通过了。useLibrary是一个方法，看下它的源代码实现
```
    public void useLibrary(String name) {
        this.useLibrary(name, true);
    }

    public void useLibrary(String name, boolean required) {
        this.libraryRequests.add(new LibraryRequest(name, required));
    }
```

以上的 Android Gradle 配置已经可以生成 Apk 安装运行，但是按照上面的两类库的官方源代码说明文档，我们最好也要在 AndroidManifest 文件中配置下 uses-library 标签，以防万一。

对于 Api Level 低于 23 的系统来说，默认的标准库里已经包含了Apache HttpClient库，所以我们这里的Android Gradle配置只是为了保证编译的通过，那么对于等于或者大于 23 的系统呢？系统标准包（不是 Android 开发Sdk提供，是手机里）里有没有 Apache HttpClient 库呢？如果没有，是不是已经把他当成一个共享库呢？试试如果不在AndroidManifest文件中配置下 uses-library 标签是否可以运行？友情提示：PackageManager().getSystemSharedLibraryNames()方法。

### 9.2 批量修改生成的apk文件名

普通的Java比较简单，因为它有一个有限的任务集合，而且它的属性或者方法都是 Java Gradle 插件添加的，比较固定，而且我们访问任务以及任务里的方法和属性都比较方便，比如 classes 这个编译 Java 源代码的任务，我们通过 project.tasks.classes 就可以访问它，非常快捷，但是对于 Android 工程，就不行了，Android工程相对与Java工程来说，要复杂的多，因为它有很多相同的任务，这些任务的名字都是通过 Build Types 和 Product Flavors 生成的，是动态的创建和生成的，而且时机比较靠后，如果你还像原来一样在某个闭包里通过 project.tasks 获取一个任务，会提示找不到该任务，因为还没有生成。

既然要修改生成的 Apk 文件名，那么我们就要修改 Android Gradle 打包的输出，为了解决这个问题（不限于此），android对象为我们提供了2个属性：

* applicationVariants (仅仅适用于 Android 应用Gradle 插件)
* libraryVariants (仅仅适用于 Android 库 Gradle 插件)
* testVariants (以上两种Gradle插件都使用)

以上三个属性返回的都是 DomainObjectSet 对象集合，里面元素分别是A pplicationVariant、LibraryVariant和TestVariant。这三个元素直译来看是变体，通俗的讲他们就是 Android 构建的产物，比如ApplicationVariant代表google渠道的 release 包，也可以代表 dev 开发用的 debug 包，我们上面提到了，他们基于Build Types和Product Flavors 生成的产物，后面的多渠道打包章节我们会详细讲解。

特别注意的是，访问以上这三种集合都会触发创建所有的任务，这意味着访问这些集合后无须重新配置就会产生，也就是说假如我们通过访问这些集合，修改生成 Apk 的输出文件名，那么就会自动的触发创建所有任务，此时我们修改后的新的 Apk 文件名就会起作用，达到可我们修改 Apk 文件名的目的，因为这些是一个集合，包含里我们所有生成的产物，所以我们只需要进行迭代，就可以达到我们批量修改 Apk 文件名的目的。

com.android.build.gradle.AppExtension 中的 getApplicationVariants 方法

```java
    public DomainObjectSet<ApplicationVariant> getApplicationVariants() {
        return this.applicationVariantList;
    }
```

下面我们给出一个批量修改 Apk 文件名的例子

![](http://upload-images.jianshu.io/upload_images/1662509-3c998d38e390358d.png)

applicationVariants 是一个 DomainObjectCollection集合，我们可以通过 all 方法进行遍历，遍历的每一个variant都是一个生成的产物，针对示例，共有googleRelease 和 googleDebug 两个产物，所以遍历的variant 共有 googleRelease 和 googleDebug。

applicationVariants 中的 variant 都是ApplicationVariant，通过查看源代码，可以看到它有一个outputs 作为它的输出，每一个 ApplicationVariant至少有一个输出，也可以有多个，所以这里的 outputs属性是一个List 集合，我们再遍历它，如果它的名字是以.apk结尾的话那么就是我们要修改的apk名字了，然后我们就可以根据需求，修改成我们想要的名字，我这里修改的是以'项目名_渠道名_v版本名称_构建日期.apk'格式生成的文件名，这样通过文件名就可以把该apk的基本信息了解，比如什么渠道，什么版本，什么时候构建的等等，最后生成的示例apk名字为Example92_google_v1.0_20160229.apk，大家可以运行测试一下，注意 buildTime 这个我们自定义的返回日期格式的方法。

这一小节主要介绍批量修改 Apk 文件名，其中涉及到了对现有生成产出（变体）的操纵，然后引出了多渠道以及操纵任务等信息的两个属性集合，并且对他们做了简单介绍，后面的多渠道打包一章我会详细讲解，这里大家大概了解下原理，会使用即可。

### 9.3 动态生成版本信息

每一个应用都会有一个版本号，这样用户就知道自己安装的应用是哪个版本，是不是最新版，有了问题，也可以找客服报上自己的版本，让客服有针对性的帮用户解决问题。一般的版本有三部分构成：major.minor.patch，第一个是主版本号，第二个是副版本号，第三位补丁号，这种我们常见的见识1.0.0这样的，当然也有两位的 1.0，对应 major.minor，这里我们以三位为例。

最开始的时候我们都是配置在build文件里的，如下：

![](http://upload-images.jianshu.io/upload_images/1662509-7d789a96aff0add5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这种方式我们直接写在 versionName 的后面，比较直观。但是这种方式有个很大的问题就是**修改不方便**，特别当我们的 build 文件中有很多代码时，不容易找，而且修改容易出错，代码版本管理时也容易产生冲突。

##### 9.3.2 分模块的方式

既然最原始的方式，修改不方便，那么我们可以不可以把版本号的配置单独的抽取出来的，放在单独的文件里，供 build 引用，就像我们在 Android 里，单独新建一个存放常量的Java类一样，供其他类调用，幸运的是，android 是支持基于文件的模块化的，他就是 apply from。

还记得我们应用插件的知识吧，我们不光可以应用一个插件，也可以把另一个gradle文件引用进来。我们新建一个version.gradle文件，用于专门存放我们的版本。

![](http://upload-images.jianshu.io/upload_images/1662509-e1cb4c270b1e650b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

ext{}块表明我们要为当前project创建扩展属性，以供其他脚本引用，他就像我们java里的变量一样。创建好之后，我们在build.gradle中引用它。

![](http://upload-images.jianshu.io/upload_images/1662509-f27aee87e7681d2c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这种方式，我们每次只用修改version.gradle里的版本号即可，方便，容易，也比较清晰，在团队协作的过程中，大家看到这个文件，就能猜测出来它大概是做什么的。

##### 9.3.3 从 git 的 tag 中获取

一般 jenkins 打包发布的时候，我们都会从我们已经打好的一个tag打包发布，而tag的名字一般就是我们的版本名称，这时候我们就可以动态的获取我们的tag名称作为我们应用的名称，可能你用的不是git版本控制系统，但是大同小异，这里以git为例。

想获取当前的 tag 名称，在 git 下非常简单，使用如下命令即可
`git describe --abbrev=0 --tags`

知道了命令，那么我们如何在 gradle 中动态获取呢，这就需要我们的 exec 了，gradle 为我们提供了执行shell命令非常简便的方法，这就是 Exec，它是一个 Task 任务，我们可以创建一个继承Exec的任务来执行我们的shell命令，但是比较麻烦，还好Gradle已经为我们想到了这个问题，为我们在Project对象里提供了exec方法。

![](http://upload-images.jianshu.io/upload_images/1662509-a76fa21394801bd9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其参数接受闭包和Action两种方式，一般我们都是采用闭包的方式，其闭包的配置是通过ExecSpec对象来配置的。

从ExecSpec源代码中我们可以看出，Project的exec方法的闭包可以有commandLine属性、commandLine方法、args属性以及args方法等配置供我们使用，我们这里只需要commandLine方法就可以达到目的了。

![](http://upload-images.jianshu.io/upload_images/1662509-b843a2623c787e7e.png)

以上示例定义了一个getAppVersionName方法来获取我们的tag名称，exec 执行后的输出可以用standardOutput获得，它是BaseExecSpec的一个属性，ExecSpec继承了BaseExecSpec,所以我们可以在exec{}闭包中使用。

通过该方法我们获取了 git tag 的名称后，就可以把它作为我们应用的版本名称了，使用非常简单，只用把我们的versionName配置成这个方法就好了，刚刚我们演示的时候是一个名为appVersionName的扩展属性。

![](http://upload-images.jianshu.io/upload_images/1662509-5da19afd9db1c319.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上我们通过git tag**动态获取了版本名称**，那么版本号我们如何动态获取呢？版本号作为我们内部开发的标识，主要用于控制应用进行生成，一般它是+1递增的，每一次发版，其值就+1，而每一次发版我们就会打一个tag，tag的数量也会增加1个，和我们版本号的递增逻辑是符合的，那么我们是不是可以把git tag的数量作为我们的版本号呢？答案是肯定的，这样打包发版之前，我们只需打个tag，tag数量+1，版本号也会跟着+1，达到了我们的目的。

![](http://upload-images.jianshu.io/upload_images/1662509-620efe6794e618d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上示例我们定义一个getAppVersionCode方法来获取git tag的数量，用于我们的版本号，然后我们在defaultConfig里使用这个方法即可，替换掉我们的appVersionCode变量。

![](http://upload-images.jianshu.io/upload_images/1662509-67051db775738618.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

大功告成，这样我们在发版打包之前，只需要打一个tag，然后Android Gradle打包的时候就会自动帮我们生成应用的版本名称和版本号，非常方便，再也不用为维护应用的版本信息担心了，这也是我们使用Gradle构建的灵活之处，如果使用Ant，会麻烦的多，有兴趣的同学可以思考一下。

##### 9.3.4 从属性文件中动态获取和递增

其实上一小结已经可以满足我们大部分的情况了，如果大家不想用，或者想自己更灵活的控制版本信息，可以采用Properties属性文件的方式，这里我不给出示例代码了，仅给出思路，大家可以自己练习实现一下，如果遇到问题，可以到通过前言里的联系作为给我发邮件或者加QQ群的方式交流。

大致思路如下：

1. 在项目目录下新建一个version.properties的属性文件。
2. 把版本名称分成三部分major.minor.patch，版本号分成一部分number，然后在version.properties中新增四个K_V键值对，其key就是我们上面分好的，value是对应的值。
3. 然后在build.gradle里新建两个方法，用于读取该属性文件，获取对应Key的值，然后把major.minor.patch这三个key拼接成版本名称，number用于版本号。
4. 以上就达到了获取版本信息的目的，获取使用之后，我们还要更新我们存放在version.properties文件中的信息，这样就可以达到版本自增的目的，以供下次使用。
5. 在更新版本名称三部分的时候，你可以自定义自己的逻辑，是逢10高位+1呢，还是其他算法，都可以自己灵活定义。
6. 使用版本信息，更新version.properties文件的时机，记得doLast这个方法哦，O(∩_∩)O~
7. 记得不会在自己运行调试的时候让你的版本信息自增哦，如何控制呢？就是要区分是真正的打包发版，还是平时的调试、测试，有很多办法来区分的。

这一小结到这里也写完了，动态获取生成版本信息的思路都大同小异，只是信息来源不一样，比如git tag，比如version配置等等，你自己的业务项目中还可以从其他更多的渠道来生成，这也是因为gradle的灵活，我们才可以随心所欲的做到这么多。

### 9.4 隐藏签名文件信息

很多团队一开始的成立的时候，十来个人，三五条枪，就开始创业了，每个组基本上就一个人，扛起所有。开始的时候，大家都不知道这款产品是否可以成功，所以也都没想那么多，只能小步快跑，快速迭代，占领市场，抢占用户，这才是最重要的。

随着产品越做越好，团队越来越大，组内成员越来越多，就开始注重团队协作，编码规范，性能安全，团队建设等等，因为只有做到这些，整个团队的工作效率和产出才能更高，才能有团队的威力，越到最后靠的是团队，而不是一个人。

以前我们都是把App的签名证书和相关秘钥放在项目中，托管在git上，这样做非常方便，可以直接访问打包，并且借助git这个代码管理平台维护管理。但是签名信息这个是我们应用非常重要的信息，属于公司重要的资源，所以我们要做到分级管理，保证安全，这也是公司保密措施的一部分，所以基于此，我们讲下签名信息如何隐藏，又能保证每个人可以打正式签名的包。

签名信息既然不能放在项目中，那么就需要有个地方存放他们，既然不能在每个开发者的电脑上，那就只能放到服务器上了，所以要实现这个，你还得有自己的专门用于打包发版的服务器，我们把签名文件和密钥信息放到服务器上，在打包的时候去读取即可，下面我们以使用环境变量的方式为例。

![](http://upload-images.jianshu.io/upload_images/1662509-2578baf576f013cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后我们在打包的机器上配置以上环境变量即可，window和linux的方式不一样，补关于配置环境变量这一块的知识，大家可以自行google一下。

如果你是使用Jenkins这类CI打包，以Jenkins，它的配置里就可以指定Jenkins使用的环境变量，这样我们就不用区分linux和window了，只需要在Jenkins里配置即可。

以上配置好之后，我们就可以进行打包使用了，签名信息也做了隐藏，看到这里，相信大家也意识到了一个问题，那就是每个开发者电脑上并没有如上的环境变量配置，因为签名信息对他们是隐藏的，那么他们如何进行打包测试呢？这就需要我们两个一个debug签名上场了，我们直接使用android自己提供的debug签名即可，因为我们需要的是签名，保证可以生成App测试（非debug调试）即可，比如给测试。

首先我们要**从我们自己的电脑目录上提取出来Android自带的debug签名**，一般在你的${HOME}/.android/目录下，找到后拷贝到我们的工程目录下，其次找到他们的签名信息，比如密码，key等，这是公开的，我们可以参考Android文档。

![](http://upload-images.jianshu.io/upload_images/1662509-5fa5b8ed76a8eb46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

关键的逻辑就是在signingConfigs中加了判断代码，如果签名信息四要素中的任何一个没有获取到，就使用默认的签名信息，这样当我们在打包服务器进行打包的时候就会使用正式发布的签名，因为我们已经在服务器上配置了签名信息的环境变量；当每个开发者自己生成Release包的时候，因为本机没有配置，就使用默认的签名。

假如有的开发者有时候也需要使用正式发布的签名打正式的包，用于升级测试等目的，也是可以做到的，比如Jenkins，给每个开发者开放一个账号，他们自己新建个Job就可以打正式的包了，打了之后可以在生成的构建里下载，关于Jenkins的具体使用我们后面的章节会详细讲。

好了，这一小节讲到这里也算是结束了，这一小节的目的是如何隐藏我们的签名信息，既能保证签名信息的安全性，又可以进行正式的打包，其中的关键点是一个专有的打包服务器，如果你们公司还没有的话，赶紧试试吧，优点很多，本小节就是其中之一，还有打包速度快，开发打包并行，晚上大半夜都可以定时打包等等，打包成功之后还能自动的发给我们的市场人员，也就是‘小’自动化部署，O(∩_∩)O~。

### 9.5 动态配置 AndroidManifest 文件

动态配置AndroidManifest文件，顾名思义，就是我们可以在构建的过程中，动态的修改Androidmanifest文件中的一些内容。这样的例子非常多，比如我们使用友盟等第三方分析统计的时候，会要求我们在AndroidManifest文件中指定渠道名称。

![](http://upload-images.jianshu.io/upload_images/1662509-769d67ec7481c323.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

示例中的Channel ID我们要替换成不同渠道的名称，比如google，baidu，miui等等。

对于这种情况我们不可能定义很多个AndroidManifest文件，因为这种工作繁琐，而且维护麻烦，所以我们就需要在构建的时候，根据我们正在生成的不同渠道包来为其指定不同的渠道名，对于这种情况Android Gradle为我们提供了非常便捷的方法让我们来替换AndroidManifest文件中的内容，它就是ManifestPlaceholder，Manitest占位符。

**manifestPlaceholders**是ProductFlavor的一个属性，他是一个Map<String, Object>类型，所以我们可以同时配置很多个占位符。下面我们就通过这个配置渠道号的例子来演示manifestPlaceholders的用法。

![](http://upload-images.jianshu.io/upload_images/1662509-7fa3a87469b8bebb.png)

例子中我们定义了两个渠道google和baidu，并且配置了他们的manifestPlaceholders。留意我们的使用方式，他们的Key都是一样的，是UMENG_CHANNEL，这个key就是我们在AndroidManifest文件中的占位符变量，在构建的时候，它会把AndroidManifest文件文件中所有占位符变量为UMENG_CHANNEL的内容替换为我们manifestPlaceholders中对应的value值。我们看AndroidManifest文件中具体的使用：

![](http://upload-images.jianshu.io/upload_images/1662509-f10ea1dc1b19ba9a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看到以上示例中的meta-data标签了吗？其中${UMENG_CHANNEL}就是一个占位符，它的变量名是UMENG_CHANNEL。构建的时候${UMENG_CHANNEL}将会被替换为google或者baidu。

通过以上方式我们就可以动态的配置我们的渠道，非常方便，但是这里也有一个问题，就是我们渠道非常多的时候呢？在中国，你们懂的，一个App很随意的就有几十个渠道需要发布，我们总不能一个个的配置吧，太多也太累，维护也麻烦。假如我们的友盟的渠道名和我们在Android Gradle中配置的ProductFlavor一样的话就简单了，我们可以通过迭代productFlavors批量的方式进行修改。

![](http://upload-images.jianshu.io/upload_images/1662509-5e68ce35f6c9dd1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们通过all函数遍历每一个ProductFlavor，然后把他们的name作为我们友盟中渠道的名字，非常方便，这里不止可以做这一个事情，在遍历ProductFlavor的时候，你可以做很多你想做的事情，这就是Gradle的灵活之处，把脚本当成程序写。
Android Gradle为我们提供的manifestPlaceholders占位符的方式，让我们可以替换AndroidManifest文件中任何${Var}格式的占位符，所以它的使用场景不限于渠道名这一个，比如还有ContentProvider的auth的授权，或者其他动态想配置meta信息等等，灵活的运用它能帮助我们做很多事情，让我们的构建更灵活，更方便。

### 9.6  自定义你的BuildConfig
对于BuildConfig这个类，相信大家都不会陌生，我们找到它，在它的顶部会看到“Automatically generated file. DO NOT MODIFY”，说它都是自动生成的不能修改，那么它是如何自动生成的呢？其实并不神秘，它是由我们的Android Gradle构建脚本在编译后生成的，默认情况下是一般是这样的。

DEBUG用于标记是debug模式还是release模式，剩下的还有包名，当前构建的类型是debug还是release，当前构建的渠道，当前的版本号以及版本名字。你会发现这些差不多就是我们当前构建渠道的基本应用信息，他们都是常量，相比我们获取这些信息的其他方式，无疑他们是非常方便的。

比如你要获取当前的包名，一般我们都会使用context.getPackgeName()函数，这个函数又会有很多实现，很麻烦，很复杂，性能也不高，但是我们如果直接引用BuildConfig.APPLICATION_ID就方便多了，性能也非常快，除此之外还有渠道、版本号、构建类型等信息。

DEBUG这个常量需要着重介绍一下，一般在开发过程中我们都会输出日志进行调试，一般只有在我们自己开发中才会打印出日志，当我们发布后就不能打印日志了，也就是我们需要一个标记是debug模式还是release模式的开关，这就是BuildConfig.DEBUG，在debug模式下它的值是true，在release模式下它的值会自动变为false，不用我们每次去改动这个值，Android Gradle会帮我们自动生成修改，非常方便，你还不用担心忘记。

既然这个BuildConfig这么好用，我们自己是不是可以自己定义，新增一些常量，让后动态的配置他们的值呢，答案是肯定的，对此Android Gradle为我们提供了buildConfigField(String type,String name,String value)让我们可以添加自己的常量到BuildConfig中，它的函数原型是

```java
//gradle-core-2.3.0.jar
public class BuildType extends DefaultBuildType implements CoreBuildType, Serializable {
    ...
    public void buildConfigField(String type, String name, String value) {
        ClassField alreadyPresent = (ClassField)this.getBuildConfigFields().get(name);
        if(alreadyPresent != null) {
            this.logger.info("BuildType({}): buildConfigField \'{}\' value is being replaced: {} -> {}", new Object[]{this.getName(), name, alreadyPresent.getValue(), value});
        }

        this.addBuildConfigField(new ClassFieldImpl(type, name, value));
    }
    ...
```

第一个参数type是要生成字段的类型，第二个参数name是要生成字段的常量名字，第三个参数value是要生成字段的常量值。最终他们生成的字段格式如下：
`<type> <name> = <value>`

现在我们具体例子来演示他们的用法。假设我们有baidu和google两个渠道，发布的时候也会有这两个渠道包，当我们安装baidu渠道包的时候打开的是baidu的首页，当我们安装google渠道包的时候打开的是google的首页。从这个思路分析，我们只需要添加一个字段WEB_URL，在baidu渠道下它的值是 http://www.baidu.com ,在google渠道下它的值是 http://www.google.com 即可。

![](http://upload-images.jianshu.io/upload_images/1662509-dd6673a5cf0bdef1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看上面的示例代码，我们定义两baidu和google两个渠道，并分别为他们生成了相应的BuildConfig常量字段，看我们的BuildConfig类，已经生成了这个常量了。

然后我们在代码中使用这个WEB_URL常量即可，在打包的时候，Android Gradle会帮我们自动生成不同的值。这里需要注意的是，value这个参数，是''这个单引号中间的部分，尤其对于String类型的值，里面的双引号一定不能省略，不然就会生成如下这样，报编译错误

![](http://upload-images.jianshu.io/upload_images/1662509-db71630a262dd5a2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

value的值是什么就写什么，要原封不动的放在''这个单引号里。
```
buildConfigField "boolean", "LOG_DEBUG", "true"
buildConfigField "String", "URL", ' "http://www.ecjtu.jx.cn/" '
```

以上我们讲的都是渠道(ProductFlavor)，其实不光渠道可以配置自定义字段，构建类型(BuildType)也可以配置，比如针对debug、release甚至其他构建类型来自定义配置，构建类型的一旦配置，那么所有渠道的这个构建类型都会有这个常量字段可以使用，它的使用方法和渠道的一样，只不过是配置在BuildType里，这里就不举例子了，类似于

![](http://upload-images.jianshu.io/upload_images/1662509-bdab09e53ee25c91.png)

自定义BuildConfig非常灵活，你可以根据不同的渠道，不同的构建类型来灵活配置你的App。

### 9.7 动态添加自定义的资源

在我们开发Android的过程中，我们会用到很多资源，有图片，动画、字符串等等，这些资源我们可以在我们的res文件夹里定义，然后在工程里引用即可使用。这里我们讲的自定义资源，是专门针对res/values类型资源的，他们不光可以在res/values文件夹里使用xml的方式定义生命，还可以在我们的Android Gradle定义，这大大增加了我们构建的灵活性。

实现这一功能的正是resValue方法，他在BuildType和ProductFlavor这两个对象中都存在，也就是说我们可以分别针对不同的渠道，或者不同的构建类型来自定义其特有的资源。以ProductFlavor中的resValue方法为例，我们先看下它的源码实现：

```java
    public void resValue(String type, String name, String value) {
        ClassField alreadyPresent = (ClassField)this.getResValues().get(name);
        if(alreadyPresent != null) {
            this.logger.info("BuildType({}): resValue \'{}\' value is being replaced: {} -> {}", new Object[]{this.getName(), name, alreadyPresent.getValue(), value});
        }

        this.addResValue(new ClassFieldImpl(type, name, value));
    }
```

从其文档注释中我们可以看到，它会添加生成一个资源，其效果是和在res/values文件里中定义一个资源是等价的。

resValue方法有三个参数，第一个是type，也就是你要定义资源的类型，比如有string、id、bool等等；第二个是name，也就是你要定义资源的名称，以便我们在工程中引用它；第三个是value，就是要你要定义资源的值。

![](http://upload-images.jianshu.io/upload_images/1662509-73cf268c751b9073.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当我们使用resValue方法时，Android Gradle帮我们生成的资源在哪里呢？其实都在我们的工程中，以baidu为例，debug模式下，在build/generated/res/resValues/baidu/debug/values/generated.xml这个文件中，我们看下我们生成的这个文件。

有没有发现，和我们在res/values这个文件夹里定义的xml文件的格式是一样的，只不过我们通过Gradle配置，Android Gradle帮我们自动做到了，这样我们控制Android Gradle构建的时候更灵活，如果没有这项功能，在res/values里配置就不太方便了。
以上示例我们演示的是string这个类型，你也可以使用id，bool，dimen，integer，color等这些类型来自定义自己的values资源，总之这个resValue方法和我们上一小节中讲的buildConfigField方法非常相似，参考即可，记得它也可以在BuildType中使用。

### 9.8 Java 编译选项

有时候我们需要对我们的 Java 源文件的编码，源文件使用的JDK版本等等进行调优修改，比如我们需要配置源文件的编码为UTF-8的编码，以兼容更多的字符；还比如我们想配置编译Java源代码的级别为1.6，这样我们就可以使用Override接口方法的继承等特性，为此 Android Gradle 我们提供了一个非常便捷的入口来让我们做这些配置。

![](http://upload-images.jianshu.io/upload_images/1662509-6dd0e046d0edea86.png)

android对象提供了一个compileOptions方法，它接受一个CompileOptions类型的闭包作为参数，来对Java编译选项进行配置.

CompileOptions是编译配置，它提供了三个属性，分别是encoding、sourceCompatibility、targetCompatibility，通过对他们进行设置来配置Java相关的编译选项。

sourceCompatibility是配置Java源代码的编译级别.

从文档注释中我们可以看到，它会尽可能的，把所有支持的值转换成一个JavaVersion对象，下面我们直接列出其可用的值
"1.6"1.6JavaVersion.Version_1_6"Version_1_6"

以上列出的这些格式都可以使用，你可以根据自己的喜好选择。

targetCompatibility是配置生成的Java字节码的版本，其可选值和sourceCompatibility一样，这里我们就不进行演示和讲解了。

### 9.9 adb操作选项配置

adb,相信大家都非常熟悉了，它是一个Android Debug Bridge，用于连接我们的Android手机进行一些操作，比如调试Apk，安装Apk，拷贝文件到手机等等。在Shell中我们可以通过输入adb来查看其功能和使用说明，在Android Gradle中，也为我们预留了对adb的一些选项的控制配置，它就是adbOptions{}闭包，它和compileOptions一样也是Android的一个方法。

```java
    public void adbOptions(Action<AdbOptions> action) {
        this.checkWritability();
        action.execute(this.adbOptions);
    }
```

由原型方法可以看到，这是一个AdbOptions类型的闭包，我们所有可以使用的Adb配置选项都在AdbOptions定义好了，所以有什么可以使用的，只需要看下这个AdbOptions类的实现即可。

在讲使用之前我们先讲下其大概的原理，我们知道adb这个命令，他可以帮助我们连接Android手机，对于Android Gradle这个插件，它也不例外，比如我们运行调试的时候，Android Gradle插件的底层还是调用的adb命令，Android Gradle只不过在其之上做了一些包装，有兴趣的可以看到Android Gradle源代码。既然做了包装，那么我们的AdbOptions配置就有作用了，在Android Gradle的脚本中，可以通过adbOptions{}闭包对adb的选项进行配置，然后实例化收集到android对象中的一个AdbOptions类型的变量adbOptions中，最后Android Gradle调用adb命令的时候，把这些配置作为adb命令的参数传递给adb即可，这就是AdbOptions的大概原理，基本上所有的Gradle和Shell命令的配合都是这么做的。

讲完了大概的原理，那么我们看下AdbOptions有哪些可供我们配置的。我们来看一下这个类的源码。

```java
package com.android.build.gradle.internal.dsl;

import com.google.common.collect.ImmutableList;
import java.util.Collection;
import java.util.List;

public class AdbOptions implements com.android.builder.model.AdbOptions {
    int timeOutInMs;
    List<String> installOptions;

    public AdbOptions() {
    }

    public int getTimeOutInMs() {
        return this.timeOutInMs;
    }

    public void setTimeOutInMs(int timeOutInMs) {
        this.timeOutInMs = timeOutInMs;
    }

    public void timeOutInMs(int timeOutInMs) {
        this.setTimeOutInMs(timeOutInMs);
    }

    public Collection<String> getInstallOptions() {
        return this.installOptions;
    }

    public void setInstallOptions(String option) {
        this.installOptions = ImmutableList.of(option);
    }

    public void setInstallOptions(String... options) {
        this.installOptions = ImmutableList.copyOf(options);
    }

    public void installOptions(String option) {
        this.installOptions = ImmutableList.of(option);
    }

    public void installOptions(String... options) {
        this.installOptions = ImmutableList.copyOf(options);
    }
}
```

我比较喜欢看源码，这样能了解的更清楚，以这个AdbOptions为例，如果你看官方的Android Gradle DSL文档，只能看到介绍的AdbOptions的两个属性：installOptions和timeOutInMs，然后你就会很当然的以属性的方式对他们进行设值，但是从源代码中我们可以看到，不仅可以通过属性的方式进行设值，还可以方法的方式，因为这里是有三个和其属性名一样的方法：

![](http://upload-images.jianshu.io/upload_images/1662509-281f52f82eb7600c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下面我们演示下它的使用以及这两个配置项的含义

![](http://upload-images.jianshu.io/upload_images/1662509-85941533b68392dc.png)

示例中我采用两种写法进行了演示，第一种对timeOutInMs的设置采用属性的方式，第二种对installOptions的设置采用的方法的方式，让大家对这两种设置方式都有了解，这样你就可以根据自己的喜好进行选了，我本人喜欢方法的方式，简洁，可读性强，更有脚本感。

timeOutInMs，从其名字就可以看出来，它是设置超时时间的，单位是毫秒，这个超时时间是执行adb这个命令的超时时间。有时候我们安装、运行或者调试的时候，可能会遇到CommandRejectException这样的异常，这个一般是当我们执行一个命令的时候，在规定的时间内没有返回应有的结果，这时候我们可以通过把超时时间设置长一些来解决，也就是多等一会，多等一会可能就有相应结果了。如果你经常遇到这类异常，可以把adb的超时时间设置长一些，就是通过timeOutInMs来设置，记住它的单位是毫秒。

installOptions，从其名字也能看出来，所以我们自己在编码中，养成好的习惯，命名通俗易懂，合理规范。它是用来设置我们adb install安装这个操作的设置项的，比如我们是要安装到sd上，还是要替换安装等等。我们从adb命令中看下它的功能说明。

![](http://upload-images.jianshu.io/upload_images/1662509-8a9712b8d1d823b2.png)

adb install以供有lrtsdg六个选项。

* -l：锁定该应用程序
* -r：替换已存在的应用程序，也就是我们说的强制安装
* -t：允许测试包
* -s：把应用程序安装到SD卡上
* -d：允许进行降级安装，也就是安装的比手机上带的版本低
* -g：为该应用授予所有运行时的权限

以上就是安装的六个选项的含义，我们可以根据自己的需求进行设置。

adb选项中超时设置用的比较多，安装设置只有在特殊情况下使用，默认的现在基本上够用。

### 9.10 dex 选项配置

我们都知道，我们的 Android 中的 Java 源代码，被编译成 class 字节码后，在我们打包成 APK 的时候又被 dx 命令优化成Android虚拟机可执行的 DEX 文件，DEX文件比较紧凑，Android 费劲心思做了这个 DEX 格式，就是为了能使我们的程序在Android平台上运行快一些。对于这些生成DEX文件的过程和处理，Android Gradle 插件都帮我们处理好了，Android Gradle插件会调用我们SDK中的dx命令进行处理，但是有的时候我们可能会遇到提示内存不足的错误，大致提示异常是**java.lang.OutOfMemoryError: GC overhead limit exceeded**，为什么会提示内存不足呢？其实这个dx命令知识一个脚本，它调用的还是Java编写的dx.jar库，是Java程序处理的，所以当内存不足的时候，我们会看到这么明显的Java异常信息，默认情况下给dx分配的内存是一个G，也就是1024M

以上就是 dx 命令的 Shell 脚本，熟悉的朋友应该不会陌生，很容易看的懂，我们注意到，默认内存是1024M，但是我们也可以通过-J参数配置。

![](http://upload-images.jianshu.io/upload_images/1662509-daa186c06ffc3fc7.png)

现在我们了解了原理了，也知道通过-J参数重新配置更大的内存就可以解决这个问题，但是我们在Android Gradle插件中怎么配置这个内存呢？和Adb的选项设置一样，Android Gradle插件为我们提供了dexOptions { }闭包，让我们可以对dx操作进行一些配置，也就是说为我们留了一个配置dx操作的入口，这是一个非常不错的方法，包括上几节我们讲的其他选项配置，这也可为我们自己的Gradle插件时，为插件使用者提供可配置项提供一个很好的思路。

dexOptions{}是一个DexOptions类型的闭包，它的配置都是由DexOptions提供的，现在我们看下DexOptions都有哪些可配置项。

![](http://upload-images.jianshu.io/upload_images/1662509-4990c75cbcfade40.png)

* incremental 属性，这是一个 boolean 类型的属性，他用来配置是否启用 dx 的增量模式，默认值为 false，表示不启用。增量模式虽然速度更快一些，但是目前还有很多限制，也可能会不工作，所以要**慎用**，要启用设置 incremental 为 true 即可。
* javaMaxHeapSize 属性，刚刚我们前面已经提了，他是配置我们执行dx命令是为其分配的最大堆内存，主要用来解决 dx 时内存不够用情况。它接受一个字符串格式的参数，比如 1024M，代表是1个G，当然你也可以直接配置为1g，也是支持的，和 1024M效果一样。
这里我配置4g，如果不够用你还可以再添加，前提是你的电脑有那么多内存够使用
* jumboMode属性，boolean类型，它可以用来配置是否开启jumbo模式，有时候我们的工程比较多，代码量太大，函数超过了65535个，那么就需要强制开启jumbo模式才可以构建成功，下一节我们再详细讲如何在 Android5.0 以下系统上突破 65535 方法的限制。
* preDexLibraries 属性，boolean 类型，用来配置是否预dex Libraries库工程，开启后会大大提高增量构建的速度，不过这可能会影响 clean 构建的速度。默认值为 true，是开启的。有时候我们需要关闭这个选项，比如我们需要使用dx的--multi-dex 选项生成多个dex 导致和库工程有冲突的时候，需要将该选项设置为false。
* threadCount 属性，Integer 类型，用来配置我们 Android Gradle运行dx命令时使用的线程数量，适当的数量可以提供dx的效率。

以上就是关于Dex选项设置的5个可以配置选项，我们可以根据我们具体项目中的需求来配置这些选项，达到项目构建的目的。

### 9.11 突破 65535 方法限制

随着业务越来越复杂，代码量会越来越多，尤其是大量集成第三方Jar库，你很快就要遇到如下错误：

![](http://upload-images.jianshu.io/upload_images/1662509-f6a90f4b7e4b30d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

有些Android的操作系统会遇到如下错误：

![](http://upload-images.jianshu.io/upload_images/1662509-aa2652735c338d1e.png)

他们虽然提示的错误信息不一样，但是都是同一个问题，这个错误是告诉我们整个App应用的方法超过了限制，为什么会这样呢，这要从Android中的虚拟机Dalvik说起。我们上一节也提到，我们的Java源文件都被打包成了一个DEX文件，这个文件就是优化过的Dalvik虚拟机可执行文件，Dalvik虚拟机在执行DEX文件的时候，它使用了short这个类型来索引DEX文件中的方法，这就意味着单个DEX文件可以被定义的方法最多只能是65535个，当我们定义的方法超过这个数时，就会出现如上的错误提示信息。

那么我们如何来解决这个问题呢？我们注意到单个DEX文件的方法超过65535个，那么我们解决的办法就是生成多个DEX文件，这样每个DEX文件的方法数量都没有超过65535，这样我们就可以解决这个问题了。

Facebook发展的很快，他们的Android App中的方法很快就达到了这个限制，他们的解决办法是采用打补丁的方式，有兴趣的可以参考下 [Facebook Dalvik补丁](https://www.facebook.com/notes/facebook-engineering/under-the-hood-dalvik-patch-for-facebook-for-android/10151345597798920)。Android开发者博客也有一篇通过[自定义类的加载过程](http://android-developers.blogspot.com/2011/07/custom-class-loading-in-dalvik.html)的文章来解决该问题，有兴趣的也可以参考一下，虽然他们有点复杂，但是在当时来说是不错的解决办法，并且可以了解一些对类加载，Dalvik虚拟机等技术。

随着出现该问题 App 越来越多，Android 官方终于给出了官方解决该问题的方法，这个就是 Multidex。对于 Android5.0之后的版本，使用了 ART 的运行时方式，可以天然支持 App 有多个dex文件，ART在安装App的时候执行预编译，把多个dex文件合并成一个oat文件执行；对于Android5.0之前的版本，Dalvik虚拟机限制每个App只能有一个class.dex，要使用他们，就得使用Android为我们提供的Multidex库，下面我们就重点讲针对**Android5.0之前的版本的处理**。

首先你得升级你的Android Build Tools和Android Support Repository 到**21.1**，这是支持这个Multidex功能的最低支持版本，目前我们升级到最新即可。

要在我们的项目中使用Multidex，首先我们要修改我们的gradle build配置文件，启用Multidex，并同时配置Multidex需要的Jar依赖。

![](http://upload-images.jianshu.io/upload_images/1662509-d5880af15676d501.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

配置好之后，只完成了一半，开启了multidex，会让我们的方法多余65535个的时候生成多个dex文件，其名字为classes.dex,classes(...n).dex这样的样式，但是对于Android5.0之前的系统虚拟机，它只认识一个dex，其名字还得是classes.dex，所以要想达到程序可以正常的目的，也要让虚拟机把其他几个生成的classes加载进来，要想做到这一步，**必须在App程序启动的入口控制**，这个入口就是Application。

Multidex为我们提供了现成的Application，其名字是MultiDexApplication，如果我们没有自定义的Application的话，直接使用MultiDexApplication即可，在Mainftest清单里配置。

![](http://upload-images.jianshu.io/upload_images/1662509-cfad95385527af15.png)

如果你的有自定义的Application，并且是直接继承自Application，那么只需要把继承改为我们的MultiDexApplication即可。

如果你的自定义的 Application 是继承其他第三方提供的Application，就不能改变继承了，这时候我们通过重写attachBaseContext 方法实现。

![](http://upload-images.jianshu.io/upload_images/1662509-99f03a3f05401fc9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

到了这里，我们对65535的限制都解决完了，这时我们打包的时候，Android Gradle会自动判断你的方法有没有超过65535个，如果没有，还是生成一个classes.dex文件，如果超过了，那么就会生成1个classes.dex文件，这个是入口主文件，然后还会生成若干个附属dex文件，比如classes2.dex, classes3.dex，打包系统会把他们一起打包到Apk里发布。

虽然我们有了解决65535方法的办法，但是还是**应该尽量的避免我们工程的方法超过65535个**，要达到这个目的，首先我们不能滥用第三方库，因为你自己的代码一般不会有这么多，如果要引用，最好也要自己进行精简。精简之后，还要使用ProGuard减小DEX的大小，因为DEX安装到机器上的过程比较复杂，尤其是有第二个DEX文件并且过大的时候，可能会造成ANR异常。还有因为Dalvik linearAlloc的限制，尤其在Android2.2和2.3上，只有5M，到Android4.0的时候还好点，升级到8M了，所以在低于4.0的系统上dexopt的时候可能会崩溃。

到了这里我们这一节要结束了，有兴趣的可以看下 MultiDex 的实现原理，尤其是加载classes2.dex，classes3.dex等等这几段，可以帮助我们理解动态的加载 DEX 文件原理。最后提出一些其他方法比较好，但是较为复杂的65535方法限制的解决办法--插件化。

插件化可以参考几个不错的开源工程：

* https://github.com/singwhatiwanna/dynamic-load-apk
* https://github.com/DroidPluginTeam/DroidPlugin
* https://github.com/alibaba/AndFix
* https://github.com/wequick/Small

### 9.12 自动清理未使用的资源

随着工程越来越大，功能越来越多，开发人员越来越多，代码越来越复杂，不可避免的会产生一些不在使用的资源，这类资源如果没有清理的话，会增加我们 Apk 的包大小，也会增加构建的时候。

要清理这些无用的资源，第一个办法是我们在开发的过程中，把不再使用的资源清理掉，这个靠开发人员的自觉以及对程序代码逻辑的了解程度，而且清理成本也比较大。第二个办法是使用 Android Lint，它会帮我们检测出哪些资源没有被使用，然后我们按照检测出来的列表清理即可，这种办法需要我们隔一段时间就要清理一次，不然就可能会有无用的资源遗留，做不到及时性。以上两个方式还有一个不能解决的问题，他就是第三方库里的资源的问题。如果你引用的第三方库里也含有无用的资源，那么这两种办法都不能做到清理他们，因为他们被打包在第三方库里，没有办法做删除。

针对以上情况，Android Gradle为我们提供了在构建打包时自动清理掉未使用资源的方法，这个就是**Resource Shrinking**。他是一种在构建时，打包成Apk之前，会检测所有资源，看看是否被引用，如果没有，那么这些资源就不会被打包到Apk包中，因为是在这个过程中（构建时），Android Gradle构建系统会拿到所有的资源，不管是你项目自己的，还是引用的第三方的，它都一视同仁的处理，所以这个时机点可以控制哪些资源可以被打包，所以能解决第三方不使用的资源的问题。比如我们常用的Google Play Service，这个是一个比较大的库，它支持很多Google的服务，比如Google Drive，Google Sign In等等，如果你在你的应用中只使用了Google Drive这个服务，并没有使用到Google Sign In服务，那么在构建打包的时候，会自动的处理Google Sign In功能相关的无用资源图片。

Resource Shrinking要结合着Code Shrinking一起使用，什么是Code Shrinking呢？就是我们经常使用的ProGuard，也就是我们要启用minifyEnabled，是为了缩减代码的；我们上面已经讲了，自动清理未使用的资源的原理很简单，就是判断有没有用到这些资源，如果你的代码还在使用，那么自然不会被清理，所以要和代码清理结合使用，先清理掉无用的代码，这样这些无用的代码引用的资源才能被清理掉。那么我们如何配置使用呢，看下面的示例，如下Gradle配置来启用Resource Shrinking：

![](http://upload-images.jianshu.io/upload_images/1662509-cae576299a54e251.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当我们开启了shrinkResources后，打包构建的时候，Android Gradle就会自动的处理未使用的资源，不把他们打包到生成的Apk中，我们可以在我们构建输出的日志中看到处理结果，以我们当前的示例代码为例，我们运行./gradlew :example912:assembleRelease 就可以看到如下日志：

![](http://upload-images.jianshu.io/upload_images/1662509-9b0ba7604130ae63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

自动清理未使用的资源这个功能虽好，但是有时候会误删，为什么呢，因为我们在代码编写的时候可能会使用反射去引用资源文件，尤其很多你引用的第三方库会这么做，这时候 Android Gradle就区分不出来了，可能会误认为这些资源没有被使用。针对这中情况，Android Gradle 为我们提供了 keep 方法来让我们配置哪些资源不被清理。

keep方法使用非常简单，我们要新建一个xml文件来配置，这个文件是 res/raw/keep.xml，然后通过tools:keep属性来配置，这个tools:keep接受一个以逗号(,)分割的配置资源列表，并且支持星号(*)通配符，有没有觉得它和我们用ProGuard的配置文件是一样的，我们在ProGuard配置文件里配置保存一些不被混淆的类也是这么做的。此外，对于res/raw/keep.xml这个文件我们不用担心，Android Gradle构建系统最终打包的时候会清理它，不会把它打包进Apk中的，除非你在代码中通过R.raw.keep引用了它。

以下是res/raw/keep.xml示例，引用自Android  Tech Docs

![](http://upload-images.jianshu.io/upload_images/1662509-1c7882cd67aa3bfe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

keep.xml还有一个属性是 tools:shrinkMode，用于配置自动清理资源的模式，默认是safe，是安全的，这种情况下，Android Gradle可以识别代码中类似于如下示例的引用

![](http://upload-images.jianshu.io/upload_images/1662509-0b57ca8d3b3415a2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这类代码也被构建系统认为是使用了资源文件，不会被清理。如果把清理模式改为strict，那么就没有办法识别了，这个资源会被认为没有被引用，也会被清理掉。

除了 shrinkResources 之外，Android Gradle 还为我们 提供了一个**resConfigs**，它属于 ProductFlavor 的一个方法，可以让我们配置哪些类型的资源才被打包到 Apk 中，比如只有中文的，只有hdpi格式的图片等等，这是非常重要的，比如我们引用的第三方库，特别是Support Library 和 Google Play Services这两个主要的大库，因为国际化的问题，他们都支持了几十种语言，但是对于我们的App来说，我们并不需要这么多，比如我们只用中文的语言就可以了，其他的都不需要；比如我们支持hdpi格式的图片就好了，其他的都不需要，这时候我们就可以通过resConfigs方法来配置：

![](http://upload-images.jianshu.io/upload_images/1662509-a2c32968a7c97ea6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样我们就只保留了 zh 资源，其他非 zh 资源都不会被打包到Apk文件中。

其实这个 resConfig 的配置有3中办法，一般常用的是resConfigs这个方法，因为可以同时指定多个配置，你也可以使用resConfig(后面没有s)来指定一个配置，它一次只能添加一个，如果要添加多个，要么调用多次，要么使用resConfigs方法。我们看下他们的方法原型，了解他们的方法原理：

resConfig的使用非常广泛，它的参数就是我们在Android开发时的资源限定符，不止于我们上面描述的语言和密度，还包括Api Level，分辨率等等，具体的可以参考Android　Doc文档。

以上自动清理资源只是在打包的时候，不打包到Apk中，实际上并没有删除我们工程中的资源，如果我们在使用的时候发现有大量的无用资源被清理，那么我们自己最好还是把这些资源文件从我们的工程中删除吧，这样也好维护一些。

到这里这一章就结束了，这一章主要是介绍Android Gradle的一些高级用户，基本上都是现实项目中遇到的，整理出来让大家参考，可以根据自己的实际情况选择使用，也可以在这些的基础上发散自己的思维，摸索出其他的更适用于你的项目的用法。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
