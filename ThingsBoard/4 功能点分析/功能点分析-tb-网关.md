## ThingsBoard 网关

The IoT Gateway 是一个基于 Linux 的支持 **Python 3.7+** 的微机上运行的软件组件。

为了将您的物联网网关连接到 ThingsBoard 服务器，您需要首先提供网关凭据。我们将使用访问令牌凭证作为最简单的凭证。有关详细信息，请参阅设备身份验证选项。

## 网关架构

对平台来说网关是一个设备：只不过网关的消息体和其他设备不一样，网关监听的是消息代理发送的消息。针对 MQTT 来说，网关只不过选择性监听了 topic，构建了一个映射 map 关系。

![网关架构](./功能点分析-tb-网关/网关架构.png)

## 网关安装

### 方案一：Ubuntu 系统通过源代码方式安装

从源代码安装 ThingsBoard 网关您应遵循以下步骤：

**1\. 使用 apt 将所需的库安装到系统中：**

```sh
sudo apt install python3-dev python3-pip libglib2.0-dev git
```

**2\. 克隆指定版本的网关源代码：**

```sh
git clone -b 3.0.1 --depth 1 git@github.com:thingsboard/thingsboard-gateway.git
```

或者

```sh
curl -LJO https://github.com/thingsboard/thingsboard-gateway/archive/refs/tags/3.0.1.tar.gz
```

**3\. 进入 thingsboard-gateway 目录：**

```sh
cd thingsboard-gateway
```

**4\. 进入项目根目录，使用 setup.py 脚本安装 python 模块：**

```sh
python3 setup.py install
```

**5\. 创建“日志”文件夹：**

```sh
mkdir logs
```

**6\. 将网关配置为与您的 ThingsBoard 平台实例一起使用**
这一步需要自行配置 connector 连接器。

**7\. 运行网关，检查安装结果：**

```sh
python3 ./thingsboard_gateway/tb_gateway.py
```

**期间遇到问题**
运行报错 AttributeError: module 'google.protobuf.descriptor' has no attribute '_internal_create_key'

解决方案：尝试升级 protobuf 包`pip install --upgrade protobuf`

### 方案二：通过 docker 安装网关

Linux or Mac 用户:

```sh
docker run -it \
-v ~/.tb_gateway/logs:/thingsboard_gateway/logs \
-v ~/.tb_gateway/extensions:/thingsboard_gateway/extensions \
-v ~/.tb_gateway/config:/thingsboard_gateway/config \
--name tb-gateway \
--restart always \
thingsboard/tb-gateway
```

Windows 用户:

```bat
docker run -it ^
-v %HOMEPATH%/tb_gateway/config:/thingsboard_gateway/config ^
-v %HOMEPATH%/tb_gateway/extensions:/thingsboard_gateway/extensions ^
-v %HOMEPATH%/tb_gateway/logs:/thingsboard_gateway/logs --name tb-gateway ^
--restart always ^
thingsboard/tb-gateway
```

目录结构说明：

* 配置文件 config
* 日志文件 logs
* 拓展支持文件 extensions。

### 方案三：通过 Linux 安装包的方式进行安装

等待二次开发后再进行验证。

## mqtt broker 选型

为了搭配 mqtt Connector 使用，需要提前安装 mqtt broker.

### 供测试用的 hivemq

使用 docker 进行部署 hivemq：

```sh
docker run \
-p 1599:1883 \
-p 8087:8080 \
hivemq/hivemq4
```

hivemq 的 web 控制台，地址为 <http://localhost:8087>。登录用户名为 admin，密码为 hivemq。

### 供生产用的 EMQX 开源版

获取镜像

```sh
docker pull emqx/emqx:4.4.3
```

启动容器

```sh
docker run -d --name emqx \
-p 1889:1883 \
-p 8081:8081 \
-p 8083:8083 \
-p 8084:8084 \
-p 8883:8883 \
-p 18083:18083 emqx/emqx:4.4.3
```

* EMQX 的 MQTT/TCP 监听端口由默认的 1883
* EMQX 的 HTTP API 服务 http:management 默认监听 8081 端口
* MQTT/WS 监听器的监听地址 mqtt:ws:8083
* mqtt:wss:8084
* MQTT TLS 的默认 mqtt:ssl 端口是 8883
* 当 EMQX 成功运行在你的本地计算机上且 EMQX Dashboard 被默认启用时，你可以访问 <http://localhost:18083> 来查看你的 Dashboard，默认用户名是 admin，密码是 public。

## 配置指南

### 目录结构说明

分别为 config, logs 和 extensions 三大块的内容。

```text
/etc/thingsboard-gateway/config  - Configuration folder.
    tb_gateway.yaml              - Main configuration file for Gateway.
    logs.conf                    - Configuration file for logging.
    modbus.json                  - Modbus connector configuration.
    mqtt.json                    - MQTT connector configuration.
    ble.json                     - BLE connector configuration.
    opcua.json                   - OPC-UA connector configuration.
    request.json                 - Request connector configuration.
    can.json                     - CAN connector configuration. 
    ... 

/var/lib/thingsboard_gateway/extensions - Folder for custom connectors/converters.                      
    modbus                              - Folder for Modbus custom connectors/converters.
    mqtt                                - Folder for MQTT custom connectors/converters.
        __init__.py                     - Default python package file, needed for correct imports.
        custom_uplink_mqtt_converter.py - Custom Mqtt converter example.
    ...
    opcua   - Folder for OPC-UA custom connectors/converters.
    ble     - Folder for BLE custom connectors/converters.
    request - Folder for Request custom connectors/converters.
    can     - Folder for CAN custom connectors/converters.

/var/log/thingsboard-gateway    - Logs folder
    connector.log               - Connector logs.
    service.log                 - Main gateway service logs.
    storage.log                 - Storage logs.
    tb_connection.log           - Logs for connection to the ThingsBoard instance.
```

### config/tb_gateway.yml 配置

#### 通用配置

由于要映射到 docker 容器中。
host 是 thingsboard 的 ip 地址，port 是 thingsboard 的 MQTT 的 port 端口。所以在宿主机中配置 host 为 host.docker.internal。
port 是 thingsboard 的 MQTT 的 port 端口。端口为 tb 中正在使用的 1883。
accessToken 是网关的口令，拷贝设备网关的 token 即可。

#### MQTT Connector 配置

这里我只启用 mqtt 选项。

```yml
thingsboard:
  host: host.docker.internal
  port: 1883
  remoteShell: false
  remoteConfiguration: false
  statsSendPeriodInSeconds: 3600
  minPackSendDelayMS: 0
  checkConnectorsConfigurationInSeconds: 60
  security:
    accessToken: Q90dlbds3BOhSnvMI7gq
  qos: 1
storage:
  type: memory
  read_records_count: 100
  max_records_count: 100000
#  type: file
#  data_folder_path: ./data/
#  max_file_count: 10
#  max_read_records_count: 10
#  max_records_per_file: 10000
#  type: sqlite
#  data_file_path: ./data/data.db
#  messages_ttl_check_in_hours: 1
#  messages_ttl_in_days: 7
grpc:
  enabled: false
  serverPort: 9595
  keepaliveTimeMs: 10000
  keepaliveTimeoutMs: 5000
  keepalivePermitWithoutCalls: true
  maxPingsWithoutData: 0
  minTimeBetweenPingsMs: 10000
  minPingIntervalWithoutDataMs: 5000
connectors:
  -
    name: MQTT Broker Connector
    type: mqtt
    configuration: mqtt.json
```

下一步配置 mqtt 远程信息，前提是已安装 mqtt broker。

配置 gateway 中的 mqtt.json

```json
{
  "broker": {
    "name": "Default Local Broker",
    "host": "host.docker.internal",
    "port": 1599,
    "clientId": "ThingsBoard_gateway",
    "maxMessageNumberPerWorker": 10,
    "maxNumberOfWorkers": 100,
    "security": {      
      "type": "anonymous"
    }
  },
  "mapping": [
    {
      "topicFilter": "/sensor/data",
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "${serialNumber}",
        "deviceTypeJsonExpression": "${sensorType}",
        "timeout": 60000,
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "${sensorModel}"
          },
          {
            "type": "string",
            "key": "${sensorModel}",
            "value": "on"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          },
          {
            "type": "string",
            "key": "combine",
            "value": "${hum}:${temp}"
          }
        ]
      }
    },
    {
      "topicFilter": "/sensor/+/data",
      "converter": {
        "type": "json",
        "deviceNameTopicExpression": "(?<=sensor\/)(.*?)(?=\/data)",
        "deviceTypeTopicExpression": "Thermometer",
        "timeout": 60000,
        "attributes": [
          {
            "type": "string",
            "key": "model",
            "value": "${sensorModel}"
          }
        ],
        "timeseries": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          }
        ]
      }
    },
    {
      "topicFilter": "/custom/sensors/+",
      "converter": {
        "type": "custom",
        "extension": "CustomMqttUplinkConverter",
        "extension-config": {
          "temperatureBytes": 2,
          "humidityBytes": 2,
          "batteryLevelBytes": 1
        }
      }
    }
  ],
  "connectRequests": [
    {
      "topicFilter": "sensor/connect",
      "deviceNameJsonExpression": "${SerialNumber}"
    },
    {
      "topicFilter": "sensor/+/connect",
      "deviceNameTopicExpression": "(?<=sensor\/)(.*?)(?=\/connect)"
    }
  ],
  "disconnectRequests": [
    {
      "topicFilter": "sensor/disconnect",
      "deviceNameJsonExpression": "${SerialNumber}"
    },
    {
      "topicFilter": "sensor/+/disconnect",
      "deviceNameTopicExpression": "(?<=sensor\/)(.*?)(?=\/disconnect)"
    }
  ],
  "attributeRequests": [
    {
      "retain": false,
      "topicFilter": "v1/devices/me/attributes/request",
      "deviceNameTopicExpression": "${SerialNumber}",
      "attributeNameJsonExpression": "${sensorModel}"
    }
  ],
  "attributeUpdates": [
    {
      "retain": true,
      "deviceNameFilter": "SmartMeter.*",
      "attributeFilter": "uploadFrequency",
      "topicExpression": "sensor/${deviceName}/${attributeKey}",
      "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
    }
  ],
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestTopicExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "responseTopicExpression": "sensor/${deviceName}/response/${methodName}/${requestId}",
      "responseTimeout": 10000,
      "valueExpression": "${params}"
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestTopicExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "valueExpression": "${params}"
    }
  ]
}
```

这里面最主要的是 broker 这段。host 就是 hivemq 的ip 地址，port 是 hivemq 的 port 端口。security 是默认的安全配置，官网推荐的是 basic。

### config/mqtt.json 配置

deviceNameJsonExpression 设备名称
deviceTypeJsonExpression 设备类型，作为 Device profile

#### connectRequests 说明

ThingsBoard 允许向设备发送关于设备属性更新的 RPC 命令和通知。但是为了发送它们，平台需要知道目标设备是否连接，以及目前使用哪个网关或会话连接设备。
如果你的设备不断地发送遥测数据，那么 ThingsBoard 已经知道如何推送通知。
如果您的设备刚刚连接到 MQTT 代理并等待 commands/updates，则需要向 Gateway 发送消息并通知设备已连接到代理。

举例

```sh
mosquitto_pub \
-h YOUR_MQTT_BROKER_HOST \
-p YOUR_MQTT_BROKER_PORT \
-t "sensors/connect" -m '{"serialNumber":"SN-001"}'
```

或

```sh
mosquitto_pub \
-h YOUR_MQTT_BROKER_HOST \
-p YOUR_MQTT_BROKER_PORT \
-t "sensor/SN-001/connect" -m ''
```

#### disconnectRequest 说明

此配置部分是可选的。 本节提供的配置将用于从代理获取有关断开设备的信息。 如果您的设备仅与MQTT代理断开连接并等待commands/updates，则需要向网关发送消息，并通知设备已与代理断开连接。

```sh
mosquitto_pub -h YOUR_MQTT_BROKER_HOST \
-p YOUR_MQTT_BROKER_PORT \
-t "sensors/disconnect" -m '{"serialNumber":"SN-001"}'

mosquitto_pub -h YOUR_MQTT_BROKER_HOST \
-p YOUR_MQTT_BROKER_PORT \
-t "sensor/SN-001/disconnect" -m '
```

#### attributeUpdates 说明

此配置部分是可选的。 ThingsBoard允许供应设备属性，并从设备应用程序中获取其中的一些属性。 您可以将此视为设备的远程配置。您的设备能够从 ThingsBoard 请求共享属性。 有关更多详细信息，请参见用户指南。

attributeRequests 配置允许配置相应的属性请求和响应消息的格式。

```text
"retain": true, 默认为 false，如果设置为 true，该消息将被设置为主题的“last known good”/保留消息
"deviceNameFilter": "SmartMeter.*", 正则表达式设备名称筛选器，用于确定要执行哪个函数。
"attributeFilter": "uploadFrequency", 正则表达式属性名筛选器，用于确定要执行哪个函数。
"topicExpression": "sensor/${deviceName}/${attributeKey}", JSON-path 表达式用于创建用于发送消息的主题地址。
"valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}" JSON-path 表达式用于创建将发送到主题的消息数据。
```

我们通过 mqtt.js 进行客户端请求发送。

如果不出意外，我们将发现网关已将我们配置的设备信息已经显示到 thingsboard 中去了。

## 模拟实现具体应用场景

## 故障排除

ThingsBoard 日志存储在以下目录中:
**/var/log/thingsboard**

你可以发出以下命令以检查后端是否有任何错误:

```sh
cat /var/log/thingsboard/thingsboard.log | grep ERROR
```

## 网关产品特点

### 记录远程日志

#### 激活日志功能和设置日志记录级别

![add-shared-attributes-gateway](./功能点分析-tb-网关/add-shared-attributes-gateway.png)

在添加共享属性窗口中，
The name field 必须选择 RemoteLoggingLevel
The value field 用于设置日志打印级别, 可选值如下:

```text
 DEBUG
 INFO
 WARNING
 ERROR
 CRITICAL
 NONE
```

![add-remote-logging-level-attribute-1](./功能点分析-tb-网关/add-remote-logging-level-attribute-1.png)

打开网关设备的 Latest telemetry 标签页，你将看见新添加的 telemetry key – LOGS。

#### 在 dashboard 中显示日志

1\. Check LOGS key and click “Show on widget” button:
![show-logs-on-widget](./功能点分析-tb-网关/show-logs-on-widget.png)

2\. We will use the default Cards widget:
![add-logs-to-dashboard](./功能点分析-tb-网关/add-logs-to-dashboard.png)

3\. Choose Timeseries table Card widget and add it to the Dashboard. It can be either the new one or the existing dashboard.
![create-new-dashboard-for-logs](./功能点分析-tb-网关/create-new-dashboard-for-logs.png)

### 服务端 RPC

创建 dashboard

To use the debug terminal we have to add RPC debug terminal widget from Control widget bundle.
To do this we use following steps:

1. Open Dashboards tab;
2. Add a new dashboard;
3. Open created dashboard, enter edit mode by clicking pencil button in the bottom right corner and click “Add new widget” button;
4. Select widget bundle - “Control widgets”;
5. Scroll down and select RPC debug terminal widget;
6. We haven’t specify the entity type for the widget so we will create a new one;
7. Fill in required fields and same the entity. Gateway - is our gateway device;
8. Apply all changes;
9. The connected widget looks like (Connection setups automatically).
Now you can use Debug Terminal to send RPC requests to the gateway.

**Gateway RPC methods**
To send RPC requests to the gateway the one should use RPC Debug Terminal from Control widgets bundle.
ThingsBoard IoT gateway has several RPC methods, which called from WEB UI, available by default.
The list of OOTB methods will be extended within upcoming releases.

gateway_ping RPC method

gateway_ping RPC method is used to check connection to the gateway and RPC processing status. Every command with prefix “gateway_” will be interpreted as a command to general gateway service and not as an RPC request to the connector or device.

Command:

```text
gateway_ping
```

Gateway RPC ping method
gateway_devices RPC method
gateway_devices RPC method is used to list devices connected through the gateway with info about the type of connector used. This method returns object in “resp” with key-value parameters, where: key — is a device name value — identifies the connector

Command:

```text
gateway_devices
```

Gateway RPC devices method

gateway_restart RPC method
gateway_restart RPC method is used to schedule restart action, e.g. bash gateway_restart 60 set up the restart of the gateway service in 60 seconds. This method uses seconds as measuring unit.
Note: The response will be returned after adding the task to the gateway scheduler.

Command:

```text
gateway_restart 60
```

gateway_reboot RPC method
gateway_reboot RPC method is used to schedule rebooting of the gateway device (hardware?), e. g. bash gateway_reboot 60 set up the reboot of the gateway device in one minute. Take into account: this method available if you start the gateway service as a python module instead of daemon approach and the user that is running the gateway has reboot permissions.

Command:

```text
gateway_reboot 60
```

### 激活远程 shell

1\. you should add or change parameter remoteShell to true in the section thingsboard in the general configuration file (tb_gateway.yaml);

![charhe-remote-shell-parameter](./功能点分析-tb-网关/charhe-remote-shell-parameter.png)

> 警告: 此功能可能会导致您的设备的安全问题，我们强烈建议只使用 ssl 加密，如果您不需要，不启用它。

2\. 创建 dashboard

Select widget bundle - “Control widgets”;
Scroll down and select RPC remote shell widget;
Fill in required fields and same the entity. Gateway - is our gateway device;
Now you can use the shell to control device with the gateway. For example we run ls command to get the list of files and directories in the current directory.

![remote-shell-10](./功能点分析-tb-网关/remote-shell-10.png)

### 设备重命名/移除处理

设备重命名方案

网关使用设备实体名称来报告来自连接设备的遥测信息。如果实体名称在 ThingsBoard UI 上更改，则最终用户可能会遇到使用旧名称重新配置设备实体(通过网关)的情况。关于重命名的到网关通知不再是这种情况。

设备删除场景

在 ThingsBoard UI 上删除设备实体会导致数据丢失，因为网关本身不能也不能正确地解决擦除问题。通过向网关发送“已删除”通知，网关代表物理设备启动一个新的连接消息，因此该消息是安全的，不会丢失数据。

网关设备的 RPC 数据示例:

```text
  {
    "method": "gateway_device_renamed",
    "params": {"Old device name": "New device name"}
  }
```

```text
  {
    "method": "gateway_device_deleted",
    "params": "Removed device name"
  }    
```

### 配置 gateway 通过 Configurator

本指南将帮助您使用 Configurator 配置您的 ThingsBoard 物联网网关，特别是如果您使用 deb 包进行安装。

要开始配置网关，你必须启动你的终端和启动配置器使用下面的命令:

```sh
tb-gateway-configurator
```

使用您的选项回答将依次显示的问题(您可以使用输入字段中显示的默认值)。
注意: 默认值取自 /etc/thingsboard-gateway/config/tb _ gateway.yaml，所有通过 CLI 进行的配置都将保存在那里。

最后，你可以使用以下命令启动你的 ThingsBoard IoT gateway:

```sh
thingsboard-gateway
```

## 参考文档

<https://thingsboard.io/docs/iot-gateway/what-is-iot-gateway/>
