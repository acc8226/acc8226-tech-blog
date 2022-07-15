---
date: 2022.07.13 18:00:00
---

想要调试 android 程序，但是目前情况是生成的 apk 不可调试，所以需要反编译 apk，并将 AndroidManifest.xml中的 application 标签中调试开关打开为 android:debuggable="true"。

## 操作步骤

1\. 重新打包 apk 安装包

```sh
# 1. 解开
java -jar apktool_2.6.1.jar d zhangsan.apk -o zhangsan

# 2. 修改清单文件，将 debuggable 改为 true
... 省略

# 3. 重新生成 apk
java -jar apktool_2.6.1.jar b zhangsan -o zhangsan.apk

# 4. 将安卓 apk重新签名: 1. cd 到目录 2. 进行签名
cd build-tools\33.0.0

apksigner sign --ks C:\Users\ferder\AndroidStudioProjects\MyApplication\app\release\test.keystore D:\zhangsan.apk
```

2\. 将 apk 安装包按照到虚拟机或者实体收集并进行调试工作。例如可以通过 Android Studio 的 Device File Explorer 进行文件的查看等操作。

## 生成秘钥工具

秘钥生成工具——keytool
路径：jdk/bin/keytool.exe
生成秘钥：keytool -genkeypair -keystore test.keystore -alias test -validity 100 -keyalg RSA
其中 -validity 指定有效期天数，-keyalg 指定算法
查看秘钥信息：keytool -list -v -keystore test.keystore

## 相关软件

Amazon Corretto-OpenJDK 的免费多平台发行版-AWS云服务
<https://aws.amazon.com/cn/corretto/>

Apktool - A tool for reverse engineering 3rd party, closed, binary Android apps.
<https://ibotpeaches.github.io/Apktool/>

Download Android Studio & App Tools - Android Developers
<https://developer.android.google.cn/studio/>
