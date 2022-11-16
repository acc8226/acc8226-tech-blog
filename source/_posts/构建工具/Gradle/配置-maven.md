## 配置环境变量

gradle_home
变量名：GRADLE_HOME
变量值：D:\work\gradle-6.5（gradle安装目录）
path（编辑）

变量名：Path（编辑）
变量值：%GRADLE_HOME%\bin（增加）
gradle_user_home（在远程仓库下载的jar包保存到该路径下）

变量名：GRADLE_USER_HOME
变量值：D:\work\gradleCK

## 配置 maven 镜像地址

Gradle的配置文件为用户根目录下的：~/.gradle/init.gradle（Windows路径为：C:\Users\<UserName>\.gradle\ init.gradle）。

```gradle
allprojects{
    repositories {
        maven {
            url 'https://mirrors.huaweicloud.com/repository/maven/'
        }
    }
    buildscript {
        repositories {
            maven {
                url 'https://mirrors.huaweicloud.com/repository/maven/'
            }
        }
    }
}
```

## 一个教程

<http://blog.didispace.com/books/GradleUserGuide/>
