---
title: Excel 学习
date: 2026-03-16 20:51:48
updated: 2026-04-29 00:09:03
categories:
  - Office 办公
tags: Office 办公
---

## 快捷键

ctrl + 向下 移动到表格底部
Ctrl + t 创建超级表
Ctrl + 1 设置单元格格式
<!-- more -->

## 如何把数字变成数据条

1. 选择环比增长率区域，例如【D2:D10】
1. 在【开始】选项卡中单击【条件格式】按钮
1. 选择【数据条】选项
1. 选择喜欢的数据条样式。

## 多维表格

[WPS 脚本令牌（APIToken）](https://airsheet.wps.cn/docs/apitoken/intro.html)

开发者通过 AirScript 编辑器编写的脚本，可以直接在编辑器内运行，也可以粘贴链接在单元格运行，或者是通过定时任务面板自动运行。

获取所有记录，搭配 webhook 用。

```js
// const sheets = Application.Sheet.GetSheets() // 获取当前表格对象。调试用

function pagedQuery(sheetId) {
  let all = []
  let start = true;
  let offset = null;
  // 分页获取记录
  while (start || offset) {
    start = false;
    let records = Application.Record.GetRecords({
      SheetId: sheetId,
      Offset: offset
    })
    offset = records.offset
    all = all.concat(records.records) // 拼接所有分页数据
  }
  console.log("记录条数：" + all.length)
  return all // 返回所有表格内容
}

return pagedQuery(218) // 传入第一个 sheet 页的 ID，并 push 给变量 returnData
```

### 飞书多维表格 获取记录

[自建应用获取 tenant_access_token](https://open.feishu.cn/document/server-docs/authentication-management/access-token/tenant_access_token_internal)

```sh
curl -i -X POST 'https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal' \
-H 'Content-Type: application/json' \
-d '{
	"app_id": "xxx",
	"app_secret": "xxx"
}'
```

{
  "code": 0,
  "expire": 7200,
  "msg": "ok",
  "tenant_access_token": "xxx"
}

[查询记录](https://open.feishu.cn/document/docs/bitable-v1/app-table-record/search)

该接口用于查询数据表中的现有记录，单次最多查询 500 行记录，支持分页获取。

curl -i -X POST 'https://open.feishu.cn/open-apis/bitable/v1/apps/GrOBbT65baSd7TshbhYcV0JSn61/tables/tbltdfCWmVlegjWv/records/search?page_size=3' \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer xxx' \
-d '{}'