想要调试 android 程序，但是目前情况是生成的 apk 不可调试，所以需要反编译 apk，并将 AndroidManifest.xml中的 application 标签中调试开关打开为 android:debuggable="true"。

```sh
# 1. 解开
java -jar apktool_2.6.1.jar  d zhangsan.apk -o zhangsan

# 2. 修改清单文件，将 debuggable 改为 true
... 省略

# 3. 重新生成 apk
java -jar apktool_2.6.1.jar   b zhangsan  -o zhangsan.apk

# 4. 安卓apk重新签名: 1. cd 到目录 2. 进行签名
cd build-tools\33.0.0

apksigner sign --ks C:\Users\ferder\AndroidStudioProjects\MyApplication\app\release\test.keystore   D:\zhangsan.apk
```

## 生成秘钥工具

秘钥生成工具——keytool
路径：jdk/bin/keytool.exe
生成秘钥：keytool -genkeypair -keystore test.keystore -alias test -validity 100 -keyalg RSA
其中-validity指定有效期天数，-keyalg指定算法
查看秘钥信息：keytool -list -v -keystore test.keystore
