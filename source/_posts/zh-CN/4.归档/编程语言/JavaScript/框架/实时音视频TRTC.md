---
title: 实时音视频 TRTC
date: 2026-02-07 11:49:16
updated: 2026-02-07 11:49:16
categories:
  - 框架
  - js
tags:
- js
- 三方库
---

实时音视频（Tencent RTC）基于腾讯多年来在网络与音视频技术上的深度积累，以多人音视频通话和低延时互动直播两大场景化方案，通过腾讯云服务向开发者开放，致力于帮助开发者快速搭建低成本、低延时、高品质的音视频互动解决方案。

音视频引擎（TRTC SDK）
TRTC SDK 提供了丰富的接口，其中大多数用于实现高级功能。比如 TRTC Web SDK 实现屏幕分享功能。 <!-- more -->


Web SDK 对浏览器的支持情况。
实际以 TRTC.isSupported 检测结果为准。您也可以使用 [TRTC 检测页面](https://web.sdk.qcloud.com/trtc/webrtc/demo/detect/index.html) 快速验证浏览器的兼容性。

## 常见问题

**Mac Chrome 在已授权屏幕录制的情况下屏幕分享失败，出现 "NotAllowedError: Permission denied by system" 或者 "NotReadableError: Could not start video source" 错误信息，Chrome bug？**

解决方案：打开【设置】> 点击【安全性与隐私】> 点击【隐私】> 点击【屏幕录制】> 关闭 Chrome 屏幕录制授权 > 重新打开 Chrome 屏幕录制授权 > 关闭 Chrome 浏览器 > 重新打开 Chrome 浏览器。

一般而言，尽量严格控制显示范围。选择对应标签页就行了。选择窗口则表示是该程序的当前窗口（即使切换标签页也会随之移动）。最不建议选择整个桌面。
