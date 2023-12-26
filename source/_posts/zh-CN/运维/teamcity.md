---
title: teamcity
date: 2023-10-08 19:57:40
updated: 2023-10-08 19:57:40
categories: 运维
---

```sh
docker run --name teamcity-server-instance \
-v /opt/modules/teamcity-server/datadir:/data/teamcity_server/datadir \
-v /opt/modules/teamcity-server/logs:/opt/teamcity/logs \
-p 8111:8111 \
jetbrains/teamcity-server
```

管理员账号
tq
tqtqtqtq1234564321
