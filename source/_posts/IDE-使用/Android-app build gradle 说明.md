---
title: Android-app build gradle 说明
date: 2017.02.20 17:22:53
categories: IDE-使用
---

```gradle
apply plugin: 'com.android.application'

android {
    compileSdkVersion 23 // 建议指向最新版本
    buildToolsVersion "25.0.2"

    defaultConfig {
        applicationId "com.example.android.sunshine.app"
        minSdkVersion 10
        targetSdkVersion 23 //建议指向最新版本
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile 'com.android.support:appcompat-v7:23.4.0'
}
```
