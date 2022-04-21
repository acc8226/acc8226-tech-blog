## 后端调试环境

JDK 11， Maven 3.6 及其以上，IDEA 集成开发工具（需提前安装 Lombok 插件安装、Protocol Buffers 官方插件安装）

## 调试说明

直接修改源码并进行构建发布。

由于 application 模块使用了 ui-ngx 模块，在 run app 的时候只需按顺序构建改动模块。一般如果改动了 ui-ngx 的前端代码，本地调试需要重新 mvn install 一次，然后使用 IEDA 重新  run app。

pom 中目前使用的是正式版本，之后可以考虑 snapshot 版和 maven 私服的搭配使用。项目就能做到模块单独构建，模块间构建互不影响。

### 更改点击首页图标的跳转路径

ui-ngx\src\app\shared\components\logo.component.ts

```ts
export class LogoComponent {
  ...............
  gotoThingsboard(): void {
    window.open('https://www.mfox.cn', '_blank');
  }
  ...............
}
```

### 更改 logo

很多公司想要定制 tb 的 logo，然后自己再申请软著，各种认证。 在 tb 中修改 logo 很简单，可以直接替换原有文件，也可以直接修改源码来更改 logo。

替换文件的话，只需要替换
* src/assets/logo-title_white.svg, 此图片属性中原始大小为 1536*318px，css中设置大小为 280 * 60 px。所以替换图片的过程中要最好保持固定宽高比，且高度统一为 60 px。
* src/thinsboard.ico, 32*32px

src/assets/logo-white.svg 目前没用到，删除即可。

### 修改网站标题 和 默认语言

ui-ngx\src\environments\environment.ts
```ts
export const environment = {
  appTitle: 'xxxxxxxx',
  defaultLang: 'en_US'
};
```

### 修改主题色

theme.scss
```
$tb-primary-color: #2b675d;
$tb-secondary-color: #82a7d1;
$tb-hue3-color: #c8d3df;

$tb-dark-primary-color: #9fa8da;
```
