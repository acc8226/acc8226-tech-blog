---
title: 配件选购-U 盘
date: 2025-10-23 21:22:20
updated: 2025-10-23 21:22:20
categories: [收藏, 我的硬件]
---

讲究质保，且我支持国产。比如海康。

论加密则 sandisk 有配套软件。但我目前更倾向于国产，更多的且便宜。

<!-- more -->

## 记录

### u 盘格式化为什么格式比较合适

当下采用 exfat 分配默认单元大小即可，这样较为通用。且 mac 也能识别。

### 记录一次 u 盘的起死回生

第一步：使用较新版本的 chipgenius 芯片精灵监测主控信息。特别是厂商和型号信息。

```text
　设备描述: [T:]USB 大容量存储设备(NAND USB2DISK)
　设备类型:　　大容量存储设备

　协议版本: USB 2.00
　当前速度: 高速(HighSpeed)
　电力消耗: 100mA

 USB设备ID: VID = FFFF PID = 1201

设备修订版: 0000

产品制造商: NAND
　产品型号: USB2DISK
产品修订版: 0.00

　主控厂商: FirstChip(一芯)
　主控型号: chipYC2019

　在线资料:　　http://dl.mydigit.net/search/?type=all&q=chipYC2019
```

第二步：根据主控厂商和型号去对应管网下载 U 盘量产工具

[资料下载-深圳三地一芯电子股份有限公司](http://www.szfirstchip.com/col.jsp?id=137)

这里我选择了下载绿色版的 [FirstChip_MpTools_20220601](http://download.s21i.co99.net/14013833/0/0/ABUIABBQGAAgkuGRlQYojJfJkwM.rar?f=FirstChip_MpTools_20220601.rar&v=1656489317)

第三步：进行量产

点击设定按钮，输入空密码，并设置扫描级别为原厂，优化模式为稳定优先。点击对应的盘符按钮，右键选择开始量产。