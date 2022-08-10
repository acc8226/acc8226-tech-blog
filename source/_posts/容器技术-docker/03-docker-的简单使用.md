---
title: 03. docker-的简单使用
date: 2022.02.18 22:09:08
categories:
  - 容器技术
  - docker
tags:
- docker
---

前提：在一台已经安装了 docker 的机器上。

Docker 允许你在容器内运行应用程序， 使用 `docker run` 命令来在容器内运行一个应用程序。

通过运行 hello-world 映像来验证是否正确安装了 Docker 。

```sh
sudo docker run hello-world
```

run 命令可以加的参数。

* -i 以交互模式运行容器，通常与 -t 同时使用；
* -t 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
* -d 后台运行容器，并返回容器ID。

> 注：加了 -d 参数默认不会进入容器，想要进入容器需要使用指令 docker exec。

我们通过 docker run 并分别加上两个参数 -i -t，让 docker 运行的容器实现"对话"的能力：

```sh
docker run -i -t ubuntu:15.10 /bin/bash
```

当然 -i -t 连写为 -it

```sh
docker run -it ubuntu:15.10 /bin/bash
```

**启动容器（后台模式）**

```sh
docker run -d ubuntu:15.10 \
/bin/sh -c "while true; do echo hello world; sleep 1; done"
```

在输出中，我们没有看到期望的 "hello world"，而是一串长字符. 这个长字符串叫做容器 ID，对每个容器来说都是唯一的，我们可以通过容器 ID 来查看对应的容器发生了什么。

`docker ps` 可以查看当前哪些 docker 容器正在运行

在宿主主机内使用 `docker logs 容器 id` 命令，查看容器内的标准输出：

```sh
docker logs 2b1b7a428627
```

`docker images` 查看下载了哪些镜像

`docker container ls` 查看正在运行的容器
`docker container ls -a` 查看所有容器, 包含了已停止的容器

`docker rm bdc8d8c475cb` 删除容器, bdc8d8c475cb是容器id
`docker rm -f 1e560fca3906` 强制删除容器

指定容器 CONTAINER ID 启动容器
`docker start <CONTAINER ID>`
指定容器名称启动容器
`docker start <CONTAINER NAME>`

指定 CONTAINER ID 停止容器
`docker stop <CONTAINER ID>`
指定容器名称停止容器
`docker stop <CONTAINER NAME>`

指定容器 CONTAINER ID 重启容器
`docker restart <CONTAINER ID>`
指定容器名称重启容器
`docker restart <CONTAINER NAME>`

### 进入容器

`docker attach` 如果从这个容器退出，会导致容器的停止。

`docker exec` **推荐**大家使用 docker exec 命令，因为此退出容器终端，不会导致容器的停止。
`docker exec -it 243c32535da7 /bin/bash`

要退出终端，直接输入 exit  即可。

### 导出和导入容器

```sh
docker export 1e560fca3906 > ubuntu.tar
```

导入容器快照
可以使用 docker import 从容器快照文件中再导入为镜像，以下实例将快照文件 ubuntu.tar 导入到镜像 test/ubuntu:v1:

```sh
cat docker/ubuntu.tar | docker import - test/ubuntu:v1
```

此外，也可以通过指定 URL 或者某个目录来导入，例如：

```sh
docker import http://example.com/exampleimage.tgz example/imagerepo
```

**离线镜像文件导入**
内网环境没法 pull 镜像，但是 docker 本身可以将已有的镜像导出成 tar 文件，并且可以再次导入到 docker，利用这一点，可以实现离线镜像文件的下载。
找一台可以联网的 docker 机器，并 pull 下载需要的镜像文件。
然后使用如下命令将镜像文件导出:

```sh
docker save java:8 -o java.tar  #将 java 8的镜像导出成 tar 文件
```

将 tar 文件上传到内网 docker 服务器，使用如下命令导入镜像文件：

```sh
docker load -i java.tar
```

### 网络端口的快捷方式

通过 docker ps 命令可以查看到容器的端口映射，docker 还提供了另一个快捷方式 docker port，使用 docker port 可以查看指定 （ID 或者名字）容器的某个确定端口映射到宿主机的端口号。

```sh
docker port wizardly_chandrasekhar
5000/tcp -> 0.0.0.0:5000
```

### 查看 WEB 应用程序日志

docker logs [ID或者名字] 可以查看容器内部的标准输出。

```sh
docker logs -f bf08b7f2cd89
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
192.168.239.1 - - [09/May/2016 16:30:37] "GET / HTTP/1.1" 200 -
192.168.239.1 - - [09/May/2016 16:30:37] "GET /favicon.ico HTTP/1.1" 404 -
```

-f: 让 docker logs 像使用 tail -f 一样来输出容器内部的标准输出。

### 查看 WEB 应用程序容器的进程

我们还可以使用 docker top 来查看容器内部运行的进程

```sh
docker top wizardly_chandrasekhar
UID     PID         PPID          ...       TIME                CMD
root    23245       23228         ...       00:00:00            python app.py
```

### 检查 WEB 应用程序

使用 docker inspect 来查看 Docker 的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息。

```sh
runoob@runoob:~$ docker inspect wizardly_chandrasekhar
[
    {
        "Id": "bf08b7f2cd897b5964943134aa6d373e355c286db9b9885b1f60b6e8f82b2b85",
        "Created": "2018-09-17T01:41:26.174228707Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 23245,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2018-09-17T01:41:26.494185806Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
......
```

## 其他

docker重启参数--restart=always的作用_bjywxc的博客-CSDN博客_restart=always
<https://blog.csdn.net/bjywxc/article/details/103530262>

## 参考

docker 仓库
<https://hub.docker.com/search?q=&type=image>
