---
title: Ant打包安卓apk(3)-ANT打包自动档(基本版)
categories:
  - 构建工具
  - Ant
tags:
- Ant
---

1\. ANT支持
2\. 配置环境变量(android 和 ANT 都需要)

```sh
export ANDROID_HOME=/Users/Stay/Desktop/develop/android-sdk-mac_x86/
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/tools
export ANT_HOME=/Users/Stay/Desktop/develop/ant/apache-ant-1.8.4
export PATH=${PATH}:${ANT_HOME}/bin
```

3\. 生成一个简单的 build.xml，本身 sdk/tool/ant 下有个完整的 build.xml，我们只要基于它创建一个简单的 build.xml即可.

首先切换到项目根目录,
`android update project --path . --name XXX` --path更新的是local.properties, --name更新的是build.xml
否则会(must already have an AndroidManifest.xml)

最好需要存在 project.properties 的情况下, 否则会 `Error: The project either has no target set or the target is invalid.`

project.properties格式如下

```properties
# Project target.
target=android-22
```

这样会更新两个文件
Updated `local.properties`  sdk.dir 标签指向路径, 此文件不应该包含在vcs中
Updated `build.xml`  ant文件支持, 我觉得该文件可选是否包含在vcs中

build.xml实例如下:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="TestAnt" default="help">

    <!-- The local.properties file is created and updated by the 'android' tool.
         It contains the path to the SDK. It should *NOT* be checked into
         Version Control Systems. -->
    <property file="local.properties" />

    <!-- The ant.properties file can be created by you. It is only edited by the
         'android' tool to add properties to it.
         This is the place to change some Ant specific build properties.
         Here are some properties you may want to change/update:

         source.dir
             The name of the source directory. Default is 'src'.
         out.dir
             The name of the output directory. Default is 'bin'.

         For other overridable properties, look at the beginning of the rules
         files in the SDK, at tools/ant/build.xml

         Properties related to the SDK location or the project target should
         be updated using the 'android' tool with the 'update' action.

         This file is an integral part of the build system for your
         application and should be checked into Version Control Systems.

         -->
    <property file="ant.properties" />

    <!-- if sdk.dir was not set from one of the property file, then
         get it from the ANDROID_HOME env var.
         This must be done before we load project.properties since
         the proguard config can use sdk.dir -->
    <property environment="env" />
    <condition property="sdk.dir" value="${env.ANDROID_HOME}">
        <isset property="env.ANDROID_HOME" />
    </condition>

    <!-- The project.properties file is created and updated by the 'android'
         tool, as well as ADT.

         This contains project specific properties such as project target, and library
         dependencies. Lower level build properties are stored in ant.properties
         (or in .classpath for Eclipse projects).

         This file is an integral part of the build system for your
         application and should be checked into Version Control Systems. -->
    <loadproperties srcFile="project.properties" />

    <!-- quick check on sdk.dir -->
    <fail
            message="sdk.dir is missing. Make sure to generate local.properties using 'android update project' or to inject it through the ANDROID_HOME environment variable."
            unless="sdk.dir"
    />

    <!--
        Import per project custom build rules if present at the root of the project.
        This is the place to put custom intermediary targets such as:
            -pre-build
            -pre-compile
            -post-compile (This is typically used for code obfuscation.
                           Compiled code location: ${out.classes.absolute.dir}
                           If this is not done in place, override ${out.dex.input.absolute.dir})
            -post-package
            -post-build
            -pre-clean
    -->
    <import file="custom_rules.xml" optional="true" />

    <!-- Import the actual build file.

         To customize existing targets, there are two options:
         - Customize only one target:
             - copy/paste the target into this file, *before* the
               <import> task.
             - customize it to your needs.
         - Customize the whole content of build.xml
             - copy/paste the content of the rules files (minus the top node)
               into this file, replacing the <import> task.
             - customize to your needs.

         ***********************
         ****** IMPORTANT ******
         ***********************
         In all cases you must update the value of version-tag below to read 'custom' instead of an integer,
         in order to avoid having your file be overridden by tools such as "android update project"
    -->
    <!-- version-tag: 1 -->
    <import file="${sdk.dir}/tools/ant/build.xml" />

</project>
```

4\. 你可以使用`ant -p`检测是否输出日志正常, 如果没问题说明你已经可以`ant debug`或者`ant release` 进行打包了
ant release需要密钥支持, 并在ant.properties里对key进行声明

```sh
# keystore路径, 绝对/相对路径
key.store=android.keystore
key.store.password=android
key.alias=androiddebugkey
key.alias.password=android
```

## 一些常见命令

### jarsigner验证apk是否签名和完整性(不推荐)

jarsigner -verify xxx.apk 验证apk

* 验证失败(因为我多渠道打包更改了清单文件)
`jarsigner: java.lang.SecurityException: SHA1 digest error for AndroidManifest.xml`
* 验证成功
`jar 已验证。`

### 使用apksigner.jar进行验证(推荐)

使用ant格式, 也可改写为java -jar格式

```xml
  <target name="verifyApk" description="checking whether signatures of APK files will verify on Android devices.">
    <!-- execute a jar in non-forked mode. set fork='true'. -->
    <java jar="${apksigner.jar}" fork="true">
      <arg value="verify" />
      <arg value="--verbose" />
      <arg value="${appName.apk}" />
    </java>
  </target>
```

### android.bat下的常用命令

`D:\Android\android-sdk\tools\android.bat -h`

```text
       Usage:
       android [global options] action [action options]
       Global options:
  -s --silent     : Silent mode, shows errors only.
  -v --verbose    : Verbose mode, shows errors, warnings and all messages.
     --clear-cache: Clear the SDK Manager repository manifest cache.
  -h --help       : Help on a specific command.

                                                                    Valid
                                                                    actions
                                                                    are
                                                                    composed
                                                                    of a verb
                                                                    and an
                                                                    optional
                                                                    direct
                                                                    object:
-    sdk              : Displays the SDK Manager window.
-    avd              : Displays the AVD Manager window.
-   list              : Lists existing targets or virtual devices.
-   list avd          : Lists existing Android Virtual Devices.
-   list target       : Lists existing targets.
-   list device       : Lists existing devices.
-   list sdk          : Lists remote SDK repository.
- create avd          : Creates a new Android Virtual Device.
-   move avd          : Moves or renames an Android Virtual Device.
- delete avd          : Deletes an Android Virtual Device.
- update avd          : Updates an Android Virtual Device to match the folders
                        of a new SDK.
- create project      : Creates a new Android project.
- update project      : Updates an Android project (must already have an
                        AndroidManifest.xml).
- create test-project : Creates a new Android project for a test package.
- update test-project : Updates the Android project for a test package (must
                        already have an AndroidManifest.xml).
- create lib-project  : Creates a new Android library project.
- update lib-project  : Updates an Android library project (must already have
                        an AndroidManifest.xml).
- create uitest-project: Creates a new UI test project.
- update adb          : Updates adb to support the USB devices declared in the
                        SDK add-ons.
- update sdk          : Updates the SDK by suggesting new platforms to install
                        if available.
```
