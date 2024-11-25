---
title: 04. Maven-镜像源加速
date: 2020-05-07 00:51:23
updated: 2022-11-01 13:43:00
categories:
  - 构建工具
  - Maven
tags:
- Maven
---

## 操作场景

为解决软件依赖安装时官方源访问速度慢的问题，为了提升依赖包的安装速度。

## 腾讯云开源镜像站加速

打开 maven 的配置文件（ windows 机器一般在 maven 安装目录的 conf/settings.xml ），在 `<mirrors></mirrors>` 标签中添加 mirror 子节点:

```xml
<mirror>
    <id>qq-cloud</id>
    <mirrorOf>central</mirrorOf>
    <url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
</mirror>
```

<!-- more -->

内网访问地址请替换为 <http://mirrors.tencentyun.com/>

## 华为开源镜像站加速

```xml
<mirror>
        <id>hw-cloud</id>
        <mirrorOf>central</mirrorOf>
        <url>https://repo.huaweicloud.com/repository/maven/</url>
</mirror>
```

## 阿里云开源镜像站加速

```xml
<mirror>
    <id>ali-mirror</id>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

如果想使用其它代理仓库,可在 profile 下的 `<repositories></repositories>` 节点中加入对应的仓库使用地址。以使用 Spring 代理仓为例：

```xml
<repository>
    <id>spring</id>
    <url>https://maven.aliyun.com/repository/spring</url>
    <releases>
        <enabled>true</enabled>
    </releases>
    <snapshots>
        <enabled>true</enabled>
    </snapshots>
</repository>
```

| 仓库名称         | 阿里云仓库地址     | 阿里云仓库地址(老版)         | 源地址         |
| :--------------- | :--------------------------------------------------- | :----------------------------------------------------------- | :--------------------------------------- |
| central          | <https://maven.aliyun.com/repository/central>          | <https://maven.aliyun.com/nexus/content/repositories/central>  | <https://repo1.maven.org/maven2/>          |
| jcenter          | <https://maven.aliyun.com/repository/public>           | <https://maven.aliyun.com/nexus/content/repositories/jcenter>  | <http://jcenter.bintray.com/>              |
| public           | <https://maven.aliyun.com/repository/public>           | <https://maven.aliyun.com/nexus/content/groups/public>         | central仓和jcenter仓的聚合仓             |
| google           | <https://maven.aliyun.com/repository/google>           | <https://maven.aliyun.com/nexus/content/repositories/google>   | <https://maven.google.com/>                |
| gradle-plugin    | <https://maven.aliyun.com/repository/gradle-plugin>    | <https://maven.aliyun.com/nexus/content/repositories/gradle-plugin> | <https://plugins.gradle.org/m2/>           |
| spring           | <https://maven.aliyun.com/repository/spring>           | <https://maven.aliyun.com/nexus/content/repositories/spring>   | <http://repo.spring.io/libs-milestone/>    |
| spring-plugin    | <https://maven.aliyun.com/repository/spring-plugin>    | <https://maven.aliyun.com/nexus/content/repositories/spring-plugin> | <http://repo.spring.io/plugins-release/>   |
| grails-core      | <https://maven.aliyun.com/repository/grails-core>      | <https://maven.aliyun.com/nexus/content/repositories/grails-core> | <https://repo.grails.org/grails/core>      |
| apache snapshots | <https://maven.aliyun.com/repository/apache-snapshots> | <https://maven.aliyun.com/nexus/content/repositories/apache-snapshots> | <https://repository.apache.org/snapshots/> |

## 推荐写法

如果其中一个不行则重新选择一个 url 即可。

```xml
<mirror>
    <id>aliyun-mirror</id>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/repository/public</url>
    <!-- <url>https://repo.huaweicloud.com/repository/maven/</url> -->
</mirror>
```
