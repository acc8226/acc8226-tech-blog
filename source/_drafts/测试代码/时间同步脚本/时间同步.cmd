@echo off

setlocal enabledelayedexpansion

:: 定义日志文件路径为批处理文件所在的目录
set LOG_FILE=%~dp0时间同步日志.txt

:: 定义调试开关，true 则生成日志用于调试，false 则不生成
set DEBUG=true

:: 将DEBUG变量值转换为小写
set DEBUG=%DEBUG:~0,1%%DEBUG:~1,1%%DEBUG:~2,1%%DEBUG:~3,1%%DEBUG:~4,1%

:: 获取当前时间
set datetime=%date% %time%

:: 记录开始同步时间信息
echo [%datetime%] 开始同步时间...
if /i "%DEBUG%"=="true" (
    echo [%datetime%] 开始同步时间...>> "%LOG_FILE%"
)

:: 设置要同步时间的服务器
set TIME_SERVER=ntp.aliyun.com

:: 检查 Windows 时间服务状态。tokens 可能取 3 或者 4，这里我取 4
for /f "tokens=4" %%a in ('sc query w32time ^| findstr "STATE"') do set service_state=%%a
echo service_state=%service_state%

:: 根据服务状态决定是否需要启动服务
if /i "%service_state%"=="STOPPED" (
    echo [%datetime%] Windows 时间服务未运行，正在启动...
    net start w32time >nul 2>&1
    echo errorlevel=%errorlevel%
    if %errorlevel% neq 0 (
        echo [%datetime%] 启动 Windows 时间服务失败！
        if /i "%DEBUG%"=="true" (
            echo [%datetime%] 启动 Windows 时间服务失败！>> "%LOG_FILE%"
        )
        echo [%datetime%] 程序将在 3 秒后自动退出...
        timeout /t 3 >nul
        exit /b
    )
) else (
    echo [%datetime%] Windows 时间服务已运行，无需启动。
)

:: 配置时间服务器
echo [%datetime%] 配置时间服务器...
w32tm /config /manualpeerlist:%TIME_SERVER% /syncfromflags:manual /reliable:yes /update >nul 2>&1
echo errorlevel=%errorlevel%
if %errorlevel% neq 0 (
    echo [%datetime%] 配置时间服务器失败，请检查是否以管理员权限运行，以及服务器地址是否有效！
    if /i "%DEBUG%"=="true" (
        echo [%datetime%] 配置时间服务器失败，请检查是否以管理员权限运行，以及服务器地址是否有效！>> "%LOG_FILE%"
    )
    echo [%datetime%] 程序将在 3 秒后自动退出...
    timeout /t 3 >nul
    exit /b
)

:: 强制同步时间
echo [%datetime%] 强制同步时间...
w32tm /resync /force >nul 2>&1
if %errorlevel% neq 0 (
    echo [%datetime%] 时间同步失败，请检查网络连接或时间服务器地址！
    if /i "%DEBUG%"=="true" (
        echo [%datetime%] 时间同步失败，请检查网络连接或时间服务器地址！>> "%LOG_FILE%"
    )
    echo [%datetime%] 程序将在 3 秒后自动退出...
    timeout /t 3 >nul
    exit /b
)

:: 再次获取当前时间以确保同步后的时间被记录
set datetime=%date% %time%

:: 记录时间同步成功信息
echo [%datetime%] 时间同步成功！
if /i "%DEBUG%"=="true" (
    echo [%datetime%] 时间同步成功！>> "%LOG_FILE%"
)

:: 程序将在 3 秒后自动退出
:: echo [%datetime%] 程序将在 3 秒后自动退出...
:: timeout /t 3 >nul
