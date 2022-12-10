---
title: easyexcel 解析表格
date: 2022-10-14 22:28:00
updated: 2022-10-14 22:28:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
- Excel
---

alibaba/easyexcel
<https://github.com/alibaba/easyexcel/>

## 遇到过的问题

### excel 导出模板不带表头

```java
// 加入此行：空 list 解决了此问题
List<List<Object>> excelDataList = Collections.singletonList(Collections.emptyList());

EasyExcel.write(response.getOutputStream()).head(head).needHead(true).sheet("模板").doWrite(excelDataList);
```
