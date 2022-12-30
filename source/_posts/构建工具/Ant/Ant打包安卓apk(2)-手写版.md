---
title: Ant 打包安卓apk(2) 手写版
date: 2022-06-24 14:58:31
updated: 2022-06-24 14:58:31
categories:
  - 构建工具
  - Ant
tags:
- Ant
---

接着上文, 直接上 ant 脚本

```xml
<?xml version="1.0" encoding="utf-8"?>
<project default="package resources" basedir=".">
  <description>安卓构建脚本</description>
  <property name="project-dir" location="."/>

  <property environment="env" />
  <!-- JAVA目录(获取操作系统环境变量JAVA_HOME的值) -->
  <property name="java_home" value="${env.JAVA_HOME}"/>
  <!-- SDK目录(获取操作系统环境变量ANDROID_SDK_HOME的值) -->
  <property name="sdk-folder" value="${env.ANDROID_HOME}" />
  <!-- SDK指定平台目录 -->
  <property name="sdk-platform-folder" value="${sdk-folder}/platforms/android-22"/>
  <!-- 指定平台对应的android.jar -->
  <property name="android-jar" value="${sdk-platform-folder}/android.jar" />
  <!-- SDK中tools目录 -->
  <property name="sdk-tools" value="${sdk-folder}/tools" />
  <!-- SDK中build_tools目录 -->
  <property name="build-tools" value="${sdk-folder}/build-tools/25.0.2" />
  <!-- SDK指定平台中tools目录 -->
  <property name="sdk-platform-tools" value="${sdk-platform-folder}/tools" />

  <!-- 使用到的命令(当前系统为mac) -->
  <property name="aapt" value="${build-tools}/aapt" />
  <property name="aidl" value="${build-tools}/aidl" />
  <property name="dx" value="${build-tools}/dx.bat" />
  <property name="zipalign" value="${build-tools}/zipalign" />
  <property name="apkbuilder" value="${sdk-tools}/apkbuilder" />
  <property name="jarsigner" value="${java_home}/bin/jarsigner" />

  <!-- 基本编译路径设置 可定义多个classpath-->
  <path id="compile.classpath">
    <fileset dir="libs">
      <include name="*.jar" />
    </fileset>
  </path>

  <target name="init">
    <!-- Create the build directory structure used by compile -->
    <mkdir dir="gen" />
    <mkdir dir="bin/classes" />
  </target>

  <target name="generate R" depends="init" description="Package the android resources得到R.java文件">
    <exec executable="${aapt}">
      <arg value="package" />
      <arg value="-f" />
      <arg value="-m" />
      <arg value="-M" />
      <arg value="AndroidManifest.xml" />
      <arg value="-I" />
      <arg value="${android-jar}" />
      <arg value="-S" />
      <arg value="res" />
      <arg value="-J" />
      <arg value="gen" />
      <!-- 覆盖资源 -->
      <arg value="--auto-add-overlay" />
    </exec>
  </target>

  <target name="compile javac" depends="generate R" description="Javac编译(包含src和gen目录)java文件">
    <javac encoding="utf-8" source="1.6" target="1.6" bootclasspath="${android-jar}" destdir="bin/classes" includeantruntime="false">
      <classpath refid="compile.classpath" />
      <src path="src" />
      <src path="gen" />
    </javac>
  </target>

  <target name="dx" depends="compile javac" description="打包class文件和jar包dx为classes.dex">
    <exec executable="${dx}" failonerror="true">
      <arg value="--dex" />
      <arg value="--output=bin/classes.dex" />
      <arg path="bin/classes" />
      <arg path="libs/*.jar" />
    </exec>
  </target>

  <target name="package resources" depends="dx" description="打包assets和res资源为资源压缩包(例如res.zip">
    <exec executable="${aapt}">
      <arg value="package" />
      <arg value="-f" />
      <arg value="-M" />
      <arg value="AndroidManifest.xml" />
      <arg value="-I" />
      <arg value="${android-jar}" />
      <arg value="-A" />
      <arg value="assets" />
      <arg value="-S" />
      <arg value="res" />
      <arg value="-F" />
      <arg value="bin/resources.ap_" />
      <arg value="--auto-add-overlay" />
    </exec>
  </target>

  <target name="apkbuilder" depends="package resources">
    <java classname="com.android.sdklib.build.ApkBuilderMain">
      <classpath>
        <pathelement path="D:\Android\android-sdk\tools\lib\sdklib.jar " />
      </classpath>

      <arg value="bin/unsigned.apk" />
      <arg value="-u" />
      <arg value="-z" />
      <arg value="bin/resources.ap_" />
      <arg value="-f" />
      <arg value="bin/classes.dex" />
      <arg value="-rf" />
      <arg value="src" />
      <arg value="-rj" />
      <arg value="libs" />
      <arg value="-nf" />
      <arg value="libs" />
    </java>
  </target>

  <target name="jarsigner" depends="apkbuilder">
    <exec executable="${jarsigner}">
      <arg value="-keystore" />
      <arg value="C:\Users\hp\Desktop\保全_其他文档\密钥\android.keystore" />
      <arg value="-storepass" />
      <arg value="android" />
      <arg value="-keypass" />
      <arg value="android" />
      <arg value="-signedjar" />
      <arg value="bin/signed.apk" />
      <arg value="bin/unsigned.apk" />
      <arg value="androiddebugkey" />
    </exec>
  </target>

  <target name="zipalign" depends="jarsigner">
    <exec executable="${zipalign}">
      <arg value="-v" />
      <arg value="4" />
      <arg value="bin/signed.apk" />
      <arg value="bin/signed_aligned.apk" />
    </exec>
  </target>

  <target name="clean" description="clean up">
    <!-- Delete directory trees -->
    <delete dir="gen" />
    <delete dir="bin/classes" />
  </target>
</project>
```

由于我的项目中用到了 BuildConfig.java 文件, 在第一个生成 R 文件后我手动拷贝到了R.java的同级目录, 否则接下来的操作会报错

``` java
/** Automatically generated file. DO NOT MODIFY */
package com.nci.insprotection;

public final class BuildConfig {
    public final static boolean DEBUG = true;
}
```

## 注意

先手动编译通过在调整 ant 脚本, 否则很容易出错

## 参考

1. <https://blog.csdn.net/kevin_nazgul/article/details/48767101>
2. <https://blog.csdn.net/javazejian/article/details/50579416>
