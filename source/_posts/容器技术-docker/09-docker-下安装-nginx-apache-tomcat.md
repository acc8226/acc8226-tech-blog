---
title: 09. docker-下安装-nginx-apache-tomcat
date: 2022.04.19 16:14:29
categories:
  - 容器技术
  - docker
tags:
- docker
- nginx
- apache
- tomcat
---

## 安装 nginx 服务器

访问 nginx Tags | Docker Hub 可查看详情
<https://hub.docker.com/_/nginx?tab=tags>

这里我们拉取官方最新镜像：

```sh
docker pull nginx
```

安装完成后，我们可以使用以下命令来运行 nginx 容器：

```sh
docker run --name my-nginx \
-p 80:80 -d nginx
```

注意事项：

* nginx 配置 config 文件都在 /etc/nginx/
* 默认首页 html 文件目录为 /usr/share/nginx/html/
* 日志文件位于 /var/log/nginx/

参数说明

* --name my-nginx：容器名称。
* -p 80:80： 端口进行映射，将本地 80 端口映射到容器内部的 80 端口。
* -d nginx： 设置容器在在后台一直运行。

**复杂构建**

导出 nginx.conf 和 html 文件夹

导出配置

```sh
docker run --name tmp-nginx-container -d nginx
docker cp tmp-nginx-container:/etc/nginx/ D:/alee/docker/nginx/conf
docker cp tmp-nginx-container:/usr/share/nginx/html/ D:/alee/docker/nginx/html
docker cp tmp-nginx-container:/var/log/nginx/ D:/alee/docker/nginx/log
docker rm -f tmp-nginx-container
```

windows 下挂载目录且启动

```sh
cd  /d D:/alee/docker/nginx
docker run --name my-nginx -p 80:80 ^
-v D:/alee/docker/nginx/conf:/etc/nginx/ ^
-v D:/alee/docker/nginx/html:/usr/share/nginx/html ^
-v D:/alee/docker/nginx/log:/var/log/nginx/ ^
-d nginx
```

## 安装 apache 服务器

```sh
docker pull httpd
```

运行容器

```sh
docker run --name my-apache -p 80:80 \
-v $PWD/www/:/usr/local/apache2/htdocs/  \
-v $PWD/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf  \
-v $PWD/logs/:/usr/local/apache2/logs/ -d httpd
```

## 安装 tomcat 服务器

可以选择精简版

```sh
docker run --name tomcat8 \
-p 8080:8080 \
-dit tomcat:8-jdk8-openjdk-slim
```

或者选择 tomcat 8 搭配 jdk 11 的版本。

```sh
docker run --name tomcat8 \
-p 8080:8080 \
-dit tomcat:8-jdk11
```

当然如果有必要可以创建多个实例

```sh
docker run --name tomcat81 -p 8081:8080 -d tomcat:8-jdk8-openjdk-slim
docker run --name tomcat82 -p 8081:8080 -d tomcat:8-jdk8-openjdk-slim
```

### 部署项目到 tomcat

把 war 包丢到宿主机 再丢到 container 里面丢到 tomcat/webapps

```sh
docker cp demo.war tomcat80:/usr/local/tomcat/webapps
```

不用重启，docker 会自动部署.

**下面是启动方式 2**

```sh
docker run -d \
-v /home/xxx.war:/usr/local/tomcat/webapps/xxx.war \
-p 8080:8080 \
--name 自定义名称 tomcat:8.5.57
```

> 从运行的容器里将配置文件 copy 到本地 的命令
docker cp tmp-tomcat:/usr/local/tomcat/conf /home/tomcat/

最后在浏览器输入：<http://localhost:8080/xxx> ，即可访问项目

### 设置 tomcat

进入tomcat

```sh
docker exec -it tomcat80 bash
```
