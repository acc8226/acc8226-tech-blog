---
title: python 浏览器自动化
date: 2025-07-05 22:13:00
updated: 2025-07-05 22:13:00
categories:
  - 语言
  - Python
tags: python
---

pip install selenium

Selenium WebDriver：这是 Selenium 的核心组件，用于直接与浏览器进行交互。WebDriver 提供了丰富的 API，允许开发者通过代码控制浏览器的行为，如打开网页、点击按钮、填写表单等。

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
