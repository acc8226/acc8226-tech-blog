---
title: Ant 打包安卓 apk(1) 手动档
date: 2022-06-23 10:53:12
updated: 2022-06-23 10:53:12
categories:
  - 构建工具
  - Ant
tags:
- Ant
---

![](https://upload-images.jianshu.io/upload_images/1662509-e6e38c5ec874cd32.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

1. 根据资源文件和 AndroidManifest.xml 生成 R.java 文件
2. 处理 aidl，生成对应的 java文件，如果没有 aidl，则跳过
3. 编译工程源码（主项目，库）src 目录下所有的源码，同时上边生成的 R.jav a和 aidl 生成的 java 文件也会被编译生成相应的 class 文件
4. 将第 3 步生成的 class 文件打包生成 .dex 文件
5. 将资源文件打包，生成初始的 apk
6. 将第 4 步生成的 .dex 文件加入到apk中生成未签名的包
7. apk 签名

## 1. aapt(Android Asset Packaging Tool) - Package the android resources得到R.java文件

命令 `build-tools/安卓某个版本/aapt.exe package`

```bat
set path=%path%;D:\Android\android-sdk\build-tools\25.0.2
aapt package -f -m -M AndroidManifest.xml -I D:/Android/android-sdk/platforms/android-22/android.jar -S res -J gen
```

参数的含义如下：
　　-f : 如果编译出来的文件已经存在，强制覆盖
　　-m : 使得生成的包的目录放在 -J 参数指定的目录
　　-M :  <AndroidManifest.xml目录>
　　-I : 某个版本平台的android.jar的路径
　　-S : res文件夹路径 resource-sources
　　-J : R.java的输出目录

## 2. 编译 aidl 文件

没有则可以忽略

## 3. Javac 编译(包含 src 和 gen 目录) java 文件

`javac -encoding UTF-8 -source 1.6 -target 1.6 -bootclasspath D:/Android/android-sdk/platforms/android-22/android.jar -sourcepath src -classpath .;libs/android-support-v4.jar;libs/SDMCommon-2.2.3.jar;libs/AnySignV2.0.0.Android.1.1.1.jar;libs/bjca_anysign_tool.jar;libs/DataVaultLib.jar;libs/httpmime-4.1.3.jar;libs/SDMConnectivity-2.2.3.jar;libs/SDMParser-2.2.3.jar;libs/SMPRestClient-2.2.3.jar;libs/sup-client-util.jar;libs/wsecx-android_package-v1.4.jar;libs/xstream-1.4.4.jar -d bin/classes gen/com/nci/insprotection/*.java src/com/nci/insprotection/*.java`

* 我安装的是`1.8.0_91`, 但我知道目标安卓 5.1 是基于 JDK1.6, 所以指定`-source`和`-target`都是1.6
* `-bootclasspath` 覆盖引导类文件的位置, 我设置的编译版本是 22
* `-sourcepath`指定用以查找类或接口定义的源代码路径, 这是非常重要的一个小技巧, 填写`src`后从而不用列举出`com.nci.insprotection` 下所有的包了
* 使用 `-classpath/-cp` 标签需要列举出所用用到的 jar 包`.;libs/android-support-v4.jar;xxx.jar;yyy.jar`, 不能使用通配符, 否则会找不到符号。还要注意 jar 包的命名最好不带空格，否则得双引号引起来
* `-d` 指定放置生成的类文件的位置
* 最后一个参数是 `<source files>`, 列举出所有用到的源文件, 由于我指定了sourcepath, 我只列举了`gen/com/nci/insprotection/*.java src/com/nci/insprotection/*.java`

注意:

> * `-d` 文件夹必须存在, 否则会`javac: 找不到目录: bin/classes`, 所以的手动mkdir
> * 提示找不到`符号: 类 BuildConfig`, 由于我是从Eclipse拷出的项目, 手动copy一个到`gen`下`R.java`的同级目录即可。

``` java
/** Automatically generated file. DO NOT MODIFY */
package com.nci.insprotection;

public final class BuildConfig {
    public final static boolean DEBUG = true;
}
```

## 4. 打包 class 文件和 jar 包为`classes.dex`

命令`build-tools/安卓某个版本/dx.bat`

`dx --dex --output=bin/classes.dex bin/classes libs/android-support-v4.jar libs/SDMCommon-2.2.3.jar libs/AnySignV2.0.0.Android.1.1.1.jar libs/bjca_anysign_tool.jar libs/DataVaultLib.jar libs/httpmime-4.1.3.jar libs/SDMConnectivity-2.2.3.jar libs/SDMParser-2.2.3.jar libs/SMPRestClient-2.2.3.jar libs/sup-client-util.jar libs/wsecx-android_package-v1.4.jar libs/xstream-1.4.4.jar`

> * 如果用到了 libs 下的 jar 包, 需要依次列出
> * 在这过程中如果报错 `ERROR: No suitable Java found.`, 是因为我的 `JAVA_HOME` 设置在了用户变量, 而非系统变量, 看来以后得用系统变量才靠谱

## 5. 打包 assets 和 res 资源为资源压缩包(例如 res.zip 或者 resources.ap_ 这样的名字都可以)

`aapt package -f -M AndroidManifest.xml -I D:/Android/android-sdk/platforms/android-22/android.jar -A assets -S res -F bin/res.zip`

* -f 如果编译生成的文件已经存在，强制覆盖。
* -M 使生成的包的目录存放在 -J 参数指定的目录
* -I 指定某个版本平台的 android.jar 文件的路径
* -A 指定 assert 文件夹的路径
* -S 指定 res 文件夹的路径
* -F 指定输出文件完整路径

## 6. 用 sdklib.jar 打包 apk(组合classes.dex和res.zip生成未签名的APK)

老版本可以用 apkbuild.bat 的命令`apkbuilder bin/unsigned.apk -v -u -z bin/res.zip -f bin/classes.dex`
但是如果如果被移除的话, 可以在安卓 sdk 安装目录 tools\lib 下是否存在 sdklib.jar, 如果存在还是可以打包的。

```sh
set classpath=%path%;D:\Android\android-sdk\tools\lib\sdklib.jar
java com.android.sdklib.build.ApkBuilderMain bin/unsigned.apk -u -z bin/res.zip -f bin/classes.dex -rf src -rj libs -nf libs
```

java com.android.sdklib.build.ApkBuilderMain bin/aaa.apk -u -z bin/resources.ap_ -f bin/classes.dex -rf src -rj libs -nf libs

参数含义：
第一个参数是存放打包后的文件完整路径

* -v 显示过程信息 Verbose
* -u 创建一个无签名的包 Creates an unsigned package.
* -z 指定 apk 资源路径 Followed by the path to a zip archive. Adds the content of the application package.
* -f 指定 dex 文件路径 Followed by the path to a file. Adds the file to the application package.
* -rf     引用的第三方jar以及其中的资源文件，按照一定的格式放置到apk文件夹中, 一般是`src`, Followed by the path to a source folder.             Adds the java resources found in that folder to the application package, while keeping their path relative to the source folder.
* -rj     一般是 `/libs`, Followed by the path to a jar file or a folder containing jar files. Adds the java resources found in the jar file(s) to the application package.
* -nf     一般是`/libs`, 将主项目libs下面的so库打包 Followed by the root folder containing native libraries to include in the application package.

## 7. jarsigner 生成签名包

`jarsigner -verbose -keystore C:\Users\hp\Desktop\保全_其他文档\密钥\android.keystore -storepass android -keypass android -signedjar bin/signed.apk bin/unsigned.apk androiddebugkey`

参数含义：

* -verbose  签名/验证时输出详细信息
* -keystore  密钥库路径
* -storepass  用于密钥库完整性的口令（密码）
* -keypass    专用密钥的口令（密码）
* -signedjar   已签名的 apk 文件的名称 （第一个apk是签名之后的文件， 第二个apk是需要签名的文件）

## 8. 对签名包进行 zipalign 优化

zipalign 可以使用 4 字节对齐的方式优化我们签名打包后的 apk 文件中的以二进制格式存放的文件（如资源图片），这样的话，当资源文件被映射到内存时，应用程序访问资源文件的速率就会被大大提升，同时节省应用占用的内存空间。

检测有没有4字节对齐

```bash
set path=%path%;D:\Android\android-sdk\build-tools\27.0.3
zipalign -c -v 4 bin/signed.apk
```

优化命令

```sh
zipalign -f -v 4 bin/signed.apk bin/signed_aligned.apk
```

然后通过了验证 Verification succesful。

## 总结

这篇文章只是说明了一个通用的流程, 很多方面的优化还没有考虑, 比如资源压缩, 代码混淆, 很多地方都是从网上找的, 所以还是不建议这么做, 用 AS 的 gradle 构建再发到应用市场才靠谱, 但是自己折腾还是有实验价值的。

## 参考

<https://blog.csdn.net/javazejian/article/details/50563283>
