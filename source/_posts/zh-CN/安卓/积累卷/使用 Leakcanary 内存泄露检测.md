---
title: 安卓-使用 Leakcanary 内存泄露检测
date: 2017-10-26 13:26:09
updated: 2022-11-16 17:47:00
categories:
  - 安卓
  - 积累卷
tags: Android
---

## 导入

> 导入 Leakcanary-watcher、Leakcanary-analyzer、Leakcanary-android， 在当前项目的引用 Leakcanary-android 这个 library。

## 在 AndroidManifest 中配置

打开当前的 AndroidManifest 添加下面的代码。

```xml
<!-- Leakcanary config start -->
<service
    android:name="com.squareup.leakcanary.internal.HeapAnalyzerService"
    android:enabled="false"
    android:process=":leakcanary" />
<service
    android:name="com.squareup.leakcanary.DisplayLeakService"
    android:enabled="false" />

<activity
    android:name="com.squareup.leakcanary.internal.DisplayLeakActivity"
    android:enabled="false"
    android:icon="@drawable/leak_canary_icon"
    android:label="@string/leak_canary_display_activity_label"
    android:taskAffinity="com.squareup.leakcanary"
    android:theme="@style/leak_canary_LeakCanary.Base" >
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />

        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
<activity
    android:name="com.squareup.leakcanary.internal.RequestStoragePermissionActivity"
    android:enabled="false"
    android:icon="@drawable/leak_canary_icon"
    android:label="@string/leak_canary_storage_permission_activity_label"
    android:taskAffinity="com.squareup.leakcanary"
    android:theme="@style/leak_canary_Theme.Transparent" />
<!-- Leakcanary config end -->
```

> 还有权限

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

## 在 Application 中初始化

> 新建一个 Application 类，继承自 Application 的，如果你项目已经有那就不需要新建了。
覆盖 onCreate() 方法，在 onCreate() 方法里调用 LeakCanary 的 install() 方法就可以了。

```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        if (LeakCanary.isInAnalyzerProcess(this)) {
            // This process is dedicated to LeakCanary for heap analysis.
            // You should not init your app in this process.
            return;
        }
        LeakCanary.install(this);
    }
}
```

## 感谢

* 感谢 [Square](https://github.com/square) 提供的 [Leakcanary](https://github.com/square/leakcanary)。
* 版权声明：本文为 cekiasoo 原创文章，转载请务必注明[出处](http://blog.csdn.net/cekiasoo/article/details/70880740)！
* [Leakcanary-eclipse 传送门](https://github.com/cekiasoo/Leakcanary-eclipse)
目前是根据 Leakcanary 1.5.1 的版本进行转化的
