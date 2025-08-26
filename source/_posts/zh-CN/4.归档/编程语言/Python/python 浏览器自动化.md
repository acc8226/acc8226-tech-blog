---
title: python 浏览器自动化
date: 2025-07-05 22:13:00
updated: 2025-07-05 22:13:00
categories:
  - 语言
  - Python
tags: python
---

## Selenium

Selenium WebDriver 是 Selenium 的核心组件，用于直接与浏览器进行交互。WebDriver 提供了丰富的 API，允许开发者通过代码控制浏览器的行为，如打开网页、点击按钮、填写表单等。

pip install selenium

<!-- more -->

```python
from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.service import Service as FirefoxService

service = FirefoxService(executable_path="/Users/zhangsan/Downloads/geckodriver")
options = webdriver.FirefoxOptions()
driver = webdriver.Firefox(service=service, options=options)

driver.get('https://www.soso.com/')

title = driver.title
print("页面标题:", title)

url = driver.current_url
print("当前 URL:", url)

elem = driver.find_element(By.ID, 'query')
elem.send_keys('你好')
elem.send_keys(Keys.ENTER)

## driver.quit()
```

[Selenium 教程](https://www.runoob.com/selenium/selenium-tutorial.html) | 菜鸟教程

浏览器驱动程序，是 Selenium 与所选择的浏览器进行交互的必要组件。

* Chrome:https://developer.chrome.com/docs/chromedriver | [CNPM Binaries Mirror](https://registry.npmmirror.com/binary.html?path=chrome-for-testing/)
* Edge:https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver
* Firefox:https://github.com/mozilla/geckodriver
* Safari:https://webkit.org/blog/6900/webdriver-support-in-safari-10

## playwright

playwright 是 Microsoft 出品的一款跨浏览器自动化测试库

1. 安装 Playwright：

在终端或命令提示符中运行以下命令来安装 Playwright 包：

pip install playwright

2. 安装 Playwright 浏览器：

安装 Playwright 包后，还需要安装 Playwright 支持的浏览器。运行以下命令：

playwright install

这将下载并安装 Chromium、Firefox 和 WebKit 浏览器。如果你只需要 Chromium，可以指定：

playwright install chromium

## 小测验

通过查询某地交易中心的数据，并获取各州市的项目总条数。

注：以下代码旨用于学习和研究，承诺不会用于其他任何用途。若频繁抓取可能导致你的 IP 被封禁。
我们尊重网站的版权，仅在允许的范围内使用和公布源码。如果网站明确禁止抓取和公布源码，我们将立即停止相关行为。

基于 selenium

```py
import time
import re
import csv
import random

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.service import Service as FirefoxService

# 初始化 WebDriver
service = FirefoxService(executable_path='D:\\acc\\geckodriver-v0.36.0-win32\\geckodriver.exe')
options = webdriver.FirefoxOptions()
options.binary_location = "C:\\Program Files\\Mozilla Firefox\\firefox.exe"
# options.add_argument("--headless")  # 启用无头模式

driver = webdriver.Firefox(service=service, options=options)

# 定义要访问的区域代码列表
list = [
    "430000"
    , "430100"
    # , "430200"
    # , "430300"
    # , "430400"

    # , "430500"
    # , "430600"
    # , "430700"
    # , "430800"
    # , "430900"

    # , "431300"
    # , "431000"
    # , "431100"
    # , "431200"
    # , "433100"
]

# 打开 CSV 文件，准备写入
with open('output.csv', mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    # 写入表头
    writer.writerow(['Region Code', '项目来源', '条数'])

    for e in list:
        driver.get("https://yiyang.hnsggzy.com/#/projectHome?tenderProjectName=&bidSectionName=&tenderProjectType"
                   "=&notice=&bidOpeningTimeStartGt=&bidOpeningTimeStartLt=&resourceState=&regionCode=" + e)
        time.sleep(6 + random.randint(1, 3))

        # 获取页面标题和 URL
        print("页面标题:", driver.title)
        print("当前 URL:", driver.current_url)

        try:
            # 获取选中的文本
            selected = driver.find_element(By.CSS_SELECTOR, '.el-select-dropdown__item.selected span')
            t1 = selected.get_attribute('innerText')

            # 获取分页信息
            webElement = driver.find_element(By.CSS_SELECTOR, 'span.el-pagination__total')
            text = webElement.text
            print(text)
            match = re.search(r'\d+', text)
            if match:
                t2 = match.group()
                print("提取的数字是:", t2)
            else:
                print("未找到数字")
                t2 = "N/A"  # 如果未找到数字，写入占位符

            # 将数据写入 CSV 文件
            writer.writerow([e, t1, t2])
        except Exception as ex:
            print(f"处理区域代码 {e} 时出错: {ex}")
            # 如果出错，写入错误信息
            writer.writerow([e, "Error", "Error"])

# 关闭 WebDriver
driver.quit()
```

基于 playwright

```py
import time
import re
import csv
import random

from playwright.sync_api import sync_playwright

# 定义要访问的区域代码列表
regions = [
    "430000"
    , "430100"
    # , "430200"
    # , "430300"
    # , "430400"
    #
    # , "430500"
    # , "430600"
    # , "430700"
    # , "430800"
    # , "430900"
    #
    # , "431300"
    # , "431000"
    # , "431100"
    # , "431200"
    # , "433100"
]

# 打开 CSV 文件，准备写入
with open('output.csv', mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    # 写入表头
    writer.writerow(['地区编号', '项目来源', '条数'])

    with sync_playwright() as p:
        # 启动浏览器
        # browser = p.chromium.launch(headless=False) # 不启用无头模式
        browser = p.chromium.launch()
        context = browser.new_context()
        page = context.new_page()

        total = 0
        for region in regions:
            # 构造 URL
            url = (f"https://huaihua.hnsggzy.com/#/projectHome?tenderProjectName=&bidSectionName=&tenderProjectType"
                   f"=&notice=&bidOpeningTimeStartGt=&bidOpeningTimeStartLt=&resourceState=&regionCode={region}")
            page.goto(url)

            # 等待页面加载完成
            time.sleep(6 + random.randint(1, 3))

            try:
                # 获取选中的文本 匹配第一个
                selected = page.query_selector('.el-select-dropdown__item.selected span')
                t1 = selected.text_content() if selected else "N/A"

                # 获取总条数
                webElement = page.query_selector('span.el-pagination__total')
                text = webElement.text_content() if webElement else "N/A"
                match = re.search(r'\d+', text)
                if match:
                    t2 = match.group()
                    total += int(t2)
                else:
                    t2 = "N/A"
                print(f"区域代码: {region}, 项目来源: {t1}, 条数: {t2}")
                writer.writerow([region, t1, t2])
            except Exception as ex:
                print(f"处理区域代码 {region} 时出错: {ex}")
                writer.writerow([region, "Error", "Error"])
        # 关闭浏览器
        browser.close()

print("数据已成功写入 output.csv 文件")
print("总条数：" + str(total))
```
