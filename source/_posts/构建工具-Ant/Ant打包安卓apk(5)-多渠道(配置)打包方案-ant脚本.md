直接上代码

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="MyProject" default="init" basedir=".">
  <description>
    simple example build file
  </description>

  <!-- 使用第三方的ant包，使ant支持for循环-->
  <taskdef resource="net/sf/antcontrib/antcontrib.properties">
    <classpath>
      <pathelement location="${env.ANT_HOME}/lib/ant-contrib-1.0b3.jar"/>
    </classpath>
  </taskdef>

  <!-- set global properties for this build -->
  <property file="build.properties" />

  <property name="inDir" location="in"/>
  <property name="outDir" location="out"/>
  <property name="build-tools" location="android-sdk/build-tools/27.0.3"/>
  <property name="netease-tools" location="netease-tools"/>

  <property name="apksigner.jar" location="${build-tools}/lib/apksigner.jar"/>
  <property name="makechannels.jar" location="${netease-tools}/makechannels.jar"/>
  <property name="netease-apksigner.jar" location="${netease-tools}/apksigner.jar"/>

  <property name="appName.apk" value="${inDir}/${appName}"/>
  <!-- 多渠道打包配置 -->
  <property name="channels.txt" location="${inDir}/channels.txt"/>
  <!-- keystore配置 -->
  <property name="key.store.path" location="${inDir}/${key.store}"/>

  <property name="zipalign" value="${build-tools}/zipalign" />

  <!-- Create the time stamp -->
  <tstamp>
    <format property="DSTAMP" pattern="yyMMdd" timezone="GMT+8"/>
  </tstamp>

  <target name="init">
    <!-- Create the build directory structure used by compile -->
    <mkdir dir="${build}"/>
  </target>

  <target name="verifyApk" description="checking whether signatures of APK files will verify on Android devices.">
    <!-- Cannot execute a jar in non-forked mode. Please set fork='true'. -->
    <java jar="${apksigner.jar}" fork="true">
      <arg value="verify" />
      <arg value="--verbose" />
      <arg value="${appName.apk}" />
    </java>
  </target>

  <target name="zipalignCheck">
    <exec executable="${zipalign}">
      <arg value="-c" />
      <arg value="-v" />
      <arg value="4" />
      <arg value="${appName.apk}" />
    </exec>
  </target>

  <target name="makechannels" description="makechannel info each">
    <java jar="${makechannels.jar}" fork="true">
      <arg value="-apk" />
      <arg value="${appName.apk}" />
      <arg value="-config" />
      <arg value="${channels.txt}" />
      <arg value="-out" />
      <arg value="${outDir}" />
    </java>
  </target>

  <target name="apksigner" description="可重新签名单个文件 或 文件夹">
    <java jar="${netease-apksigner.jar}" fork="true">
      <arg value="-appname" />
      <arg value="test" />
      <arg value="-keystore" />
      <arg value="${key.store.path}" />
      <arg value="-pswd" />
      <arg value="${key.store.password}" />
      <arg value="-alias" />
      <arg value="${key.alias}" />
      <arg value="-aliaspswd" />
      <arg value="${key.alias.password}" />
      <arg value="-v1" />
      <arg value="true" />
      <arg value="-v2" />
      <arg value="false" />
      <arg value="${outDir}" />
    </java>
  </target>

  <target name="zipalignItem" description="对单个文件进行zipalign">
    <echo>取出原始${itemAppName}</echo>

    <!-- 通过${itemAppName}构建${newApkName} -->
    <loadresource property="newApkName" encoding="UTF-8">
      <string value="${itemAppName}" />
      <filterchain>
        <tokenfilter>
          <!-- 巧妙将后缀.apk加上了时间 -->
          <replaceregex pattern=".apk" replace="_zipalign.apk" flags="g" />
        </tokenfilter>
      </filterchain>
    </loadresource>
    <echo>开始构建${newApkName}</echo>
    <exec executable="${zipalign}">
      <arg value="-f" />
      <arg value="-v" />
      <arg value="4" />
      <arg value="${itemAppName}" />
      <arg value="${newApkName}" />
    </exec>
  </target>

  <target name="easyChannels">
    <!--  0. 清理历史数据 -->
    <antcall target="clean" />

    <!--  1. 根据channels文件进行多渠道打包 -->
    <antcall target="makechannels" />

    <!--  2. 集体重新签名 -->
    <antcall target="apksigner" />

    <!--  3. 遍历并zipalign -->
    <foreach param="itemAppName" target="zipalignItem">
      <path>
        <fileset dir="${outDir}">
          <include name="*.apk"/>
        </fileset>
      </path>
    </foreach>
  </target>

  <target name="clean" description="clean up">
    <!-- 避免删除了重复删除文件夹的尴尬, 有必要吗? -->
    <delete>
      <fileset dir="${outDir}" />
    </delete>
  </target>

</project>
```

优点:

* 并不是说ant淘汰了, 由于不参与构建apk, 只是拿到apk包到重新多渠道后签名和zipalign优化, 速度还是比较可观的.

笔记:

* 需要提交配置好环境变量
* 日期时间戳 dstamp、tsdamp、today的应用, 尼玛 HH:mm 才是二十四小时, hh:mm 是十二小时制
* FilterChain 是个好东西, 本来对于正则表达式理解的不深, 然后 ant 对 Properties 的 value 这种字符串无从下手的时候, 万能的搜索帮了大忙

小疑惑:

* 采用删除文件下所有文件, 而不是包括文件夹, 我想知道这个有没有必要

## 参考

* ANT 获取时间 - yakoo5的专栏 - CSDN博客
<https://blog.csdn.net/yakoo5/article/details/8760663>
* Ant 类型之 FilterChain - 荣耀之路 - CSDN博客
<https://blog.csdn.net/asty9000/article/details/79198172>
* ant 删除文件操作 - 孤云博客 - CSDN博客
<https://blog.csdn.net/u010142437/article/details/26681213>
