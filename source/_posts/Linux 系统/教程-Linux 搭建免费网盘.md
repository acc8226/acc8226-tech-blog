## IfileSpace

[IfileSpace 私人网盘](https://ifile.space/)文件管理工具

> iFileSpace 是一个在线个人文件管理工具，在线网盘程序，可快速一键搭建私人云盘，支持本地存储和对象存储, 如部署在公网服务器，可替代百度网盘等在线网盘，自主搭建，数据完全自主管理！也可部署在家庭软路由、nas 等个人存储设备中，作为局域网文件管理工具使用。支持多用户、多存储空间、资料库、webdav、离线下载及精细的后台权限管理。

标准版一般够用，官网都有提供安卓苹果和PC客户端。

**使用方法**

下载对应平台压缩包解压到您觉得合适的地方，系统默认存储空间为启动文件相同文件夹。解压后只有一个二进制文件。

```sh
cd /yourpath/   #(yourpath替换为您文件路径)
./ifile &
```

**Nginx 反向代理示例**

Nginx 反向代理需添加：proxy_set_header X-Forwarded-Proto $scheme;

```conf
server {
    listen       80;
    server_name  demo.ifile.space;

    location / {
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP       $remote_addr;
      proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_pass http://127.0.0.1:3030;
  }
}
```

**亮点：可配置 webdav**

安卓手机搭配 ES浏览器可以倍速播放视频还是不错滴。

## seafile

更加适合于办公，很多单位机关都在用。它提供了在线编辑 office 的支持。这个 wiki 在书写方面还是感觉有所欠缺。

1\. 安装最新的 Seafile 9.0.x 版本服务器之前，请确认已安装以下软件

```sh
# on Debian 10/Ubuntu 18.04/Ubuntu 20.04
apt-get update
apt-get install python3 python3-setuptools python3-pip python3-ldap  libmysqlclient-dev  -y

pip3 install --timeout=3600 django==3.2.* future mysqlclient pymysql Pillow pylibmc \
captcha jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha pycryptodome==3.12.0
```

2\. 到 [Seafile 页面](http://www.seafile.com/download)下载最新的服务器安装包。

3\. 下载后进行安装

```sh
cd seafile-server-*

./setup-seafile-mysql.sh  #运行安装脚本并回答预设问题
```

如果你的系统中没有安装上面的某个软件，那么 Seafile初始化脚本会提醒你安装相应的软件包。该脚本会依次询问你一些问题，从而一步步引导你配置 Seafile 的各项参数。
