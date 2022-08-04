---
title: rabbitmq
categories: 消息队列
---

RabbitMQ 是目前非常热门的一款消息中间件，不管是互联网行业还是传统行业都在大量地使用。RabbitMQ 凭借其高可靠、易扩展、高可用及丰富的功能特性受到越来越多企业的青睐。作为一个合格的开发者，有必要深入地了解 RabbitMQ 的相关知识，为自己的职业生涯添砖加瓦。

## rabbitmq 下载安装

Messaging that just works — RabbitMQ
<https://www.rabbitmq.com/>

前提：已安装了 Erlang 语言

Downloads - Erlang/OTP
<https://www.erlang.org/downloads>

若仅是体验 rabbitmq，可借助 docker 工具。

```sh
docker run -it --rm --name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:3.10-management
```

## 使用

RabbitMQ Management 管理页面
<http://localhost:15672/#/>
