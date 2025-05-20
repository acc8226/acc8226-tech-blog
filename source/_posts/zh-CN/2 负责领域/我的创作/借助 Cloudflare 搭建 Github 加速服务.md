---
title: 借助 Cloudflare 搭建 Github 加速服务
date: 2025-05-20 10:05:32
updated: 2025-05-20 10:05:32
categories:
  - 0成本开发者套餐
tags: 0成本开发者套餐
permalink: ghproxy/
---

hunshcn/gh-proxy 是一个 github release、archive 以及项目文件的加速项目

cf worker 版本部署 方式

1. 注册并登录 cloudflare
2. 计算-Workers 和 Pages-创建-从 Hello World! 开始
3. 构建完成后点击“编辑代码”
4. 在 worker.js 编辑区域替换 js 后点击部署

```js
'use strict'
/**
 * ASSET_URL 是静态资源的 url（实际上就是现在显示出来的那个输入框单页面）
 * PREFIX 是前缀，默认（根路径情况为"/"），如果自定义路由为 example.com/gh/*，请将 PREFIX 改为 '/gh/'，注意，少一个杠都会错！
 * static files (404.html, sw.js, conf.js)
 */
const ASSET_URL = 'https://feipig.fun/mypage/ghproxy/'
// 前缀，如果自定义路由为example.com/gh/*，将PREFIX改为 '/gh/'，注意，少一个杠都会错！
const PREFIX = '/'
// 分支文件使用jsDelivr镜像的开关，0为关闭，默认关闭
const Config = {
    jsdelivr: 0
}

const whiteList = [] // 白名单，路径里面有包含字符的才会通过，e.g. ['/username/']

/** @type {ResponseInit} */
const PREFLIGHT_INIT = { 
    status: 204,
    headers: new Headers({
        'access-control-allow-origin': '*',
        'access-control-allow-methods': 'GET,POST,PUT,PATCH,TRACE,DELETE,HEAD,OPTIONS',
        'access-control-max-age': '1728000',
    }),
}


const exp1 = /^(?:https?:\/\/)?github\.com\/.+?\/.+?\/(?:releases|archive)\/.*$/i
const exp2 = /^(?:https?:\/\/)?github\.com\/.+?\/.+?\/(?:blob|raw)\/.*$/i
const exp3 = /^(?:https?:\/\/)?github\.com\/.+?\/.+?\/(?:info|git-).*$/i
const exp4 = /^(?:https?:\/\/)?raw\.(?:githubusercontent|github)\.com\/.+?\/.+?\/.+?\/.+$/i
const exp5 = /^(?:https?:\/\/)?gist\.(?:githubusercontent|github)\.com\/.+?\/.+?\/.+$/i
const exp6 = /^(?:https?:\/\/)?github\.com\/.+?\/.+?\/tags.*$/i

/**
 * @param {any} body
 * @param {number} status
 * @param {Object<string, string>} headers
 */
function makeRes(body, status = 200, headers = {}) {
    headers['access-control-allow-origin'] = '*'
    return new Response(body, {status, headers})
}


/**
 * @param {string} urlStr
 */
function newUrl(urlStr) {
    try {
        return new URL(urlStr)
    } catch (err) {
        return null
    }
}


addEventListener('fetch', e => {
    const ret = fetchHandler(e)
        .catch(err => makeRes('cfworker error:\n' + err.stack, 502))
    e.respondWith(ret)
})


function checkUrl(u) {
    for (let i of [exp1, exp2, exp3, exp4, exp5, exp6]) {
        if (u.search(i) === 0) {
            return true
        }
    }
    return false
}

/**
 * @param {FetchEvent} e
 */
async function fetchHandler(e) {
    const req = e.request
    const urlStr = req.url
    const urlObj = new URL(urlStr)
    let path = urlObj.searchParams.get('q')
    if (path) {
        return Response.redirect('https://' + urlObj.host + PREFIX + path, 301)
    }
    // cfworker 会把路径中的 `//` 合并成 `/`
    path = urlObj.href.substr(urlObj.origin.length + PREFIX.length).replace(/^https?:\/+/, 'https://')
    if (path.search(exp1) === 0 || path.search(exp5) === 0 || path.search(exp6) === 0 || path.search(exp3) === 0 || path.search(exp4) === 0) {
        return httpHandler(req, path)
    } else if (path.search(exp2) === 0) {
        if (Config.jsdelivr) {
            const newUrl = path.replace('/blob/', '@').replace(/^(?:https?:\/\/)?github\.com/, 'https://cdn.jsdelivr.net/gh')
            return Response.redirect(newUrl, 302)
        } else {
            path = path.replace('/blob/', '/raw/')
            return httpHandler(req, path)
        }
    } else if (path.search(exp4) === 0) {
        const newUrl = path.replace(/(?<=com\/.+?\/.+?)\/(.+?\/)/, '@$1').replace(/^(?:https?:\/\/)?raw\.(?:githubusercontent|github)\.com/, 'https://cdn.jsdelivr.net/gh')
        return Response.redirect(newUrl, 302)
    } else {
        return fetch(ASSET_URL + path)
    }
}


/**
 * @param {Request} req
 * @param {string} pathname
 */
function httpHandler(req, pathname) {
    const reqHdrRaw = req.headers

    // preflight
    if (req.method === 'OPTIONS' &&
        reqHdrRaw.has('access-control-request-headers')
    ) {
        return new Response(null, PREFLIGHT_INIT)
    }

    const reqHdrNew = new Headers(reqHdrRaw)

    let urlStr = pathname
    let flag = !Boolean(whiteList.length)
    for (let i of whiteList) {
        if (urlStr.includes(i)) {
            flag = true
            break
        }
    }
    if (!flag) {
        return new Response("blocked", {status: 403})
    }
    if (urlStr.search(/^https?:\/\//) !== 0) {
        urlStr = 'https://' + urlStr
    }
    const urlObj = newUrl(urlStr)

    /** @type {RequestInit} */
    const reqInit = {
        method: req.method,
        headers: reqHdrNew,
        redirect: 'manual',
        body: req.body
    }
    return proxy(urlObj, reqInit)
}


/**
 *
 * @param {URL} urlObj
 * @param {RequestInit} reqInit
 */
async function proxy(urlObj, reqInit) {
    const res = await fetch(urlObj.href, reqInit)
    const resHdrOld = res.headers
    const resHdrNew = new Headers(resHdrOld)

    const status = res.status

    if (resHdrNew.has('location')) {
        let _location = resHdrNew.get('location')
        if (checkUrl(_location))
            resHdrNew.set('location', PREFIX + _location)
        else {
            reqInit.redirect = 'follow'
            return proxy(newUrl(_location), reqInit)
        }
    }
    resHdrNew.set('access-control-expose-headers', '*')
    resHdrNew.set('access-control-allow-origin', '*')

    resHdrNew.delete('content-security-policy')
    resHdrNew.delete('content-security-policy-report-only')
    resHdrNew.delete('clear-site-data')

    return new Response(res.body, {
        status,
        headers: resHdrNew,
    })
}
```
5. 如果 worker.dev 域名无法在大陆网络环境使用，需要配置自有域名
6. 可选：更改前端页面，前端页面发布后需要同步修改 worker.js 中的 ASSET_URL 地址。

```html
<!DOCTYPE html>
<html lang="zh-Hans">
<style>
    html, body {
        width: 100%;
        margin: 0;
        height: 100%;
        background: linear-gradient(to bottom right, #fff, #f0f0f0);
        background-attachment: fixed;
    }

    body {
        min-height: 100%;
        padding: 20px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    p {
        word-break: break-all;
        margin: 10px 0;
    }

    @media (max-width: 500px) {
        h1 {
            margin-top: 80px;
        }
    }

    .container {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        width: 80%;
        max-width: 600px;
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
        font-size: 2.5rem;
        background: linear-gradient(to right, #3294ea, #00bfb3);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
    }

    .url {
        font-size: 16px;
        padding: 15px 10px 15px 5px;
        width: 100%;
        border: none;
        border-bottom: 2px solid #bfbfbf;
        outline: none;
        transition: border-color 0.3s;
        background-color: rgba(240, 240, 240, 0.7);
        border-radius: 5px;
    }

    .url:focus {
        border-color: #00bfb3;
    }

    .bar {
        height: 2px;
        width: 100%;
        bottom: 0;
        position: absolute;
        background: #00bfb3;
        transition: 0.2s ease transform;
        transform: scaleX(0);
    }

    .url:focus ~ .bar {
        transform: scaleX(1);
    }

    .btn {
        line-height: 42px;
        background: linear-gradient(to right, #3294ea, #00bfb3);
        color: #fff;
        white-space: nowrap;
        text-align: center;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        padding: 10px 20px;
        width: 100%;
        margin-top: 20px;
        font-weight: bold;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .btn:active {
        transform: translateY(0);
    }

    .tips, .example {
        color: #666;
        margin: 15px 0 0 0;
        padding: 10px;
        background-color: rgba(240, 240, 240, 0.7);
        border-radius: 5px;
        font-size: 14px;
        line-height: 1.6;
    }

    .tips p, .example p {
        margin: 8px 0;
    }

    .tips a, .example a {
        color: #3294ea;
        text-decoration: none;
    }

    .tips a:hover, .example a:hover {
        text-decoration: underline;
    }

    .footer {
        margin-top: 30px;
        font-size: 14px;
        color: #7b7b7b;
        text-align: center;
    }

    .footer a {
        color: #3294ea;
        text-decoration: none;
    }

    .footer a:hover {
        text-decoration: underline;
    }
</style>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script>
        function toSubmit(e) {
            e.preventDefault();
            const urlInput = document.getElementsByName('q')[0];
            const urlValue = urlInput.value;
            if (urlValue) {
                window.open('https://ghproxy.feipig.fun/' + urlValue);
                urlInput.value = '';
            }
            return false;
        }
    </script>
    <title>GitHub 文件加速</title>
</head>
<body>
    <div class="container">
        <h1>GitHub 文件加速</h1>
        <form action="./" method="get" onsubmit="toSubmit(event)">
            <label>
                <input class="url" name="q" type="text" placeholder="键入Github文件链接" pattern="^((https|http):\/\/)?(github\.com\/.+?\/.+?\/(?:releases|archive|blob|raw|suites)|((?:raw|gist)\.(?:githubusercontent|github)\.com))\/.+$" required>
                <div class="bar"></div>
            </label>
            <input class="btn" type="submit" value="加速下载">
            <div class="tips">
                <p>GitHub 文件链接带不带协议头都可以，支持 release、archive 以及文件，右键复制出来的链接都是符合标准的，更多用法、clone 加速请参考<a href="https://hunsh.net/archives/23/">这篇文章</a>。</p>
                <p>release、archive 使用 cf 加速，文件会跳转至 JsDelivr</p>
                <p>注意，不支持项目文件夹</p>
            </div>
            <div class="example">
                <p>分支源码：https://github.com/hunshcn/project/archive/master.zip</p>
                <p>release 源码：https://github.com/hunshcn/project/archive/v0.1.0.tar.gz</p>
                <p>release 文件：https://github.com/hunshcn/project/releases/download/v0.1.0/example.zip</p>
                <p>分支文件：https://github.com/hunshcn/project/blob/master/filename</p>
            </div>
        </form>
        <div class="footer">
            项目基于 Cloudflare Workers，前端代码<a href="https://feipig.fun/ghproxy">点此获取</a>，后端源自 <a href="https://github.com/hunshcn/gh-proxy">hunshcn/gh-proxy</a>
        </div>
    </div>
</body>
</html>
```

