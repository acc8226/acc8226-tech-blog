<https://www.cnblogs.com/followyou/p/9460058.html>

9000 被PHP占用了

/etc/php-fpm.d/www.conf
从9000改为9001

```
listen = 127.0.0.1:9001
```

停止原先的 php-fpm：

```
[root@localhost init.d]# killall php-fpm
[root@localhost init.d]# service php-fpm start
```

或者直接reload一下，一般是重新加载配置文件php.ini：

```
service php-fpm reload
```
