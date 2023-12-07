---
title: OAuth2
date: 2023-10-27 19:35:06
updated: 2023-10-27 19:35:06
categories:
  - 语言-Java
  - 框架
tags:
- Java
- 安全
- 鉴权
---

用的最多的就是授权码模式

是否允许将信息授权给百度，这要可以拿到一个授权码
根据授权码解密后向授权服务器申请令牌，这样就可以拿到访问令牌 token 和更新令牌
拿到令牌后就可以向资源服务器申请资源

认证 和 回调

http://oo.feipig.com:8080/oauth/render
http://oo.feipig.com:8080/oauth/callback


授权

gitee

https://gitee.com/oauth/authorize?response_type=code&client_id=5efe40852d85706ae7f6ddce11a9b5949bc1ffd4357edb75a9da16b259746d10&redirect_uri=http://oo.feipig.com:8080/login&state=0e438442680baa1bffc98ca56da891bc&scope=user_info

github 集成

https://github.com/login/oauth/authorize?response_type=code&client_id=Iv1.6f265c4a5f7bed6c&redirect_uri=http://localhost:8443/oauth/callback/github&state=f283ed5287fcd71aee6641d1b44212ba&scope=gist

github 集成 tb

https://github.com/login/oauth/authorize?response_type=code&client_id=Iv1.6f265c4a5f7bed6c&scope=read:user%20user:email&state=GihDv7SfbgBxn0dR_ZTVjPAUSwxsaxRL6mMZeTawWqQ%3D&redirect_uri=http://192.168.18.105:9002/login/oauth2/code/

换取 toekn

https://gitee.com/oauth/token?code=0e8b30bca554de4408054fbb616b90030d9aeb48d48056ec006ce32cceb4328a&client_id=5efe40852d85706ae7f6ddce11a9b5949bc1ffd4357edb75a9da16b259746d10&client_secret=f1a95cbdba8af5146aa9647a4d22256f04130cb4ad31d55d5f7df7c53a708f7d&grant_type=authorization_code&redirect_uri=http://oo.feipig.com:8080/oauth/callback

{"access_token":"77fe590d541f948d2b3efaec70acc294","token_type":"bearer","expires_in":86400,"refresh_token":"f3f1b507afd16c624b1838d9dcc7b5131d377b2070317932f6ccb595926ccb53","scope":"user_info","created_at":1698404189}

获取用户信息

https://gitee.com/api/v5/user?access_token=bd7a1d253264d39be9cacde608afe63e

## 联调

改成 code 才算优秀且足够通用

http://127.0.0.1:8443/oauth/callback/ye?code=2rS%2B9foJFAuv54cVWeekaT0Ji%2BRyjhc5DTptYiHGmC3a9VMXzdyRKvAIq1BwevgE

内部是

第二步
http://119.3.255.138/api/decodeTicket?ticket=zozu%2BrR4aUzIBObbouvqKvNIuVFeaZGBJjIametwbPvjyxxPPZDLlb5xm1CzK5qEgakgBthfK1dw5UH8yaV383CramDGZngHc9iOxnBPOP4%3D


编码后 

http://119.3.255.138/api/decodeTicket?ticket=jN902n7AHy4fkR%2Bw%2F0WivJ6ruNUBXs0CaJ0QUb6BVJK4KLGk%2B1UBCX8psRSZBd2o%2BR3rLMb2iw%2F20MnI2vh9CE2MfvChFHzVgP3gD4YSrw7ZA2xY%2B0LgCjL%2FNkn2z47w

第三步

把 token 放到header里就可以请求用户信息接口了
http://119.3.255.138/api/getInfo
Authorization Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpblR5cGUiOiJsb2dpbiIsImxvZ2luSWQiOiJzeXNfdXNlcjoxIiwicm5TdHIiOiJNV0RqeHJ6Y1RISmtvRU9UTDZBOTZzMndoNFAyb0tGbyIsImlkIjoxfQ.sLP5wfMz2ZCIKfxVxTlX-IDbeQzom6BQm-M-9eaLdvE

oauth2_domain 作为 oauth2 的设置

键入
http://localhost:8080/oauth2/authorization/f6f14780-755d-11ee-94ab-03e0b675d1ef
将转到
https://github.com/login/oauth/authorize?response_type=code&client_id=Iv1.6f265c4a5f7bed6c&scope=read:user%20user:email&state=Kvdbppq9e9EUk8kfRxI6EwB3ysfd_XrguHNMXpk3Gyk%3D&redirect_uri=http://localhost:8080/login/oauth2/code/

回调错误收到
http://192.168.18.105:9002/login/oauth2/code/?error=redirect_uri_mismatch&error_description=The+redirect_uri+MUST+match+the+registered+callback+URL+for+this+application.&error_uri=https%3A%2F%2Fdocs.github.com%2Fapps%2Fmanaging-oauth-apps%2Ftroubleshooting-authorization-request-errors%2F%23redirect-uri-mismatch&state=Kvdbppq9e9EUk8kfRxI6EwB3ysfd_XrguHNMXpk3Gyk%3D
收到正确回调
http://localhost:8080/login/oauth2/code/?code=e795a18f65b57aa5cb23&state=dR4LZI4IFL2mqokryhx181A0pRhrB3SvsZY966bllOU=

提示用户不存在或者授权失败
http://124.207.66.131:7055/login?loginError=%5Bauthorization_request_not_found%5D+
http://localhost:8080/login?loginError=User+not+found%3A+acc8226%40qq.com 用户不存在User not found: acc8226@qq.com
404 Not Found
http://124.207.66.131:7055/login?loginError=User+not+found%3A+acc8226%40qq.com

加一些限制条件，只能是三方登录，如果该邮箱未注册则跳转到注册页面
