---
title: 什么是 IMAP
date: 2024-08-14 19:38:20
updated: 2024-08-14 19:38:20
categories:
  - 应用
  - 服务器
---

POP3、IMAP 和 SMTP 是电子邮件系统中使用的三个不同的协议，它们各自有不同的用途：

SMTP（Simple Mail Transfer Protocol）：
用途：用于发送电子邮件。
特点：当你使用电子邮件客户端（如Outlook、Thunderbird等）发送邮件时，SMTP协议负责将邮件从你的计算机发送到邮件服务器，然后邮件服务器再将邮件发送到收件人的邮箱。

POP3（Post Office Protocol version 3）：
用途：用于从邮件服务器接收电子邮件。
特点：当你使用电子邮件客户端接收邮件时，POP3协议会将邮件从服务器下载到你的本地设备。一旦邮件被下载，它们通常会从服务器上删除，这意味着这些邮件将只存在于你的本地设备上。

<!-- more -->

IMAP（Internet Message Access Protocol）：
用途：用于从邮件服务器接收电子邮件。
特点：与 POP3 不同，IMAP 协议允许你在不同的设备上访问同一组邮件。邮件存储在服务器上，你可以通过任何设备访问它们，并且对邮件的任何操作（如移动、标记为已读等）都会同步到所有设备。

选择哪个协议取决于你的具体需求：

如果你希望在多个设备上同步邮件，并且希望邮件始终存储在服务器上，那么 IMAP 是更好的选择。
如果你只需要从邮件服务器下载邮件到一个设备，并且不需要在其他设备上访问这些邮件，那么 POP3 可能更适合你。
如果你需要发送邮件，那么你需要使用 SMTP。
通常，现代的电子邮件客户端会同时支持 IMAP 和 SMTP，以便用户可以根据需要选择。如果你使用的是网页邮件服务（如Gmail、Outlook.com等），它们通常会默认使用 IMAP 来同步邮件，并使用 SMTP 来发送邮件。

## 文章来源

[什么是 IMAP？ IMAP 与 POP3 | Cloudflare](https://www.cloudflare-cn.com/learning/email-security/what-is-imap/)
