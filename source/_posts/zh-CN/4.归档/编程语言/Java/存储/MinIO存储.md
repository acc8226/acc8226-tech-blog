---
title: MinIO 存储
date: 2022-08-12 19:06:00
updated: 2022-08-12 19:06:00
categories:
  - 语言-Java
  - 框架
---

[MinIO](https://min.io/download#/) | Code and downloads to create high performance object storage

下载和启动

```powershell
PS> Invoke-WebRequest -Uri "https://dl.min.io/server/minio/release/windows-amd64/minio.exe" -OutFile "D:\minio.exe"
PS> setx MINIO_ROOT_USER admin
PS> setx MINIO_ROOT_PASSWORD password
PS> D:\minio.exe server E:\Data --console-address ":9001"
```

minio 提供了一个可视化的管理控制平台，安装好之后，在浏览器中输入(<http://localhost:9000/> (opens new window))就可以访问了。

客户端 cli 支持
<!-- more -->

mc.exe

## Software Development Kits (SDK)

```groovy
dependencies {
    implementation("io.minio:minio:8.5.10")
}
```
