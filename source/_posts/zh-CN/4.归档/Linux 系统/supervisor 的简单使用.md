---
title: supervisor 的简单使用
date: 2025-07-10 22:19:00
updated: 2025-07-10 22:19:00
categories: linux
---

Supervisor 是一个进程控制系统，它使用户能够监视和控制类 unix 操作系统进程。它通过提供基于配置或事件启动、停止和重新启动进程的机制，帮助管理应该在系统中连续运行的进程。对于需要控制和监视 Linux 或其他类 unix 操作系统上多个进程的状态的开发人员和系统管理员来说，Supervisor特别有用。

<!-- more -->

sudo apt install supervisor

去 /etc/supervisor/conf.d 目录下创建一个 mpan.conf 的存储程序配置。

```conf
[program:mpan]
command=pipenv run gunicorn -w 1 -b 0.0.0.0:80 app:app
; command=gunicorn -w 1 -b 0.0.0.0:80 app:app
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
stderr_logfile=/var/log/mpan.err.log
stdout_logfile=/var/log/mpan.out.log
user=kaige
directory=/home/kaige/mpan
```

```
sudo nano /etc/supervisor/supervisord.conf
```

需要在 [supervisord] 节点下添加

environment=LC_ALL='en_US.UTF-8',LANG='en_US.UTF-8'

直接键入 supervisorctl 来查看和操作相关程序。

sudo supervisorctl

stop mpan
start mpan
tail mpan stderr

- - -

sudo supervisorctl reread
sudo supervisorctl update

---

sudo supervisorctl mpan stop
sudo supervisorctl mpan start


windows

pip install virtualenv
python -m venv myenv
myenv\Scripts\activate
deactivate

Mac/Linux 系统
python3 -m venv myenv
source myenv/bin/activate
deactivate

pip install pipenv

或

sudo -H pip3 install pipenv 啥意思
-H：这个选项告诉 pip 不要在系统目录中安装包，而是安装到用户的主目录下。这样做的好处是，用户可以安装包而不需要 sudo 权限，同时也不会影响系统中的其他 Python 环境。

直接创建虚拟环境
pipenv install

方便安装包
pipenv install requests
pipenv install flask

pipenv update flask 更新包

激活 Pipenv 创建的虚拟环境，只需运行：
pipenv shell
使用 exit 可以退出虚拟环境

pipenv run python hello.py 可以在不显示激活虚拟环境下执行命令

linux 环境安装 python3
apt install python3-dev python3-pip
