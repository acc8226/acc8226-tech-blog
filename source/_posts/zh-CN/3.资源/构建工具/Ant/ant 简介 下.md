---
title: Ant 简介【下】
date: 2022-06-21 13:35:19
updated: 2022-06-21 13:35:19
categories:
  - 构建工具
  - Ant
tags: Ant
---

## Ant 官方各标签参考手册

<http://ant.apache.org/manual/>

## mail 标签发送邮件

需要预先下载 jar 包
javax.mail-api.jar | [mail](http://ant.apache.org/manual/Tasks/mail.html) task with MIME encoding
[https://javaee.github.io/javamail/](https://javaee.github.io/javamail/)

否则会报错

<!-- more -->

```sh
D:\Ant\AutoPackage\build.xml:144: java.lang.NoClassDefFoundError: com/sun/mail/util/FolderClosedIOException
        at java.lang.Class.forName0(Native Method)
        at java.lang.Class.forName(Class.java:264)
        at org.apache.tools.ant.taskdefs.email.EmailTask.execute(EmailTask.java:458)
        at org.apache.tools.ant.UnknownElement.execute(UnknownElement.java:292)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at org.apache.tools.ant.dispatch.DispatchUtils.execute(DispatchUtils.java:99)
        at org.apache.tools.ant.Task.perform(Task.java:350)
        at org.apache.tools.ant.Target.execute(Target.java:449)
        at org.apache.tools.ant.Target.performTasks(Target.java:470)
        at org.apache.tools.ant.Project.executeSortedTargets(Project.java:1388)
        at org.apache.tools.ant.Project.executeTarget(Project.java:1361)
        at org.apache.tools.ant.helper.DefaultExecutor.executeTargets(DefaultExecutor.java:41)
        at org.apache.tools.ant.Project.executeTargets(Project.java:1251)
        at org.apache.tools.ant.Main.runBuild(Main.java:834)
        at org.apache.tools.ant.Main.startAnt(Main.java:223)
        at org.apache.tools.ant.launch.Launcher.run(Launcher.java:284)
        at org.apache.tools.ant.launch.Launcher.main(Launcher.java:101)
Caused by: java.lang.ClassNotFoundException: com.sun.mail.util.FolderClosedIOException
        at java.net.URLClassLoader.findClass(URLClassLoader.java:381)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
        ... 20 more
```

简单实例

```xml
<target name="mail">
    <mail mailhost="smtp.163.com" mailport="25" subject="Build successful" charset="utf-8" user="YOUR_EMAIL@163.com" password="YOUR PASSWORD">
      <from address="YOUR_EMAIL@163.com"/>
      <to address="1334598467@qq.com"/>
      <message>some international text</message>
    </mail>
</target>
```

## AntCall

利用 AntCall Task 实现 target 间调用时传递参数的实例  当需要从一个 target 传递参数到被调用的 target 时，可以使用 `<param>` 类型进行传递。当然也可以在 target 中定义 property 来实现，与 Java 中的方法调用时传递参数相似

```xml
  <target name="targetA">
    <!-- 通过property传递  -->
    <property name="prop" value="prop property" />
    <antcall target="targetB">
      <!-- 通过antcall设定param实现  -->
      <param name="path1" value="path1 param" />
    </antcall>
  </target>

  <target name="targetB" depends="init">
    <echo message="In targetB" />
    <echo message="path1=${path1}" />
    <echo message="prop=${prop}" />
  </target>
```

## audio

> Plays a sound file at the end of the build, according to whether the build failed or succeeded. You can specify either a specific sound file to play, or, if a directory is specified, the <sound> task will randomly select a file to play. Note: At this point, the random selection is based on all the files in the directory, not just those ending in appropriate suffixes for sound files, so be sure you only have sound files in the directory you specify.

```xml
<sound>
    <success source="${user.home}/sounds/bell.wav"/>
    <fail source="${user.home}/sounds/ohno.wav" loops="2"/>
  </sound>
```

注意: 在taget内`<antcall target="playsound" />`不生效不知为何

```xml
  <!-- antcall调用没反应, depends却可以 -->
  <target name="playsound">
    <sound>
      <success source="audio/ring.wav"/>
    </sound>
  </target>
```

## mail

```xml
<target name="mail">
    <mail mailhost="smtp.163.com" mailport="25" subject="Build successful" charset="utf-8" user="sbf15270837834@163.com" password="xxxxx">
      <from address="sbf15270837834@163.com" name="往事随风"/>
      <to address="1334598467@qq.com" name="飞翔的企鹅"/>
      <message>some international text</message>
      <!-- <attachments>
        <fileset dir="${outDir}">
          <include name="*.apk"/>
        </fileset>
      </attachments> -->
    </mail>
</target>
```

## ftp

```xml
<target name="ftp1" description="将 demo.apk 上传到技术环境">
    <ftp server="10.1.61.123" remotedir="/opt/wasAppServer/profiles/AppSrv01/installedApps/test42Node01Cell/insure-pad_war.ear/demo.war/1" userid="root" password="abc@/1py">
      <fileset dir="C:/Users/hp/Desktop/demo_apk">
        <include name="android.keystore" />
      </fileset>
    </ftp>
</target>
```

## build 命令

```text
-help, -h              print this message and exit
-projecthelp, -p       print project help information and exit
-version               print the version information and exit
-buildfile <file>      use given buildfile
  -file    <file>              ''
  -f       <file>              ''
-D<property>=<value>   use value for given property
```

* 发现使用 -projecthelp，命令 只有在 project 有内部标签 或者 target 有该属性 description 才会现在

load 高级用法

```xml
    <loadresource property="newApkName" encoding="UTF-8">
      <string value="${itemAppName}" />
      <filterchain>
        <tokenfilter>
          <!-- 巧妙将后缀 .apk 加上了时间 -->
          <replaceregex pattern="\.apk" replace="_aligned.apk" flags="g" />
        </tokenfilter>
      </filterchain>
    </loadresource>
```

## 参考

* [HttpClient 教程 (一)](http://www.cnblogs.com/loveyakamoz/archive/2011/07/21/2112804.html) - loveyakamoz - 博客园
* [HttpClient使用详解](https://blog.csdn.net/wangpeng047/article/details/19624529) - 鹏霄万里展雄飞 - CSDN博客
* [【ANT】Ant常用的内置task - 蓝天&白云 - 博客园](https://www.cnblogs.com/baicj/archive/2015/12/21/5063608.html)

