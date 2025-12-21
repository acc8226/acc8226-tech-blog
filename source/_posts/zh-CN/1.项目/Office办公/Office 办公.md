---
title: Office 办公
date: 2025-12-21 22:21:41
updated: 2025-12-21 22:21:41
categories:
  - Office 办公
tags: Office 办公
---

## 软件选择

64位的 WPS 有了后来居上。比 Office 2024 个人版多了支持 groupby 函数。记得开启离线功能和关闭自动升级。
<!-- more -->

## 表格使用

对项目所属地排序

```excel
=LET(
    lastRow, LOOKUP(2,1/(Sheet1!K:K<>""),ROW(Sheet1!K:K)),
    dataRange, Sheet1!K2:INDEX(Sheet1!K:K,lastRow),
    GROUPBY(
        dataRange,
        SEQUENCE(ROWS(dataRange),,1),
        COUNT,
        0,              /* 0 表示显示标题 */
        "区县",         /* 第 4 参数：分组列标题 */
        "项目数"        /* 第 5 参数：计数列标题 */
    )
)
```

特定日期内对项目所属地排序

```excel
=LET(
    lastRow, LOOKUP(2,1/(Sheet1!K:K<>""),ROW(Sheet1!K:K)),
    dataRange, Sheet1!K2:INDEX(Sheet1!K:K,lastRow),
    GROUPBY(
        dataRange,
        SEQUENCE(ROWS(dataRange),,1),
        COUNT,
        0,              /* 0 表示显示标题 */
        "区县",         /* 第 4 参数：分组列标题 */
        "项目数"        /* 第 5 参数：计数列标题 */
    )
)
```

## 自动化办公

python + panda 是必须了解的利器。
