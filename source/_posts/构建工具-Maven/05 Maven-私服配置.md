## 配置华为云私有库下载

1\. settings.xml 中设置仓库凭证：servers 节点中添加如下配置

```xml
    <server>
        <id>releases</id>
        <username>************</username>
        <password>************</password>
    </server>
    <server>
        <id>snapshots</id>
        <username>************</username>
        <password>************</password>
    </server>
```

2\. 在 profiles 节点中添加如下配置。并需要在 settings.xml 文件<activeProfiles>标签中启用。

```xml
<profile>
    <id>MyProfile</id>
    <repositories>
        <repository>
            <id>releases</id>
            <url>https://devrepo.devcloud.cn-north-4.huaweicloud.com/07/nexus/content/repositories/088dbeef3980f4050f6fc007779eab60_1_0/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
        <repository>
            <id>snapshots</id>
            <url>https://devrepo.devcloud.cn-north-4.huaweicloud.com/07/nexus/content/repositories/088dbeef3980f4050f6fc007779eab60_2_0/</url>
            <releases>
                <enabled>false</enabled>
            </releases>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
        </repository>
    </repositories>
</profile>
```

## 配置阿里云私有库下载

1\. 在 settings.xml 中添加认证信息
在 Maven 默认 settings.xml 中找到 servers 的部分，添加一个 server 配置如下。

```xml
<servers>
    <server>
        <id>rdc-releases</id>
        <username>***</username>
        <password>******</password>
    </server>
    <server>
        <id>rdc-snapshots</id>
        <username>***</username>
        <password>******</password>
    </server>
</servers>
```

2\. 在 profiles 节点添加如下配置, 其中 repository 是顺序搜索下载包的.

```xml
<profile>
    <id>rdc-private-repo</id>
    <repositories>
        <repository>
            <id>rdc-releases</id>
            <url>https://repo.rdc.aliyun.com/repository/78947-release-CfzLQ7/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
        <repository>
            <id>rdc-snapshots</id>
            <url>https://repo.rdc.aliyun.com/repository/78947-snapshot-XtuBsZ/</url>
            <releases>
                <enabled>false</enabled>
            </releases>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
        </repository>
    </repositories>
    <pluginRepositories>
        <pluginRepository>
            <id>rdc-releases</id>
            <url>https://repo.rdc.aliyun.com/repository/78947-release-CfzLQ7/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </pluginRepository>
        <pluginRepository>
            <id>rdc-snapshots</id>
            <url>https://repo.rdc.aliyun.com/repository/78947-snapshot-XtuBsZ/</url>
            <releases>
                <enabled>false</enabled>
            </releases>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
        </pluginRepository>
    </pluginRepositories>
</profile>
```

## 使用 properties 简化 url 配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings
    xmlns="http://maven.apache.org/SETTINGS/1.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <mirrors>
        <mirror>
            <id>huawei-yun-mirror</id>
            <mirrorOf>central</mirrorOf>
            <url>https://repo.huaweicloud.com/repository/maven/</url>
        </mirror>
    </mirrors>
    <profiles>
        <profile>
            <id>my-profile</id>
            <properties>
                <my.repo.url>---------YOUE_URL---------</my.repo.url>
            </properties>
            <repositories>
                <repository>
                    <id>my-repo</id>
                    <url>${my.repo.url}</url>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>my-repo</id>
                    <url>${my.repo.url}</url>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
    <activeProfiles>
        <activeProfile>my-profile</activeProfile>
    </activeProfiles>
</settings>
```

## 拉取制品

```sh
mvn clean package
```

## 参考

1. 华为开源镜像站_软件开发服务_华为云 <https://mirrors.huaweicloud.com/home>
2. Maven 仓库 · 云效 Packages · 企业级制品仓库 <https://packages.aliyun.com/maven>
3. Maven 查看当前生效配置、pom、环境变量等命令（mvn help用法） - 简书 <https://www.jianshu.com/p/6184fa25fd53>
