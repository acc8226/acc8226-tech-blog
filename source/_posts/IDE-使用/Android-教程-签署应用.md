---
title: Android-教程-签署应用
categories: IDE-使用
---

## 调试证书的有效期

用于针对调试签署 APK 的自签署证书的有效期为 **365** 天，从其创建日期算起。当此证书到期时，您将收到一个构建错误。要修复此问题，只需除 `debug.keystore` 文件即可。文件存储在以下位置：

* `~/.android/`（OS X 和 Linux）
* `C:\Documents and Settings\<user>\.android\` (Windows XP)
* `C:\Users\<user>\.android\`（Windows Vista，Windows 7、8 和 10）

当您下次构建和运行调试构建类型时，这些构建工具将重新生成新的密钥库和调试密钥。请注意，您必须运行应用，单纯的构建不会重新生成密钥库和调试密钥

## 字段说明

创建 key (密钥库是一个二进制文件，它包含一组私钥。您必须将密钥库存放在安全可靠的地方。)
password: `stcy123456`
创建私钥代表将通过应用识别的实体，如某个人或某家公司。
key alias: `badrobot`
key password: `stcy123456`
