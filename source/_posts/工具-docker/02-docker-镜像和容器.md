---
title: 02. docker 镜像和容器
date: 2022.03.05 22:11:27
categories: 工具-docker
tags:
- docker
---

## docker 镜像

### 查找镜像 search

我们可以从 Docker Hub 网站来搜索镜像，Docker Hub 网址为： **[https://hub.docker.com/](https://hub.docker.com/)**

我们也可以使用 docker search 命令来搜索镜像。比如我们需要一个 httpd 的镜像来作为我们的 web 服务。我们可以通过 docker search 命令搜索 httpd 来寻找适合我们的镜像。

搜索镜像

```bash
docker search httpd
```

表头释义：

* NAME: 镜像仓库源的名称
* DESCRIPTION: 镜像的描述
* OFFICIAL: 是否 docker 官方发布
* stars: 类似 Github 里面的 star，表示点赞、喜欢的意思。
* AUTOMATED: 自动构建。

### 获取镜像 pull

当我们在本地主机上使用一个不存在的镜像时 Docker 就会自动下载这个镜像。如果我们想预先下载这个镜像，我们可以使用 docker pull 命令来下载它。如果不指定标签版本，就会用默认的标签latest去下载最新版本的 Redis 镜像。

```sh
docker pull ubuntu
```

或者

```sh
docker pull ubuntu:lastest
```

### 列出已有镜像 image ls

我们可以使用 docker images ls 来列出本地主机上的镜像。

```text
C:\Users\hp>docker image ls
REPOSITORY          TAG       IMAGE ID       CREATED        SIZE
hello-world         latest    feb5d9fea6a5   4 months ago   13.3kB
garland/butterfly   3.2.3     7709f74c4d5d   3 years ago    471MB
```

其中，REPOSITORY 和 TAG 字段分别表示镜像的名字和标签，IMAGE ID 表示镜像的ID，CREATED 和 SIZE 分别表示该镜像的创建时间和大小。一般来说，可以通过 REPOSITORY:TAG 或 IMAGE ID 唯一标识某个镜像。

### 删除镜像 rmi

该命令能删除本地镜像，具体语法是 `docker rmi 镜像名:标签`，或者 `docker rmi 镜像 ID`。

* -f :强制删除；
* --no-prune :不移除该镜像的过程镜像，默认移除；

举例：

```sh
docker rmi ubuntu:latest
```

或

```sh
docker rmi1d622ef86b13
```

删除全部容器

```sh
docker rm $(docker ps -aq)
```

### 创建自己的镜像 commit

当我们从 docker 镜像仓库中下载的镜像不能满足我们的需求时，我们可以通过以下两种方式对镜像进行更改。

1、从已经创建的容器中更新镜像，并且提交这个镜像
2、使用 Dockerfile 指令来创建一个新的镜像

```sh
docker commit \
-m="has update" \
-a="runoob" e218edb10161 runoob/ubuntu:v2
```

各个参数说明：

* -m: 提交的描述信息
* -a: 指定镜像作者
* e218edb10161：容器 ID

runoob/ubuntu:v2: 指定要创建的目标镜像名
我们可以使用 docker images 命令来查看我们的新镜像 runoob/ubuntu:v2：

### 设置镜像标签

我们可以使用 docker tag 命令，为镜像添加一个新的标签。

```sh
docker tag 860c279d2fec runoob/centos:dev
```

docker tag 镜像ID，这里是 860c279d2fec ,用户名称/镜像源名(repository name)和新的标签名(tag)。

使用 docker images 命令可以看到，ID为 860c279d2fec 的镜像多一个标签。

```sh
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
runoob/centos       6.7                 860c279d2fec        5 hours ago         190.6 MB
runoob/centos       dev                 860c279d2fec        5 hours ago         190.6 MB
runoob/ubuntu       v2                  70bf1840fd7c        22 hours ago        158.5 MB
ubuntu              14.04               90d5884b1ee0        6 days ago          188 MB
```

## Docker 容器

```sh
docker run -d \
-P training/webapp python app.py
```

我们也可以使用 -p 标识来指定容器端口绑定到主机端口。

两种方式的区别是:

-P :是容器内部端口随机映射到主机的高端口。
-p : 是容器内部端口绑定到指定的主机端口。

另外，我们可以指定容器绑定的网络地址，比如绑定 127.0.0.1。

```sh
docker run -d \
-p 127.0.0.1:5001:5000 \
training/webapp python app.py
```

这样我们就可以通过访问 127.0.0.1:5001 来访问容器的 5000 端口。

上面的例子中，默认都是绑定 **tcp** 端口，如果要绑定 UDP 端口，可以在端口后面加上 /udp。

```sh
$ docker run -d \
-p 127.0.0.1:5000:5000/udp \
training/webapp python app.py
```

docker port 命令可以让我们快捷地查看端口的绑定情况。

```sh
docker port adoring_stonebraker 5000
127.0.0.1:5001
```

### 能看到当前所有的容器

```sh
docker ps
```

进入容器的配置文件夹

```sh
cd /var/lib/docker/containers/
```

### docker 容器互联

端口映射并不是唯一把 docker 连接到另一个容器的方法。

docker 有一个连接系统允许将多个容器连接在一起，共享连接信息。

docker 连接会创建一个父子关系，其中父容器可以看到子容器的信息。

### 新建网络

下面先创建一个新的 Docker 网络。
`$ docker network create -d bridge test-net`

参数说明：

-d：参数指定 Docker 网络类型，有 bridge、overlay。

其中 overlay 网络类型用于 Swarm mode，在本小节中你可以忽略它。

### 连接容器

运行一个容器并连接到新建的 test-net 网络:
`$ docker run -itd --name test1 --network test-net ubuntu /bin/bash`

**停止容器**

```sh
docker stop 容器name/id
```

### 配置 DNS

我们可以在宿主机的 /etc/docker/daemon.json 文件中增加以下内容来设置全部容器的 DNS：

```json
{
  "dns" : [
    "114.114.114.114",
    "8.8.8.8"
  ]
}
```

设置后，启动容器的 DNS 会自动配置为 114.114.114.114 和 8.8.8.8。配置完，需要重启 docker 才能生效。

查看容器的 DNS 是否生效可以使用以下命令，它会输出容器的 DNS 信息：

```sh
docker run -it --rm ubuntu cat etc/resolv.conf
```

## 参考

<https://www.runoob.com/docker/docker-image-usage.html>
