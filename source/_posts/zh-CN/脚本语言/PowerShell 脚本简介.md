---
title: PowerShell 脚本简介
categories: 脚本文件
tags:
- PowerShell
---

## 什么是 PowerShell

PowerShell 是一种跨平台的任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。 PowerShell 在 Windows、Linux 和 macOS 上运行。

## 示例

查询服务名称为 “ssh-agent” 的服务。
Get-Service ssh-agent

查询服务名称为“ssh-agent”的服务，若查询到则启动
Get-Service ssh-agent | Set-Service -StartupType Manual

设置为自启动
Set-Service -Name sshd -StartupType 'Automatic'

输出日志

```powershell
Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
```

启动服务

```powershell
Start-Service sshd
```

安装功能

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

卸载功能

```powershell
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```
