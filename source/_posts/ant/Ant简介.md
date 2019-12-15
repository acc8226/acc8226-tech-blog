---
title: Ant简介
date: 2018-09-15 11:30:00
---

> Apache Ant 是由 Java 语言开发的工具，由 Apache 软件基金会所提供。Apache Ant 的配置文件写成 XML 容易维护和书写，而且结构很清晰。本教程将以简单的方式会向你展示如何利用 Apache ANT 来自动地构建和部署过程。

1. 找到安装路径`C:\L_Executable\apache-ant-1.10.5`
2. 配置环境变量
```
ANT_HOME C:\L_Executable\apache-ant-1.10.5
Path %ANT_HOME%\bin
```
3. 运行`ant -version`查看是否安装成功`Apache Ant(TM) version 1.10.5 compiled on July 10 2018`

``` xml
	<!-- copy -->
	<!-- 拷贝文件 -->
	<copy file=".\build.xml" tofile="newBuild.xml" />	
	<!-- 拷贝文件夹 -->
	<copy todir="build/dest_dir">
		<fileset dir="origin_dir" />
	</copy>
	
	<!-- delete -->
	<!-- 删除单个文件 -->
	<delete file="test.txt" />
	<!-- 删除整个目录 -->
	<delete dir="someDir" />

	<!-- zip -->
	<!-- 将当前目录包含文件压缩 -->
	<zip destfile="project.zip" basedir="."/>

    
```

## 插播Java教程
### javac的官方说法：
`-classpath:`
设置用户类路径，它将覆盖CLASSPATH 环境变量中的用户类路径。若既未指定CLASSPATH 又未指定-classpath，则用户类路径由当前目录构成。
`-sourcepath:`
指定用以查找类或接口定义的源代码路径。与用户类路径一样，源路径项用分号 (;)进行分隔，它们可以是目录、JAR 归档文件或 ZIP 归档文件。如果使用包，那么目录或归档文件中的本地路径名必须反映包名。
> 注意：通过类路径查找的类，如果找到了其源文件，则可能会自动被重新编译。


`-d`用于指定.class文件的生成目录, 将目录 `src/com/tt`下Hello.Java类编译到`bin`目录下
美中不足的是-d需要指定已经存在的目录，不能自动创建。
`javac -sourcepath src -classpath . -d bin src/com/tt/Hello.java`   
如果没什么其他类的依赖可简写为 `javac -d bin src/com/tt/Hello.java`   

java会基于提供的classpath（缩写成cp）路径去搜索。
`java -classpath bin com.tt.Hello`

将 `bin/ `目录中的所有文件归档到 'classes.jar' 中:
* 方法一: 指定`MANIFEST.MF`文件的命令:  `jar vcfm classes.jar MANIFEST.MF -C bin/ .`

* 方法二: 先直接生成
`jar vcf classes.jar -C bin/ .`
再winRAR直接修改`MANIFEST.MF`![image.png](https://upload-images.jianshu.io/upload_images/1662509-1948d6b4264b6e63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
或者拿出`MANIFEST.MF`文件后命令`jar vufm classes.jar MANIFEST.MF`, 这里注意要空两个空行, 如果遇到`Duplicate name in Manifest: Created-By.`这种语句直接忽略就好, 因为字段有重名而已。

> 之所以加'v'是为了生成详细输出

### 关于Classpath一些笔记
`Classpath`可以用3种不同的方式设置：
* 如果没有设置——那么classpath参数就会被忽略，环境变量中的CLASSPATH就会被使用到
* 如果环境变量CLASSPATH没找到，那么就是默认使用当前目录（”.”）
* 如果classpath作为命令行参数显示设置了，那么它就是覆盖所有其他的值。 当设置覆盖默认值（当前目录）时，classpath会造成不可预料的结果。 所以要么省略, 要么`-cp .;lib/aaa.jar`例如为`javac -cp .;lib/aaa.jar bbb.java`

入门小案例
```xml
<?xml version="1.0"?>
<project name="MyProject" default="dist" basedir=".">
	<description>
		simple example build file
	</description>	

	<!-- 加载配置文件 -->
	<property file="build.properties"/>

	<!-- set global properties for this build -->
	<property name="src" location="src"/>
	<property name="build" location="build/classes"/>
	<property name="dist" location="dist"/>

	<target name="init">
		<!-- Create the time stamp -->
		<tstamp>
        	<format property="DSTAMP" pattern="yyMMdd" />
        </tstamp>

		<!-- Create the build directory structure used by compile -->
		<mkdir dir="${build}"/>
	</target>

	<target name="compile" depends="init"
		description="compile the source">
		<!-- Compile the Java code from ${src} into ${build} -->
		<javac srcdir="${src}" destdir="${build}" includeantruntime="false"/>
	</target>

	<target name="dist" depends="compile"
		description="generate the distribution">
		<!-- Create the distribution directory -->
		<mkdir dir="${dist}/lib"/>
		<!-- Put everything in ${build} into the jar file -->
		<jar jarfile="${dist}/lib/${jar.filename}-${DSTAMP}.jar" basedir="${build}">
			<manifest>
                <attribute name="Main-class" value="${jar.manifest.main-class}" />
            </manifest>
		</jar>
	</target>

	<target name="clean" description="clean up">
		<!-- Delete the ${build} and ${dist} directory trees -->
		<delete dir="${build}"/>
		<delete dir="${dist}"/>
	</target>

</project>
```

