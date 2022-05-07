# 网关目录结构说明

分别为 配置文件 config，拓展支持文件 extensions 和空日志文件夹（日志生成后会自动进行填充） logs。

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

## 仅供参考

Linux 使用安装包安装后的参考目录结构

* /etc/thingsboard-gateway/config  - Configuration folder.
* /var/lib/thingsboard_gateway/extensions - Folder for custom connectors/converters.
* /var/log/thingsboard-gateway    - Logs folder
