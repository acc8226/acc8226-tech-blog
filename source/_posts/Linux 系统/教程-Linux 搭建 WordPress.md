官网
<https://cn.wordpress.org/download/>

```sh
wget https://cn.wordpress.org/latest-zh_CN.tar.gz
tar -zxvf latest-zh_CN.tar.gz

mkdir /var/www/html/wp-blog
mv wordpress/* /var/www/html/wp-blog/

# 进入 WordPress 目录
cd /var/www/html/wp-blog/
# 复制模板文件为配置文件
cp wp-config-sample.php wp-config.php
# database_name_here 为数据库名称
sed -i 's/database_name_here/wordpress/' /var/www/html/wp-blog/wp-config.php
# username_here 为数据库的用户名
sed -i 's/username_here/root/' /var/www/html/wp-blog/wp-config.php
# password_here 为数据库的登录密码
sed -i 's/password_here/NewPassWord1./' /var/www/html/wp-blog/wp-config.php

systemctl start httpd
```

浏览器访问 <http://ECS公网IP/wp-blog/wp-admin/install.php> 完成 wordpress 初始化配置。
