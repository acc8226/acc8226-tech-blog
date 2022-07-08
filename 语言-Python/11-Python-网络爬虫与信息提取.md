![](https://upload-images.jianshu.io/upload_images/1662509-4c2d897b87504fcb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Requests 的安装
```
# 1. 找到 python 安装路径:
C:\Users\hp\AppData\Local\Programs\Python\Python35\Scripts`
# 2. cmd命令执行
pip install requests
```

![Requests库的七个主要方法](https://upload-images.jianshu.io/upload_images/1662509-4ea1f3a2aa5deec5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### get方法

`requests.get(url, params=None, **kwargs)`
* url : 拟获取页面的url链接
* params : url中的额外参数，字典或字节流格式，可选
* **kwargs: 12个控制访问的参数

![Response对象的属性](https://upload-images.jianshu.io/upload_images/1662509-7bd8fc91c80c94d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1662509-ca5a975f64f621d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![理解Requests库的异常](https://upload-images.jianshu.io/upload_images/1662509-32b09206e8191917.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1662509-d1390251e630e75c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> `response.raise_for_status()`在方法内部判断r.status_code是否等于200，不需要
增加额外的if语句，该语句便于利用try‐except进行异常处理

![Requests库的7个主要方法](https://upload-images.jianshu.io/upload_images/1662509-b8bb7703ec30c5ac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![HTTP协议对资源的操作](https://upload-images.jianshu.io/upload_images/1662509-58afed719b3938b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 爬取网页的通用代码框架

``` python 
import requests

def getHTMLText(url):
    try:
        # 模拟正常浏览器请求头
        kv = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132'}
        response = requests.get(url, timeout = 10, headers = kv)
        response.raise_for_status()
        response.encoding = response.apparent_encoding
        return response.text
    except:
        return "产生HTTPError"
```
