## 先决条件

Windows Subsystem for Android 可用于 Windows 11 上的公共预览版。

你的设备必须满足以下特定要求：[设备要求](https://support.microsoft.com/windows/f8d0abb5-44ad-47d8-b9fb-ad6b1459ff6c)。

目前已知可运行在 Intel、AMD 和 Qualcomm 平台且符合条件的设备上。

>  备注
> Windows 上的 Amazon Appstore 目前仅在美国提供 - 需要使用此软件才能在 Windows 11 上运行 Android 应用。简而言之，设置-时间和语言-语言和区域-国家或地区请选择美国。

## 安装 Android 子系统

有两种方式可以安装 Android 子系统：

打开 Microsoft Store 应用程序并搜索 Amazon Appstore。选择 获取 并安装它。在安装过程中，适用于 Android 的 Windows 子系统将安装在您的 PC 上。

在 Microsoft Store 上搜索移动应用。Amazon Appstore 和适用于 Android 的 Windows 子系统将在安装移动应用程序之前安装。

## Windows Subsystem for Android™️“设置”应用

要访问适用于 Android 的 Windows 子系统“设置”应用，请转到：“开始”>“所有应用”>“适用于 Android 的 Windows 子系统™️ 设置”**>>**。 了解有关特定设置应用功能的详细信息：[管理 Windows 移动应用的设置](https://support.microsoft.com/windows/000f97e8-8c20-490e-9ef4-cd90d903f847)。

## 窗口管理和调整大小

与传统的移动设备外形规格不同，在 Windows 11 上运行的 Android 应用可以自由调整大小，在调整大小时应该响应迅速，并且可以使用 Windows 操作/手势进行贴靠。

## 测试和调试

要使用适用于 Android 的 Windows 子系统在 Windows 11 设备上测试和调试应用，需要执行以下设置步骤。

### [](https://docs.microsoft.com/zh-cn/windows/android/wsa/#enable-developer-mode-in-windows-settings)在 Windows“设置”中启用开发人员模式

必须首先在 Windows“设置”中启用开发人员模式。 可通过以下三种方式开启开发人员模式：

*   打开[适用于 Android 的 Windows 子系统“设置”应用](https://docs.microsoft.com/zh-cn/windows/android/wsa/#windows-subsystem-for-android-settings-app)。 打开后，启用“开发人员模式”。
*   在 Windows 搜索中搜索“开发人员设置”。
*   导航到“设置”>“隐私和安全”>“面向开发人员”>“开发人员模式”。

### 连接到适用于 Android 的 Windows 子系统进行调试

**连接到适用于 Android 的 Windows 子系统**
1. 打开适用于 Android 的 Windows 子系统的“设置”应用，获取 IP 地址。 （使用 Windows 搜索来选择和启动。）
2. IP 地址将显示在 IP 地址部分下。 如果没有显示 IP 地址，请启动使用 Amazon Appstore 安装的 Android 应用，然后在“设置”应用的 IP 地址按钮上选择“刷新”。
3. 现在，你已有了用于连接到适用于 Android 的 Windows 子系统 VM 的 IP 地址，在终端或 Powershell 中，接下来可使用 adb connect（必须[安装 adb](https://developer.android.com/studio/command-line/adb)）进行连接。

**下载适用于操作系统对应 的 SDK Platform-Tools（包含了 adb）**
* https://dl.google.com/android/repository/platform-tools-latest-windows.zip
* https://dl.google.com/android/repository/platform-tools-latest-linux.zip
* https://dl.google.com/android/repository/platform-tools-latest-darwin.zip

**查询设备**
在发出 adb 命令之前，了解哪些设备实例已连接到 adb 服务器会很有帮助。您可以使用 devices 命令生成已连接设备的列表。

```
adb devices
```

**安装应用**
您可以使用 adb 的 install 命令在模拟器或连接的设备上安装 APK：
```
adb install path_to_apk
```

**APK 资源去哪找**
我一般去[应用宝](
https://webcdn.m.qq.com/webapp/homepage/index.html#/) 搜索下载并 adb install 安装到本地。

## 参考文档

Android 调试桥 (adb)  |  Android 开发者  |  Android Developers
https://developer.android.google.cn/studio/command-line/adb
