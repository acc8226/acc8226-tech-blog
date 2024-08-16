---
title: mayfly-go
date: 2024-01-16 18:02:44
updated: 2024-01-16 18:02:44
categories: 运维
---

```sh
docker run -d --name mayfly-go \
-p 18888:8888  \
-v /opt/modules/mayfly-go:/mayfly \
ccr.ccs.tencentyun.com/mayfly/mayfly-go:v1.6.1
```

进入容器
docker exec -it mayfly-go bash

admin / admin123.

这里不建议使用默认密码，进行新建用户或者可以将密码修改为 `mayfly-go:v1.6.1`。

<!-- more -->
