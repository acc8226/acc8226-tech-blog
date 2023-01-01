Android Gradle 为我们提供了大量的 DSL，我们使用这些 DSL 定义配置我们的工程以满足我们项目中不同的需求。这些DSL有很多，在上一章演示 Android Gradle 工程示例的时候，我们已经大概介绍了 compileSdkVersion、buildToolsVersion以及 defaultConfig 等，这一章我们再详细介绍一些常用的 DSL 配置，这些配有有签名信息、构建类型、代码混淆、zipAlign 对齐压缩等。

### 8.1 defaultConfig 默认配置

defaultConfig 是 android 对象中的一个配置块，负责定义所有的默认配置，它是一个 ProductFlavor，如果一个 ProductFlavor 没有被特殊定义配置的话，默认就会使用 defaultConfig{} 块指定的配置，比如包名、版本号、版本名称等。

一个基本上的 defaultConfig 配置如下：

![](http://upload-images.jianshu.io/upload_images/1662509-3faa53fb4953b1c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上示例配置了Android 开发的基本信息，可以满足一个基本的Android App开发，下面我们对它的一些配置进行一个详细的说明。

##### 8.1.1 applicationId

applicationId 是 ProductFlavor 的一个属性，用于指定生成的 App 的包名，默认情况下是 null，这时候在构建的时候，会从我们的 AndroidManifest.xml 文件中读取，也就是我们在 AndroidManifest.xml 文件中配置的 manifest 标签的package属性值。

##### 8.1.2 minSdkVersion

minSdkVersion 是 ProductFlavor 的一个方法，对应的方法原型是

```java
public void minSdkVersion(int minSdkVersion) {
    this.setMinSdkVersion(minSdkVersion);
}
```

它可以指定我们的App最低支持的Android 操作系统版本，其对应的值是Android SDK的API LEVEL，根据这里的方法原型，它接受的值是一个整数，除此之外，它还有以下两种方法原型定义：

![](http://upload-images.jianshu.io/upload_images/1662509-c33e197b95acc51f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

根据我们前面讲的 Gradle 知识，发现 minSdkVersion 也是一个属性，它也可以接受一个字符串作为它的值，在这里明确一下，这个字符串不是我们 SDK API LEVEL 的字符串形式，而是 Code Name，也就是我们的每个Android SDK或者说是Android OS 的代号。就是我们新闻上经常见到的什么‘冰激凌三明治’什么的。这里给出一个列表，让大家一目了然。

![](http://upload-images.jianshu.io/upload_images/1662509-f1f03c83100f5d33.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 8.1.3 targetSdkVersion

这个用于配置我们基于哪个Android SDK开发，它的可选值和minSdkVersion一样，没有配置的时候也会从AndroidManifest.xml文件中读取，参考minSdkVersion的介绍，这里就不多做介绍了。

##### 8.1.4 versionCode

它也是 ProductFlavor 的一个属性，用于配置 Android App 的内部版本号，是一个整数值，通常用于版本的升级。没有配置的时候从AndroidManifest.xml 文件中读取，建议配置。其方法原型是

```java
public class DefaultProductFlavor extends BaseConfigImpl implements ProductFlavor {
    ...
    public ProductFlavor setVersionCode(Integer versionCode) {
        this.mVersionCode = versionCode;
        return this;
    }

    public Integer getVersionCode() {
        return this.mVersionCode;
    }
    ...
}
```

###### 8.1.5 versionName

versionName 和 versionCode 类似，也是ProductFlavor一个属性，用于配置 Android App 的版本名称，比如 V1.0.0 等等，主要显示用，让用户或者市场知道我们的 Android App 版本，它和 versionCode 一个是外部用，一个是内部使用，一起配合完成 Android App 的版本控制，其方法原型是

```java
public ProductFlavor setVersionName(String versionName) {
    this.mVersionName = versionName;
    return this;
}

public String getVersionName() {
    return this.mVersionName;
}
```

##### 8.1.6 testApplicationId

用于配置测试App的包名，默认情况下是**applicationId + “.test”**，一般情况下默认即可，它也是ProductFlavor的一个属性，方法原型是

```java
    public ProductFlavor setTestApplicationId(String applicationId) {
        this.mTestApplicationId = applicationId;
        return this;
    }

    public String getTestApplicationId() {
        return this.mTestApplicationId;
    }
```

##### 8.1.7 testInstrumentationRunner

用于配置单元测试时使用的 Runner，默认使用的是 android.test.InstrumentationTestRunner，如果你想使用自己自定义的 Runner，修改这个值即可，它也是一个属性，其方法原型是

```java
public ProductFlavor setTestInstrumentationRunner(String testInstrumentationRunner) {
    this.mTestInstrumentationRunner = testInstrumentationRunner;
    return this;
}

public String getTestInstrumentationRunner() {
    return this.mTestInstrumentationRunner;
}
```

##### 8.1.8 signingConfig

配置默认的签名信息，用对生成的 App 签名，它是一个 SigningConfig，也是 ProductFlavor 的一个属性，可以直接对其进行配置，其方法原型是

``` java
    public SigningConfig getSigningConfig() {
        return this.mSigningConfig;
    }

    public ProductFlavor setSigningConfig(SigningConfig signingConfig) {
        this.mSigningConfig = signingConfig;
        return this;
    }
```

##### 8.1.9 proguardFile

用于配置 App ProGuard 混淆所使用的 ProGuard 配置文件，它是ProductFlavor的一个方法，接受一个文件作为参数。其方法原型为

```java
    public void proguardFile(Object proguardFile) {
        this.getProguardFiles().add(this.project.file(proguardFile));
    }
```

可以看到它可以被调用多次，调用一次添加一个，其参数被project.file方法转换为一个文件对象。其具体使用我们在稍后进行介绍。

##### 8.1.10 proguardFiles

这个也是配置ProGuard配置文件，只不过它可以同时接受多个配置文件，因为它的参数是一个可变类型的参数。

```java
    public void proguardFiles(Object... files) {
        Object[] var2 = files;
        int var3 = files.length;

        for(int var4 = 0; var4 < var3; ++var4) {
            Object file = var2[var4];
            this.proguardFile(file);
        }
    }
```

从方法实现我们可以看到，同时可以添加多个ProGuard配置，在实际情况下中可以选择不同的配置方式。

### 8.2 配置签名信息

一个 App 只有被签名之后才能被发布、安装、使用，签名是保护 App 的方式，标记该App的唯一性，如果 App 被恶意篡改，签名就不一样了，就无法升级安装，一定程度上也保护了我们的App。

要对App进行签名，你先得有一个签名证书文件，这个文件被开发者持有，我们这里假设你已经有生成的证书，不对证书的生成进行介绍了。
一般我们的App有debug和release两种模式（下面会将构建类型），在我们开发调试的时候使用的是 debug 模式，发布的时候使用release模式；我们可以针对这两种模式采用不同的签名方式，一般 debug 模式的时候，Android SDK 已经为我们提供了一个默认的debug签名证书，我们可以直接使用，但是发布的时候，release 模式构建时，我们要配置使用自己生成的签名证书。

对于签名信息的配置，Android Gradle为我们提供了非常简便的方式，让我们可以非常容易的配置一个签名信息以供调用。

![](http://upload-images.jianshu.io/upload_images/1662509-29a7deee827816bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Android Gradle为我们提供了signingConfigs{}配置块便于我们生成多个签名配置信息。signingConfigs是android的一个方法，它接受一个域对象作为其参数，前面我们讲过的，其类型是NamedDomainObjectContainer<SigningConfig>，这样我们在signingConfigs{}块中定义的都是一个SigningConfig。一个SigningConfig就是一个签名配置，其可配置的元素如下：

* storeFile 签名证书文件
* storePassword 签名证书文件的密码
* storeType 签名证书的类型
* keyAlias 签名证书中密钥别名
* keyPassword 签名证书中该密钥的密码

例子中我们定义配置了一个名为release的签名配置，除此之外，我们还可以配置多个不同的签名前置，比如我们添加一个debug的配置。

![](http://upload-images.jianshu.io/upload_images/1662509-46105b6a8c0d6ff3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

默认情况下，debug模式的签名已经被配置好了，使用的就是 Android SDK 自动生成的 debug 证书，它一般位于$HOME/.android/debug.keystore，其Key和密码都是已知的，一般情况下我们不需要单独配置 debug 模式的签名信息。

现在我们配置好了两个签名信息，但是他们还没有被使用，现在只是生成了两个SigningConfig的实例，一个变量名为release，一个为debug，如果要使用他们我们只需引用他们即可，比如在8.1.8节中我们讲配置默认的签名信息，现在我们就可以引用debug的配置信息使用。

![](http://upload-images.jianshu.io/upload_images/1662509-ee4d4daad65fe0ef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以看到我们在defaultConfig中对签名配置的应用这里的signingConfigs是android对象实例的一个属性，对应是getSigningConfigs()，debug就是我们上面创建的签名配置名称。

除了上面的默认签名配置之外，我们也可以对构建的类型分别配置签名信息，比如我上面说的debug模式配置debug的签名信息，release默认配置release的签名信息。

![](http://upload-images.jianshu.io/upload_images/1662509-faf84d5432336437.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果你还有其他类型，想为其配置单独的签名，也可以这么做，比如付费版的VIP，单独进行签名配置、特别的渠道包单独配置等等。

### 8.3 构建的应用类型

关于构建类型，前面的章节我们已经用到了一些，在Android Gradle工程中，Android Gradle已经帮我们内置了debug和release两个构建类型，他们两种模式的只要差别在于能否在设备上调试以及签名不一样，其他代码和文件资源都是一样的，一般情况下也够用了。

如果想增加新的构建类型，在buildTypes{}代码块中继续添加元素就好了。buildTypes和signingConfigs一样，也是android的一个方法，接受的参数也是一个域对象NamedDomainObjectContainer<BuildType>，添加的每一个都是BuildType类型，所以你可以使用BuildType提供的方法和属性对现有的BuildType配置，这里列举一些常用的配置。

##### 8.3.1 applicationIdSuffix

applicationIdSuffix是BuildType的一个属性，用于配置**基于默认applicationId的后缀**，比如默认defaultConfig中配置的applicationId为org.flysnow.app.example82，我们在debug的BuildType中指定applicationIdSuffix为.debug,那么构建生成的debug apk的包名就是org.flysnow.app.example82.debug。其方法原型为

```
    public BaseConfigImpl setApplicationIdSuffix(String applicationIdSuffix) {
        this.mApplicationIdSuffix = applicationIdSuffix;
        return this;
    }
```

##### 8.3.2 debuggable

debuggable也是BuildType的一个属性，用于配置是否生成一个可供调试的Apk。其值可以为true或者false。其方法原型为

```java
    public BuildType setDebuggable(boolean debuggable) {
        this.mDebuggable = debuggable;
        return this;
    }
```

##### 8.3.3 jniDebuggable

jniDebuggable 和 debuggable 类似，也是BuildType的一个属性，用于配置是否生成一个可供调试Jni（C/C++）代码的Apk。接受 boolean 类型的值

##### 8.3.4 minifyEnabled

也是BuildType的一个属性，用于配置该BuildType是否**启用Proguard混淆**，接受一个boolean类型的值

##### 8.3.5 multiDexEnabled

也是 BuildType 的一个属性，用于配置该BuildType是否启用自动拆分多个 Dex 的功能，一般用于代码太多，超过了65535个方法的时候，进行的拆分为多个 Dex 的处理，后面会详细讲使用。接受一个 boolean 类型的值

##### 8.3.6 proguardFile

是BuildType的一个方法，用于配置Proguard混淆使用的配置文件，和前面讲的defaultConfig中的proguardFile一样

##### 8.3.7 proguardFiles

是 BuildType 的一个方法，用于配置 Proguard 混淆使用的配置文件，该方法可以同时配置多个Proguard配置文件

##### 8.3.8 shrinkResources

是BuildType的一个属性，用于配置是否自动清理未使用的资源，默认为false.
这是一个非常有用的功能，我们在后面的章节会详细介绍。

##### 8.3.9 signingConfig

配置该BuildType使用的签名配置，前面已经讲过，可以参考8.2章节温习一遍。

**每一个BuildType都会生成一个SourceSet**，默认位置为src/<buildtypename>/,根据我们以前讲的知识，一个SourceSet包含源代码、资源文件等信息，在Android中就包含了我们的java源代码，res资源文件以及AndroidManiftest文件等，所以针对不同的BuildType，我们可以单独的为其指定Java源代码，res资源等，只要把他们放到src/<buildtypename>/下相应的位置即可，在构建的时候，Android Gradle会优先使用他们代替我们main下的相关文件。

另外需要注意，因为我们的每个 BuildType 都会生成一个SourceSet，所以新增的 BuildType 名字一个要注意，不能是main和androidTest，因为他们两个已经被系统占用，同事每个BuildType之间名称不能相同。

除了会生成对应的SourceSet外，**每一个BuildType还会生成相应的assemble<BuildTypeName>任务**，比如我们常用的assembleRelease和assembleDebug就是Android Gradle自动生成的两个Task任务，他们是release和debug这两个BuildType自动创建生成的。执行相应的assemble<BuildTypeName>任务，就能生成对应BuildType的所有Apk。

### 8.4 使用混淆

代码混淆是一个非常有用的功能，它不仅可能优化我们的代码，让我们的 Apk 包变得更小，还可以混淆我们原来的代码，让反编译的人不容易看明白我们业务逻辑，很难分析。一般情况下我们发布到市场的版本一定是要混淆的，也就是我们的release模式编译的版本，但是我们自己调试的版本不用混淆，因为混淆后就无法断点跟踪调试了，也就是我们的debug模式。

要启用混淆，我们把BuildType的属性minifyEnabled 的值设置为true即可。

现在我们启用了混淆，但是 Android Gradle 还不知道按何种规则进行混淆，不知道要保留哪些类不混淆，要做到这些就需要我们的Proguard配置文件了，现在我们为我们的混淆指定配置文件。

根据我们8.3小结讲的知识，指定Proguard 配置文件我们可以使用proguardFile方法，也可以使用 proguardFiles 方法，这个根据情况而定，看你是想指定一个还是想同时指定多个。

这里我们注意到，使用了一个 getDefaultProguardFile 方法，该方法是android实例的一个方法，全限定写法可以这样android.getDefaultProguardFile,它的作用是获取我们Android SDK安装目录中，Android为我们提供的默认Proguard混淆配置文件，路径是Android SDK安装目录下的tools/proguard文件夹中，我们看下该方法的原型

![](http://upload-images.jianshu.io/upload_images/1662509-9251570c0c78071a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从实现中看，我们只需传递一个文件名给这个方法，他就会返回tools/proguard 目录下的该文件的绝对路径。

Android SDK默认为我们提供了两个 Proguard 配置文件，他们分别是 proguard-android.txt和proguard-android-optimize.txt，一个是没有优化的，一个是优化的，你可以根据情况自己选择，当然你也可以都不用，全部自己定义，自己定义的时候可以参考 Proguard 官方网站文档，查看相关配置说明，网址为 <http://proguard.sourceforge.net/> 。

除了在BuildType中启用混淆和配置混淆外，我们也可以在defaultConfig中启用和配置，还记得我们前面在8.1章节讲的吧，**因为这个是默认配置，一般用的比较少**。

我们还可以针对个别渠道，启用和配置 Proguard 混淆，多渠道包是通过 productFlavors 配置的，productFlavors 是一个NamedDomainObjectContainer<ProductFlavor>域对象，其配置的渠道本质上就是一个ProductFlavor，**和defaultConfig是一样的**，所以每个渠道也可以单独的启用和配置Proguard混淆。

### 8.5 启用 zipalign 优化

zipalign 是 Android 为我们提供的一个整理优化 Apk 文件的工具，它能提供系统和应用的运行效率，更快的读写 Apk 中的资源，降低内存的使用，所以对于我们要发布的 App，在发布之前**一定要使用zipalign进行优化**。

Android Gradle 为我们提供了开启 zipalign 优化更简便的方式，我们只需要配置开启即可，剩下的操作，比如调用SDK目录下的zipalign工具进行处理等，Android Gradle会帮我们搞定。要为我们的 release 模式开启 zipalign 优化的话，只需进行如下配置即可。

zipAlignEnabled是BuildType 的一个属性，接受一个 boolean 类型的值.

### 8.6 小结

这一章对我们 Android Gradle 常用的 DSL 做了详细的讲解说明，并且尽可能对常用的属性方法配置也进行了详细的说明，同时配有每个属性和方法的源代码实现，让大家对这些配置有个更深的认识。大家可以灵活的使用这些 DSL 对自己的项目进行自定义构建，以满足自己的项目需求。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
