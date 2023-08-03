---
title: PowerShell 脚本简介
date: 2022-04-05 14:41:50
updated: 2022-11-05 09:48:00
categories: 脚本文件
tags:
- PowerShell
---

## 什么是 PowerShell

PowerShell 是一种跨平台的任务自动化解决方案，由命令行 shell、脚本语言和配置管理框架组成。 PowerShell 目前已经支持在 Windows、Linux 和 macOS 上运行。

## mac 安装 PowerShell

PowerShell 7.3.4
x64 processors - powershell-7.3.4-osx-x64.pkg
<https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell-7.3.4-osx-x64.pkg>

M1 processors - powershell-7.3.4-osx-arm64.pkg
<https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell-7.3.4-osx-arm64.pkg>

## 示例

要确定当前目录位置的路径，请输入命令 Get-Location

设置您的当前位置（设置位置），请使用 Set-Location（cd 或者 chdir 或者 sl）

```ps1
Set-Location -Path C:\Windows
```

保存和调用最近的位置（Push-Location 和 Pop-Location）。当改变地点时，记录你去过的地方并能够返回是很有帮助的 你之前的位置 PowerShell 中的 Push-Location cmdlet 创建有序的历史记录（“stack”）的目录路径，您可以通过目录路径。

枚举文件、文件夹和注册表项

如果要返回直接包含在文件夹中的所有文件和文件夹 C:\Windows，请输入

```powershell
PS> Get-ChildItem -Path C:\Windows
```

-Force 参数用于显示隐藏项或系统项

```powershell
Get-ChildItem -Path C:\ -Force
```

要显示子文件夹中的项目，需要指定 -Recurse 参数

```powershell
PS> Get-ChildItem -Path C:\WINDOWS -Recurse
```

要仅显示项目的名称，请使用 Get-Childitem 的 Name 参数：

```powershell
PS> Get-ChildItem -Path C:\WINDOWS -Name
```

Get-ChildItem 命令在要列出的项的路径中接受通配符。
由于通配符匹配是由 PowerShell 引擎处理的，因此所有接受通配符的 cmdlet 使用相同的符号并具有相同的匹配行为。PowerShell 通配符表示法。

要查找 Windows 目录中以字母 x 开始的所有文件，请键入以下内容：

Get-ChildItem -Path C:\Windows\x*

要查找名称以 “x” 或 “z” 开始的所有文件，请键入：

Get-ChildItem -Path C:\Windows\[xz]*

复制文件和文件夹

```powershell
Copy-Item -Path C:\boot.ini -Destination C:\boot.bak
```

如果目标文件已存在，复制尝试将失败。覆盖预先存在的 目的地，使用 Force 参数：

```powershell
Copy-Item -Path C:\boot.ini -Destination C:\boot.bak -Force
```

文件夹复制的工作方式相同。此命令将文件夹 C:\temp\test1 复制到新文件夹 C:\temp\DeleteMe ：

```powershell
Copy-Item C:\temp\test1 -Recurse C:\temp\DeleteMe
```

创建文件和文件夹

此命令将创建一个新文件夹 C:\temp\New Folder：

```powershell
New-Item -Path 'C:\temp\New Folder' -ItemType Directory
```

此命令创建一个新的空文件 C:\temp\New Folder\file.txt

New-Item -Path 'C:\temp\New Folder\file.txt' -ItemType File

注意：使用 Force选项 和 New-Item命令创建文件夹时，文件夹若已存在，则不会覆盖或替换该文件夹。它将简单地返回现有的文件夹对象。但是，如果您对已经存在的文件使用 New-Item -Force，则该文件 被覆盖。

删除文件夹中的所有文件和文件夹

您可以使用 Remove-Item 删除包含的项，但系统将提示您确认 如果该项目包含任何其他内容。例如，如果您试图删除文件夹 C:\temp\DeleteMe 包含其他项，PowerShell提示您确认 删除文件夹：

Remove-Item -Path C:\temp\DeleteMe

如果您不希望每个包含的项都被提示，请指定Recurse参数：

Remove-Item -Path C:\temp\DeleteMe -Recurse

将文本文件读入数组
文本数据的一种更常见的存储格式是在文件中，单独的行被视为 不同的数据元素。Get-Content cmdlet可用于在一个步骤中读取整个文件

PS> Get-Content -Path C:\boot.ini

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

### 设置环境变量

追加当前进程的变量

```powershell
PS> $env:Path+=";C:PowerShellmyscript"
```

```powershell
PS> [environment]::SetEnvironmentvariable("Path", ";c:\powershellscript", "User")
PS> [environment]::GetEnvironmentvariable("Path", "User")
;c:\powershellscript
```

## 美化

Home | Oh My Posh
<https://ohmyposh.dev/>

## 参考

PowerShell 中文博客 – 收集和分享 Windows PowerShell 相关教程, 技术和最新动态
<https://www.pstips.net/>
