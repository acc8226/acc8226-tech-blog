## 介绍

**ThingsBoard 是什么?**
ThingsBoard 是一个开源物联网平台，可实现物联网项目的快速开发、管理和扩展。目标是提供成熟的 IoT 云或本地解决方案以此做为您的 IoT 应用程序服务端基础架构。

在 IoT 平台中，ThingsBoard 是一个备受瞩目的明星项目，其点赞数高达 5K，其优秀的性能和高效的性能得到了广大开发者的认可。ThingsBoard 是用于数据收集、处理、可视化和设备管理的开源物联网平台。它通过行业标准的物联网协议 - MQTT、CoAP 和 HTTP 实现设备连接，并支持云和本地部署。Thingsboard 具有可伸缩性、容错性和性能优越的特点，因此您永远不会丢失数据。

### 特点

**ThingsBoard 可用于:**

* 设备管理，资产和客户并定义他们之间的关系。
* 基于设备和资产收集数据并进行可视化。
* 采集遥测数据并进行相关的事件处理进行警报响应。
* 基于远程 RPC 调用进行设备控制。
* 基于生命周期事件、REST API 事件、RPC 请求构建工作流。
* 基于动态设计和响应仪表板向你的客户提供设备或资产的遥测数据。
* 基于规则链自定义特定功能。
* 发布设备数据至第三方系统。
* 更多…

了解更多功能请参见 [**ThingsBoard 功能列表**](http://www.ithingsboard.com/docs/#community-edition-features) 。

**ThingsBoard 设计原则:**

* 高扩展: 使用领先开源技术构建的可水平扩展平台。
* 高容错：无单点故障集群中的每个节点都是相同的。
* 高性能：单个服务器节点可以根据用例处理几十甚至数十万个设备，集群可以处理数百万台设备。
* 高灵活：开发新功能可以方便的使用自定义部件、规则引擎等。
* 持久化：数据永久保存

了解更多知识请参见 [**ThingsBoard 架构**](http://www.ithingsboard.com/docs/reference) 。

**编程语言和第三方**
ThingsBoard 后端是用 Java 编写的但是我们也有一些基于 Node.js 的微服务。
ThingsBoard 前端是基于 Angular JS 框架的 SPA。
有关使用的第三方组件的更多详细信息请参见[整体](http://www.ithingsboard.com/docs/reference/monolithic)和[微服务](http://www.ithingsboard.com/docs/reference/monolithic)页面。

**协议**
 [Apache 2.0 License](https://github.com/thingsboard/thingsboard/blob/master/LICENSE).

## 安装教程

### 部署 thingsboard（win + docker 组合）

官网
<https://github.com/thingsboard/>

我们需要使用存储卷的方式来进行数据持久化。 创建二个存储卷，一个存数据，一个存日志。

```sh
docker volume create mytb-data
docker volume create mytb-logs
```

接下来可直接运行docker：

docker run -p 8080:9090 -p 1883:1883 thingsboard/tb-postgres

```sh
docker run -it ^
-p 8080:9090 ^
-p 1883:1883 ^
-p 5683:5683/udp ^
--name mytb ^
--restart always ^
thingsboard/tb-postgres
```

启动容器

```sh
docker start mytb
```

查看日志

```sh
docker logs -f mytb
```

### 安装后说明信息

票据说明：

* 系统管理员: sysadmin@thingsboard.org / sysadmin
* 租户管理员: tenant@thingsboard.org / tenant
* 客户: customer@thingsboard.org / customer

端口说明：
8080:9090 - 将本地端口 8080 转发至 HTTP 端口 9090
1883:1883 - 将本地端口 1883 转发至 MQTT 端口 1883
5683:5683 - 将本地端口 5683 转发至 MQTT 端口 5683

ThingsBoard | 首页
<http://localhost:8080/>

Swagger UI
<http://localhost:8080/swagger-ui/>
- - -

## 开始使用

方式 1：*http 上传*
从页面中拷贝 访问 ACCESS_TOKEN  令牌 FgzAOYWnxXP5Qy2Lt3wT 了。

```js
curl -v -X POST \
--header "Content-Type:application/json" \
-d "{\"temperature\": 25}" \
http://localhost:8080/api/v1/FgzAOYWnxXP5Qy2Lt3wT/telemetry
```

方式 2：*mqtt 上传*

> 前提：准备好 telemetry-data-as-object.json 文件

```json
{
  "temperature": 55
}
```

之后在终端下输入以下内容

```sh
cat telemetry-data-as-object.json \
| mqtt pub -h "localhost" \
-t "v1/devices/me/telemetry" \
-u 'FgzAOYWnxXP5Qy2Lt3wT' \
-s
```

发现会报错，查看 issues 得知 <https://github.com/mqttjs/MQTT.js/issues/821>，所以还得加一个任意内容的虚拟消息。

或者直接一条命令搞定

```sh
mqtt pub -v -h "127.0.0.1" \
-t "v1/devices/me/telemetry" \
-u 'FgzAOYWnxXP5Qy2Lt3wT' \
-m '{"temperature": 30}'
```

方式 3：coap 上传

在准备好 telemetry-data-as-object.json 文件后执行命令

```sh
cat telemetry-data-as-object.json \
| coap post coap://localhost/api/v1/FgzAOYWnxXP5Qy2Lt3wT/telemetry
```

**获取 token**

```sh
curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
-d '{"username":"tenant@thingsboard.org", "password":"tenant"}' \
'http://127.0.0.1:8080/api/auth/login'
```

注意：这里必须要用租户权限的账号 tenant。

返回结果

```json
{
    "token":"eyJhbGciOiJIUbjE2NDgyMDQ0Mzl9.v6b2z-vE23JMJ4npYBKazX1Iip9UMS9y2-ug",
    "refreshToken":"eyJhbGcnIiwic2NvI6M.HVE7kaWHr_oJ_gvHcOEMZw9Yhtl32hhDtDJAk-Q"
}
```

## 参考资料

thingsboard/thingsboard: Open-source IoT Platform - Device management, data collection, processing and visualization.
<https://github.com/thingsboard/thingsboard>

ThingsBoard: ThingsBoard 是一个开源的物联网平台，用于数据收集、处理、可视化展示以及设备管理
<https://gitee.com/mirrors/ThingsBoard>

物联网技术指南-ThingsBoard
<https://iot.mushuwei.cn/#/thingsboard/>

【需付费】ThingsBoard 教程二开_拿我格子衫来的博客-CSDN博客
<https://blog.csdn.net/github_35631540/category_11377483.html>

ThingBoard教程（一）：ThingBoard介绍及安装_专栏_易百纳技术社区
<https://www.ebaina.com/articles/140000005511>
