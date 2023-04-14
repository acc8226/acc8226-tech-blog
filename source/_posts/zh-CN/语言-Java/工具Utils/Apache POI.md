---
title: Apache POI
date: 2023-04-12 19:00:00
updated: 2023-04-12 19:00:00
categories:
  - 语言-Java
  - 框架
tags:
- Java
---

Apache POI 的组件

Apache POI 包含用于 MS-Office 的所有 OLE2 复合文档的类和方法。 此 API 的组件列表如下:

* POIFS(可疑混淆执行文件系统):此组件是所有其他 POI 元素的基本因素。 它用于显式读取不同的文件。
* HSSF(可怕的SpreadSheet格式):用于读取和写入 .xls 格式的 MS-Excel 文件。
* XSSF(XML SpreadSheet格式):用于 MS-Excel 的 .xlsx 文件格式。
* HPSF(可怕属性集格式):用于提取 MS-Office 文件的属性集。
* HWPF(可怕字处理器格式):用于读取和写入 MS-Word 的.doc扩展文件。
* XWPF(XML 字处理器格式):用于读取和写入 MS-Word 的扩展文件 .docx。
* HSLF(可怕的幻灯片布局格式):用于阅读，创建和编辑 PowerPoint 演示文稿。
* HDGF(Horrible DiaGram 格式):它包含 MS-Visio 二进制文件的类和方法。
* HPBF(Horrible PuBlisher格式):用于读取和写入 MS-Publisher 文件。

本教程将指导您完成使用 Java 处理 MS-Word 文件的过程。 因此，讨论仅限于 HWPF 和 XWPF 组件。

## 安装

```groovy
// 读取 word 的 docx 文档
implementation("org.apache.poi:poi-ooxml:5.2.3")
```

## 解析 word

Poi 之Word 文档结构介绍

1、poi 之 word 文档结构介绍之正文段落

一个文档包含多个段落，一个段落包含多个Runs，一个Runs包含多个Run，Run是文档的最小单元
获取所有段落：`List<XWPFParagraph> paragraphs = word.getParagraphs();`
获取一个段落中的所有Runs：`List<XWPFRun> xwpfRuns = xwpfParagraph.getRuns();`
获取一个Runs中的一个Run：`XWPFRun run = xwpfRuns.get(index);`

2、poi 之 word 文档结构介绍之正文表格

一个文档包含多个表格，一个表格包含多行，一行包含多列（格），每一格的内容相当于一个完整的文档
获取所有表格：`List<XWPFTable> xwpfTables = doc.getTables();`
获取一个表格中的所有行：`List<XWPFTableRow> xwpfTableRows = xwpfTable.getRows();`
获取一行中的所有列：`List<XWPFTableCell> xwpfTableCells = xwpfTableRow.getTableCells();`
获取一格里的内容：`List<XWPFParagraph> paragraphs = xwpfTableCell.getParagraphs();`

之后和正文段落一样。

注：表格的一格相当于一个完整的 docx 文档，只是没有页眉和页脚。里面可以有表格，使用xwpfTableCell.getTables()获取，and so on
在poi文档中段落和表格是完全分开的，如果在两个段落中有一个表格，在poi中是没办法确定表格在段落中间的。（当然除非你本来知道了，这句是废话）。只有文档的格式固定，才能正确的得到文档的结构

3、poi 之 word 文档结构介绍之页眉：

一个文档可以有多个页眉(不知道怎么会有多个页眉。。。),页眉里面可以包含段落和表格
获取文档的页眉：`List<XWPFHeader> headerList = doc.getHeaderList();`
获取页眉里的所有段落：`List<XWPFParagraph> paras = header.getParagraphs();`
获取页眉里的所有表格：`List<XWPFTable> tables = header.getTables();`

之后就一样了

4、poi 之 word 文档结构介绍之页脚：

页脚和页眉基本类似，可以获取表示页数的角标

## 其他项目

Free Spire.Office for Java | 免费的 Java Office 套件，涵盖 Office 和 PDF 文档创建、处理、打印、转换功能
<https://www.e-iceblue.cn/Introduce/Free-Spire-Office-JAVA.html>

## 参考

apache_poi_word 教程_w3cschool
<https://www.w3cschool.cn/apache_poi_word/>

Poi 之 Word 文档结构介绍 - Flink 菜鸟 - 博客园
<https://www.cnblogs.com/Springmoon-venn/p/5494602.html>
