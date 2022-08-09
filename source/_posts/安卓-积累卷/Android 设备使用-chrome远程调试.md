---
title: Android-设备使用 chrome 远程调试
date: 2019.05.11 15:07:52
categories:
  - 安卓
  - 积累卷
tags:
- android
---

1. 在您的 Android 设备上打开 Developer Options 屏幕。
2. 选择 **Enable USB Debugging**。
3. 在您的开发计算机上打开 Chrome。
4. 打开 chrome://inspect

> 确保启用 Discover USB devices 复选框。
使用 USB 电缆将 Android 设备直接连接到您的开发计算机。 首次连接时，通常会看到 DevTools 检测到未知设备。 如果您 Android 设备的型号名称下显示绿色圆点和 Connected 文本，则表示 DevTools 已与您的设备成功建立连接

![dev tools](http://likai.test.upcdn.net/%E5%AE%89%E5%8D%93-%E7%A7%AF%E7%B4%AF%E5%8D%B7/Android-%E8%AE%BE%E5%A4%87%E4%BD%BF%E7%94%A8-chrome%E8%BF%9C%E7%A8%8B%E8%B0%83%E8%AF%95/dev%20tools.png)

## 远程调试 WebView

使用 Chrome 开发者工具在您的原生 Android 应用中调试 WebView。
在 Android 4.4 (KitKat) 或更高版本中，使用 DevTools 可以在原生 Android 应用中调试 WebView 内容。

* 在您的原生 Android 应用中启用 WebView 调试；在 Chrome DevTools 中调试 WebView。
* 通过 **chrome://inspect** 访问已启用调试的 WebView 列表。
* 调试 WebView 与通过[远程调试](https://developers.google.com/web/tools/chrome-devtools/debug/remote-debugging)调试网页相同。

### 应用中启用 WebView 调试

必须从您的应用中启用 WebView 调试。请在 WebView 类上调用静态方法 [setWebContentsDebuggingEnabled](https://developer.android.com/reference/android/webkit/WebView.html#setWebContentsDebuggingEnabled(boolean))。

```java
if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
    WebView.setWebContentsDebuggingEnabled(true);
}
```

> 此设置适用于应用的所有 WebView。

提示：WebView 调试不会受应用清单中 debuggable 标志的状态的影响。如果您希望仅在 debuggable 为 true 时启用 WebView 调试，请在运行时测试标志。

```java
if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
    if (0 != (getApplicationInfo().flags & ApplicationInfo.FLAG_DEBUGGABLE))
    { WebView.setWebContentsDebuggingEnabled(true); }
}
```

在 DevTools 中打开 WebView
chrome://inspect, 页面将显示您的设备上已启用调试的 WebView 列表。

要开始调试，请点击您想要调试的 WebView 下方的 inspect。像使用远程浏览器标签一样使用 DevTools。

![inspect with chrome](http://likai.test.upcdn.net/%E5%AE%89%E5%8D%93-%E7%A7%AF%E7%B4%AF%E5%8D%B7/Android-%E8%AE%BE%E5%A4%87%E4%BD%BF%E7%94%A8-chrome%E8%BF%9C%E7%A8%8B%E8%B0%83%E8%AF%95/inspect%20with%20chrome.png)

与 WebView 一起列示的灰色图形表示 WebView 的大小和相对于设备屏幕的位置。如果您的 WebView 已设置标题，标题也会一起显示。
