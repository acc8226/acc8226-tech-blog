### 安装 Nginx

`yum install nginx -y`

运行以下命令查看Nginx版本。
`nginx -v`

运行以下命令启动 Nginx 服务。
`systemctl start nginx` = `service nginx restart`
运行以下命令设置Nginx服务开机自启动。
`systemctl enable nginx`
运行以下命令设置Nginx禁止开机自启。
`systemctl disable nginx`
停止服务
`systemctl stop nginx`

### 开始配置

配置文件
/etc/nginx

网页存放文件
/usr/share/nginx/html
