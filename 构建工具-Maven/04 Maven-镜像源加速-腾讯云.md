## 操作场景

为解决软件依赖安装时官方源访问速度慢的问题，腾讯云为一些软件搭建了缓存服务。您可以通过使用腾讯云软件源站来提升依赖包的安装速度。为了方便用户自由搭建服务架构，目前腾讯云软件源站支持公网访问和内网访问。

* 公网访问地址：<http://mirrors.cloud.tencent.com/>
* 内网访问地址：<http://mirrors.tencentyun.com/>

## 设置方法

settings.xml 文件中的 mirrors 标签中添加 mirror 子节点：

```xml
<mirror>
    <id>tencent-cloud</id>
    <mirrorOf>central</mirrorOf>
    <url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
</mirror>
```

## 配置 maven 镜像和私服 (华为云/阿里云) - 简书

<https://www.jianshu.com/p/154058804ac0>
