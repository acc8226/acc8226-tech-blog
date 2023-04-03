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

## 已过时 JXL

A Java library for reading/writing Excel - Browse Files at SourceForge.net
<https://sourceforge.net/projects/jexcelapi/files/>

## easyexcel

alibaba/easyexcel
<https://github.com/alibaba/easyexcel/>

## 记录

### 指定下载文件的文件名

关键代码看懂一下三个对 resopnse 的设置即可

```java
response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
response.setCharacterEncoding("utf-8");
String fileName = URLEncoder.encode(DeviceEnum.getDescByName(deviceTypeName) + "-模板", "UTF-8").replaceAll("\\+", "%20");
response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
```

完整示例：

```java
    /**
     * 根据设备类型导出填写模板
     */
    @GetMapping("/download/{devType}")
    public void download(@PathVariable("devType") String deviceTypeName, HttpServletResponse response) {
        // 根据 devType 获取所有的中文名
        final List<List<String>> head = devTypeService.obtainExcelTemplateHead(deviceTypeName);
        log.info(JSON.toJSONString(head));
        try {
            List<List<Object>> excelDataList = Collections.singletonList(Collections.emptyList());
            // 这里注意有同学反应使用 swagger 会导致各种问题，请直接用浏览器或者用 postman
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            // 这里 URLEncoder.encode 可以防止中文乱码 当然和 easyexcel 没有关系
            String fileName = URLEncoder.encode(DeviceEnum.getDescByName(deviceTypeName) + "-模板", "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
            EasyExcel.write(response.getOutputStream()).head(head).needHead(true).sheet("模板").doWrite(excelDataList);
        } catch (IOException e) {
            log.warn("download 设备 IOException", e);
        }
    }

```

## 遇到过的问题

### 导出不带表头的 excel 模板

```java
// 加入此行：空 list 解决了此问题
List<List<Object>> excelDataList = Collections.singletonList(Collections.emptyList());
EasyExcel.write(response.getOutputStream()).head(head).needHead(true).sheet("模板").doWrite(excelDataList);
```
