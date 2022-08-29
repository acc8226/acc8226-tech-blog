pm2 start app.js --name="api"
启动应用程序并命名为 "api"

启动应用程序并指定参数并命名，这里用了双引号
pm2 start "node airSensor.js 192.168.18.107 WeatherSensor1" --name weather2

停止所有服务
pm2 stop all

停止指定服务
pm2 stop zhangsan
