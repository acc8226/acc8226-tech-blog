## 源码构建

本质上来说没有任何难度只要保证能通过 Maven 构建工具的命令在本地编译通过即可，其次保证有数据库就可以了，推荐用 PostgreSQL 做为开发的环境的数据库。

注意：ThingsBoard 从 3.2.2 之后需要将 JDK 更新到 11 版本。

1. 拉取源码

```sh
git clone https://github.com/thingsboard/thingsboard.git && git checkout release-3.3
```

或者下载指定 tag 标签所在分支。

2\. 预先环境
JDK 11 和 maven 3.6 及其以上。此版本无需预先安装 node 和 yarn。如果需要进行前端调试，则建议安装 node 和 yarn。

3\. 构建打包

构建打包且跳过测试

```sh
mvn clean install -Dmaven.test.skip=true
```

> 为加快编译运行，可在调试时暂时**屏蔽 license**
在源码根目录找到 pom.xml 文件并打开，然后查找 “license-maven-plugin” 内容后，并将整个 plugin 注释掉
> **前端源码编译 ui-ngx(可选)**
第一次编译的话，习惯先编译一下这个模块，因为它第一次编译太慢了。
cd xxx/thingsboard/ui-ngx
mvn clean package -DskipTests

在 install 后，即可在 application/target 中找到产物 debian，rpm 和 Windows 软件包。

```sh
ls -al

-rwxr-xr-x 1 ferder 197121 180241757 Mar 23 10:44 thingsboard-3.3.4.1-boot.jar
-rw-r--r-- 1 ferder 197121   1611307 Mar 23 10:44 thingsboard-3.3.4.1.jar
-rw-r--r-- 1 ferder 197121 166603843 Mar 23 10:44 thingsboard-windows.zip
-rw-r--r-- 1 ferder 197121 166401722 Mar 23 10:44 thingsboard.deb
-rw-r--r-- 1 ferder 197121 166423638 Mar 23 10:44 thingsboard.rpm
```

## 问题总结

### 1. ui-ngx 构建报错

请查看根据终端的报错提示。我的问题出在了 com.github.eirslett:frontend-maven-plugin 插件下载 node 和 yarn 失败。因此查看 thingsboard-release-3.3\ui-ngx\pom.xml 版本要求：

```xml
<configuration>
    <nodeVersion>v16.13.0</nodeVersion>
    <yarnVersion>v1.22.17</yarnVersion>
</configuration>
```

于是手动下载 pom 文件中规定的 node 和 yarn 版本。

node 指定 exe 安装包到 C:\Users\ferder\.m2\repository\com\github\eirslett\node
yarn 指定压缩包到 C:\Users\ferder\.m2\repository\com\github\eirslett\yarn

之后重新运行。

```sh
mvn install -Dmaven.test.skip=true -e -rf :ui-ngx
```

### js-executor 构建报错，可根据终端的提示手动下载 pom 文件中规定的 node 和 yarn 版本后再次重试。或者和最新的保持一致

```sh
mvn install -Dmaven.test.skip=true -e -rf :js-executor
```

### js-executor 再次运行后依旧报错

```sh
 Failed to execute goal com.github.eirslett:frontend-maven-plugin:1.12.0:yarn (yarn pkg) on project js-executor: Failed to run task: 'yarn run pkg' failed. org.apache.commons.exec.ExecuteException: Process exited with an error: 2 (Exit value: 2) -> [Help 1]
```

根据提供的终端报错日志，查明此次原因为 `yarn run pkg` 报错

```text
D:\zhangsan\Projects_Idea\thingsboard-release-3.3\msa\js-executor>yarn run pkg
yarn run v1.22.18
$ pkg -t node12-linux-x64,node12-win-x64 --out-path ./target . && node install.js
> pkg@5.3.1
> Fetching base Node.js binaries to PKG_CACHE_PATH
  fetched-v12.22.2-linux-x64          [                    ] 0%> Not found in remote cache:
  {"tag":"v3.2","name":"node-v12.22.2-linux-x64"}
> Building base binary from source:
  built-v12.22.2-linux-x64
> Error! Not able to build for 'linux' here, only for 'win'
error Command failed with exit code 2.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
```

原因：本地缓存缺少文件
解决方法：下载地址：<https://github.com/zeit/pkg-fetch/releases> 。

前往 github 下载对应文件

下载链接：
<https://github.com/vercel/pkg-fetch/releases/download/v3.2/node-v12.22.2-linux-x64>
<https://github.com/vercel/pkg-fetch/releases/download/v3.2/node-v12.22.2-win-x64>

并重命名，并放到对于目录 `C:\Users\ferder\.pkg-cache\v3.2`。

```text
fetched-v12.22.2-linux-x64
fetched-v12.22.2-win-x64
```

## 数据源设置

前提：关系数据库: postgresql(推荐使用 12.x 以上版本)。之后需要先行创建空的 thingsboard 数据库。

方式 1：将 dao 模块的 resources 下的 sql 文件夹 复制到 application 模块的 src/main/data 目录下。之后执行 ThingsboardInstallApplication 类，那么数据库中就有了相应的测试数据。

方式 2：在 mvn install 之后的 application\target\windows 目录下，运行 install_dev_db.bat 批处理文件。**此种方式下会加载 demo 数据。这一点需要注意。**

举例本机所在目录

```text
D:\alee\Projects_Idea\thingsboard-release-3.3\application\target\windows
```

## 环境启动

工具
IDEA 集成开发工具

* Lombok 插件安装
* Protocol Buffers 官方插件安装

PostgreSQL，此处需要使用 PostgreSQL 11.X 及以上版本。

运行 ThingsBoard 服务的 `ThingsboardServerApplication` 的 main 方法 。

## maven 构建技巧

### maven 在构建多模块项目中，从指定位置进行构建应用

> 参考 Maven 常用命令 - 构建反应堆中指定模块_jason5186 的博客-CSDN博客
<https://blog.csdn.net/jason5186/article/details/39530087>
>
> 通过查看 mvn -h命令，可以了解其他命令及其用途；
-am --also-make 同时构建所列模块的依赖模块；
-amd -also-make-dependents 同时构建依赖于所列模块的模块；
-pl --projects `<arg>` 构建制定的模块，模块间用逗号分隔；
-rf -resume-from `<arg>` 从指定的模块恢复反应堆。

譬如：

```sh
mvn install -Dmaven.test.skip=true -e -rf :js-executor
```

## 前端环境说明

根据项目 pom 文件中 node 使用 v16.13.0 版本，所以保持一致即可。目前的要求是不能高于17。

pom 文件中 yarn 指定的是 1.22.17 版本。因此要求此版本或者更高。正常情况下 npm install yarn -g 即可。