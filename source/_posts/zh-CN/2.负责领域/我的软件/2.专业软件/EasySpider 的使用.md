---
title: EasySpider 的使用
date: 2025-08-26 10:44:57
updated: 2025-08-26 10:44:57
categories:
  - 收藏
  - 专业软件
---

[易采集EasySpider](https://www.easyspider.cn/) 是一款可视化，几分钟设计一个爬虫/浏览器自动化测试任务的开源、免费、无广告软件。

[官方视频教程](https://www.bilibili.com/video/BV1th411A7ey/)

获取统计的机器管数目

https://hnsggzy.com/tradeApi/constructionTender/listSection?current=1&size=1&regionCode=430700

data.total 字段（整型）

<!-- more -->

- - -

取出

data.records[0].bidSectionId 字段为 "08aa008f-081a-42a0-af46-4323287b057a"

然后访问网页

https://yueyang.hnsggzy.com/#/resources/transactionDetail/test?t=GC&bidSectionId=08aa008f-081a-42a0-af46-4323287b057a

项目名称
data.constructionTender.tenderProjectName
桃源县漳江街道片区老旧街区改造项目（一标段）

招标人名称
data.constructionTender.tendererName
桃源县城市建设投资开发有限公司	

代理机构名称
data.constructionTender.tenderAgencyName
湖南日昇项目管理有限公司

标段合同估算价
data.constructionSectionList[0].tenderControlPrice
3779.612,

项目类型
data.constructionTender.tenderProjectType
住建工程

评标办法 可暂时跳过
去 公告接口 https://yueyang.hnsggzy.com/tradeApi/constructionNotice/getBySectionId?sectionId=4468b953-9d60-4da2-8633-fce8be4c69aa

开标时间
去 公告接口
data.noticeList[0].bidOpeningTimeStart
