## 上传设置

1\. settings.xml 中设置仓库凭证：servers 节点中添加如下配置.[如果未加密则可跳过]

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

2\. pom.xml 配置

配置好了settings.xml后，在 **代码库根目录**下的 pom.xml 加入以下配置:

```xml
<!-- 需要发布二方包 则打开下列配置 -->
<distributionManagement>
    <repository>
        <id>rdc-releases</id>
        <url>https://repo.rdc.aliyun.com/repository/78947-release-CfzLQ7/</url>
    </repository>
    <snapshotRepository>
        <id>rdc-snapshots</id>
        <url>https://repo.rdc.aliyun.com/repository/78947-snapshot-XtuBsZ/</url>
    </snapshotRepository>
</distributionManagement>
```

3\. 推送到私有仓库中

```sh
mvn clean deploy -DskipTests
```

或者指定 deploy plugin 版本并进行部署

```sh
mvn clean org.apache.maven.plugins:maven-deploy-plugin:2.8:deploy -DskipTests
```

## 拉取制品到仓库

进入所在 maven 项目，执行 `mvn package` 命令即可。

否则需要建立空白仓库。空白仓库的用处是可以作为批量制品迁移的原始仓库，需要用 `-Dmaven.repo.local` 的参数。

```sh
mvn archetype:generate \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DartifactId=edu \
-DgroupId=ecjtu \
-DarchetypeVersion=1.4 \
-DinteractiveMode=false
```

然后在代码根目录下运行

```sh
mvn clean package -U -Dmaven.repo.local=../tmpRepo
```

如果构建成功则会在上级目录创建 tmpRepo 本地仓库。

然后你的pom.xml文件 `<denpendencies></denpendencies>` 节点中加入你要引用的文件信息。可以再次进行 package 操作。依赖则会下载到本地。

## 通过 deploy 插件上传

如果第三方 Maven 包未正规发布到网络仓库，而且仅提供 jar 包，未提供源码或者源码编译报错，那我们可以把 jar 包直接上传到仓库，命令如下：

```sh
mvn deploy:deploy-file -Durl=file://C:\m2-repo \
                       -DrepositoryId=some.id \
                       -Dfile=your-artifact-1.0.jar \
                       [-DpomFile=your-pom.xml] \
                       [-DgroupId=org.some.group] \
                       [-DartifactId=your-artifact] \
                       [-Dversion=1.0] \
                       [-Dpackaging=jar] \
                       [-Dclassifier=test] \
                       [-DgeneratePom=true] \
                       [-DgeneratePom.description="My Project Description"] \
                       [-DrepositoryLayout=legacy]
```

如果第三方提供了 `pom.xml`，可以从中读取 group、artifact、version 等字段，比如「[微信云支付 Java SDK](https://cloud.tencent.com/document/product/569/9806)」使用下列命令：

```sh
mvn deploy:deploy-file --settings ./settings.xml -Durl=https://coding-public-maven.pkg.coding.net/repository/tencent-cloud-pay-sdk-java/tencent/ \
                       -DrepositoryId=coding-public-tencent-cloud-pay-sdk-java-tencent \
                       -Dfile=../cloudpay.jar \
                       -DpomFile=pom.xml
```

## 通过网页上传

登录对应的私服地址，比如是nexus。然后选择左侧菜单的 upload。

其他版本的nexus可能是其他方式上传。

### 【推荐方式一】migrate-local-repo-tool.jar 工具批量制品上传

操作步骤：

1.下载迁移工具[migrate-local-repo-tool.jar](https://agent-install.oss-cn-hangzhou.aliyuncs.com/migrate-local-repo-tool.jar)

2.在您本地运行该迁移工具，（请首先确保您的JDK版本为1.8及以上）。运行命令如下：

```bash
java -jar migrate-local-repo-tool.jar -cd "C:/Users/hp\Desktop/abc/tmpRepo/classworlds/classworlds/1.1
" -t "https://packages.aliyun.com/maven/repository/2001766-release-lv0JtK" -u ******* -p *******
```

参数注解：
-cd 您要迁移的本地目录，例如：/$HOME/.m2/repository/
-t 目标仓库地址（您可以在【私有仓库】界面点击仓库地址，获取您的目标仓库地址）
-u 用户名
-p 密码

根据您的实际需求指定合适的参数，然后执行该命令，稍等片刻，您的本地仓库中的制品将会被批量迁移到您所指定的 Maven 私库中。

如果迁移的本地目录中文件目录过多或者目录层级过深，可能会导致迁移命令卡死或者返回异常。推荐做法是只迁移你自己的私有制品到私有仓库中，构建时拉取公共制品包可以使用我们提供的公共代理库。比如假设你的私有制品都放置在 /$HOME/.m2/repository/com/alibaba/ **目录中，你可以将com/alibaba/** 目录复制一份到一个空的目录中，比如复制到 /tmp/repo/ 中，然后运行迁移命令时将-cd命令参数指定为 /tmp/repo/，这样迁移工具只会迁移你的私有制品。

### 【推荐方式二】批量上传Maven仓库 jar 包到 Nexus3.x 私服

1.先将本地 maven/repository 仓库打一个完整的zip压缩包
2.上传到 linux 目录，如：/opt
3.解压 repository.zip
4.进入repository 目录
5.创建 touch mavenimport.sh 脚本，写入以下内容；

```sh
#!/bin/bash
# copy and run this script to the root of the repository directory containing files
# this script attempts to exclude uploading itself explicitly so the script name is important
# Get command line params

while getopts ":r:u:p:" opt; do
	case $opt in
		r) REPO_URL="$OPTARG"
		;;
		u) USERNAME="$OPTARG"
		;;
		p) PASSWORD="$OPTARG"
		;;
	esac
done

find . -type f -not -path './mavenimport\.sh*' -not -path '*/\.*' -not -path '*/\^archetype\-catalog\.xml*' -not -path '*/\^maven\-metadata\-local*\.xml' -not -path '*/\^maven\-metadata\-deployment*\.xml' | sed "s|^\./||" | xargs -I '{}' curl -u "$USERNAME:$PASSWORD" -X PUT -v -T {} ${REPO_URL}/{} ;
```

6.输入chmod a+x mavenimport.sh进行可执行授权
7.执行导入命令

```sh
./mavenimport.sh -u admin -p admin123 -r http://ip:8081/repository/maven-releases/
```

8.等待全部导入完毕后，在 Nexus 上刷新即可看到已导入的 jar。
