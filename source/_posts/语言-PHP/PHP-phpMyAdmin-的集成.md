方式一: 使用 `sudo apt-get install  phpmyadmin` 进行安装,然后自行配置一番就行.

方式二: 去官网下载压缩包,然后解压到对应www下.

接下来复制 phpMyAdmin/config.sample.inc.php 这个文件，改名为 config.inc.php。 然后稍加配置一下。

```php
/**
 * First server
 */
$i++;
/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;

/**
 * 这是我配置的第二台服务器, 其实就是赋值上面的代码稍加改造
 */
$i++;
/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['host'] = '10.1.103.105';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
```

然后就可以像正常访问 mysql 服务一样进行访问即可。
