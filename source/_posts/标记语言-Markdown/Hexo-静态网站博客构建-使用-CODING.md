## 产品介绍

**CODING 静态网站服务**是 CODING 联合腾讯云 Serverless 团队，为开发者提供的便捷、稳定、高拓展性的静态网站资源托管服务。无需自建服务器，即可一键部署网站应用，将静态网站分发至全网节点，轻松为您的网站业务增添稳定、高并发、快速访问等能力。

CODING 静态网站服务结合 [Tencent Serverless Framework](https://cloud.tencent.com/product/sls) 提供完整、高效的部署流程，支持 Jekyll、Hexo 等多种部署框架。静态资源的分发由 [腾讯云对象存储 COS](https://cloud.tencent.com/product/cos) 和拥有多个边缘网点的 [腾讯云内容分发网络 CDN](https://cloud.tencent.com/product/cdn) 提供支持。

1\. 在 CODING DevOps 平台左侧导航栏中点击【项目】，来到项目列表页，在项目列表页点击【创建项目】按钮。

2\. 选择创建 DevOps 项目。

![](https://upload-images.jianshu.io/upload_images/1662509-a2b98112ad8ebe86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3\. 进入项目后，在左侧导航栏中依次点击持续部署 - 静态网站。如果是首次使用静态网站服务，会看到提示，要求去开启腾讯云中关于 CODING 与 SLS 相关的权限，并且进行实名认证。

4\. 点击【新建静态网站】，进入新建静态网站页面，填写网站名称，然后在代码来源中选择示例项目，在示例项目中选择 Hexo，最后选择部署的节点，这里选择香港节点。

![](https://upload-images.jianshu.io/upload_images/1662509-e24c4cbd7fe1962c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5\. 创建成功后，耐心等待静态网站部署完成，状态由【部署中】变为【部署成功】。

![](https://upload-images.jianshu.io/upload_images/1662509-c623ad09a44aa103.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6\. 部署成功后，CODING 静态网站会自动帮您生成一个访问地址，点击后即可访问刚刚部署的博客网站。至此，部署流程全部完成。

![](https://upload-images.jianshu.io/upload_images/1662509-c8404e41ac4ba2f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 目录介绍

就是标准的 hexo 构建源码而已。文章则都在 source/_posts 目录中。可以通过命令 `hexo new '文章标题' `依据模板进行新建文章。再去修改细节。

![](https://upload-images.jianshu.io/upload_images/1662509-c151397e458d924d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 资源说明

CODING 平台本身不收取任何费用。静态网站服务需调用腾讯云对象存储 COS、内容分发网络 CDN、SSL 证书产品等资源，其中 COS 和 CDN 采用用量**计费模式**，SSL 证书免费。

## 最后

所以新版 coding page 如果想用就得自愿按需付费了。
