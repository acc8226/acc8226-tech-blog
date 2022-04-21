## Thingsboard 前端要点
Thingsboard 是一个使用 Angular JS 框架搭建的 web SPA 架构。

使用的是"@angular/cli"脚手架来搭建的。使用了 TypeScript。有部分的 React 代码，主要集中公共组件部分。

涉及技术：Angular JS、ES6、Reactjs、webpack、node。

## 前端开发环境的搭建

这里拿 ThingsBoard V3.3.4.1 的 tag 源码，要进行调试，根据项目 pom 文件中 node 使用 **v16.13.0** 版本，所以保持一致即可。目前的要求是不能高于 17。

pom 文件中 yarn 指定的是 **1.22.17** 版本。因此要求此版本或者更高。正常情况下 npm install yarn -g 即可。

进入 thingsboard/ui-ngx 目录进行操作
```
yarn
```
如果这一步报没有 yarn 命令的话，就先使用 npm 安装一下 yarn
```
npm i yarn -g
```

建议使用 yarn 来安装 npm 包，因为官方的仓库中是使用 yarn.lock 来锁定版本号的， 如果安装报错，八成是网络问题，因为很多包是在国外的。多试几次。

使用 yarn 安装完成 npm 包后，运行以下命令可以将项目启动：

```
yarn start
```

运行后，会对代码进行编译，构建。启动完成后，会自动打开浏览器，看到以下这个页面。

前端默认调试端口：4200

### 启动之后如何配置前端项目**访问后端服务**

在前端的 proxy.conf.js 文件配置的 forwardUrl 和 wsForwardUrl 变量。这里就是配置后端服务的路径。

代码如下
```js
const forwardUrl = "http://localhost:8080";
const wsForwardUrl = "ws://localhost:8080";
const ruleNodeUiforwardUrl = forwardUrl;

const PROXY_CONFIG = {
  "/api": {
    "target": forwardUrl,
    "secure": false,
  },
  "/static/rulenode": {
    "target": ruleNodeUiforwardUrl,
    "secure": false,
  },
  "/static/widgets": {
    "target": forwardUrl,
    "secure": false,
  },
  "/oauth2": {
    "target": forwardUrl,
    "secure": false,
  },
  "/login/oauth2": {
    "target": forwardUrl,
    "secure": false,
  },
  "/api/ws": {
    "target": wsForwardUrl,
    "ws": true,
    "secure": false
  },
};

module.exports = PROXY_CONFIG;
```

## 前端架构分析

ThingsBoard教程（九）：前端架构分析\_专栏\_易百纳技术社区
https://www.ebaina.com/articles/140000010056

## 前端简单定制化

ThingsBoard教程（十）：前端简单定制化_专栏_易百纳技术社区
https://www.ebaina.com/articles/140000012270

## 部件的基本 API 解释

在 ThingsBoard 中，部件相关的业务逻辑都是在 JavaScript 面板里编写的。每一个部件对外都提供了一个 `self` 对象，改组件的所有属性都被挂载`self`之下， 如部件的容器 `$scontainer`, 部件的高 `height`。 包含部件所有的函数，也都是在`self`对象下定义。 此外`self`还有很多部件上下文的属性，一些组件必要的API和数据访问接口，以下是部件内容的解释。

### $container

类型： jQuery Object 描述：部件的容器节点，可使用 jQuery API 动态创建或修改内容。

### $scope

类型： [IDynamicWidgetComponent](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/app/modules/home/models/widget-component.models.ts#L274%22) 描述：参考 Angular 的 `IDynamicWidgetComponent`。 当组件是用 Angular 可以修改组件的属性。

### width

类型： Number 描述：当前部件容器的宽 单位 像素

### height

类型： Number 描述：当前部件容器的高 单位 像素

### isEdit

类型： Boolean 描述：表明dashboard是否能够在查看与编辑实体之间切换

### isMobile

类型： Boolean 描述：表明dashboard能否在手机模式，低于996px宽的屏幕下显示

### widgetConfig

类型：[WidgetConfig](https://github.com/thingsboard/thingsboard/blob/13e6b10b7ab830e64d31b99614a9d95a1a25928a/ui-ngx/src/app/shared/models/widget.models.ts#L341) 描述：公共的部件配置属性，如 文本颜色，部件的背景颜色，等。

### settings

类型： Object 描述：包含部件特殊配属属性的对象，由[settings json schema](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#settings-schema-section)定义

### datasources

类型： Array<datasource style="box-sizing: border-box; margin: 0px; padding: 0px; list-style: none;"> 描述：部件的数据源， 格式请看[Subscription object](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#subscription-object)</datasource>

```
 datasources = [
        {  // datasource
           type: 'entity',// type of the datasource. Can be "function" or "entity"
           name: 'name', // name of the datasource (in case of "entity" usually Entity name)
           aliasName: 'aliasName', // name of the alias used to resolve this particular datasource Entity
           entityName: 'entityName', // name of the Entity used as datasource
           entityType: 'DEVICE', // datasource Entity type (for ex. "DEVICE", "ASSET", "TENANT", etc.)
           entityId: '943b8cd0-576a-11e7-824c-0b1cb331ec92', // entity identificator presented as string uuid. 
           dataKeys: [ //  array of keys (Array<DataKey>) (attributes or timeseries) of the entity used to fetch data 
               { // dataKey
                    name: 'name', // the name of the particular entity attribute/timeseries 
                    type: 'timeseries', // type of the dataKey. Can be "timeseries", "attribute" or "function" 
                    label: 'Sin', // label of the dataKey. Used as display value (for ex. in the widget legend section) 
                    color: '#ffffff', // color of the key. Can be used by widget to set color of the key data (for ex. lines in line chart or segments in the pie chart).  
                    funcBody: "", // only applicable for datasource with type "function" and "function" key type. Defines body of the function to generate simulated data.
                    settings: {} // dataKey specific settings with structure according to the defined Data key settings json schema. See "Settings schema section".
               },
               //...
           ]
        },
        //...
    ]
```

### data

类型： Array<datasourcedata style="box-sizing: border-box; margin: 0px; padding: 0px; list-style: none;"> 描述：部件最新的数据源，格式请看[Subscription object](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#subscription-object)</datasourcedata>

```js
  data = [
        {
            datasource: {}, // datasource object of this data. See datasource structure above.
            dataKey: {}, // dataKey for which the data is held. See dataKey structure above.
            data: [ // array of data points
                [   // data point
                    1498150092317, // unix timestamp of datapoint in milliseconds
                    1, // value, can be either string, numeric or boolean  
                ],
                //...
            ]  
        },
        //...
    ]    
```

### timeWindow

类型： WidgetTimewindow 描述： 当前小部件时间窗口（适用于timeseries小部件）。保存有关当前时间窗口边界的信息。minTime—以UTC毫秒为单位的最小时间，maxTime—以UTC毫秒为单位的最大时间，interval—以毫秒为单位的当前聚合间隔。

### units

类型： String 描述：可选属性定义小部件显示的值的文本单位。对于卡片或仪表等简单的小部件非常有用。

### decimals

类型： Number 描述：可选属性，保留几位小数点，定义应使用多少位置来显示值数字的小数部分。

### hideTitlePanel

类型： Boolean 描述：管理小部件标题面板的可见性。对于具有自定义标题面板或不同状态的小部件非常有用。此属性更改后必须调用`updateWidgetParams()`函数。

### widgetTitle

类型： String 描述：如果设置，将覆盖配置的小部件标题文本。此属性更改后必须调用`updateWidgetParams()`函数。

### detectChanges()

类型： Function 描述：触发当前小部件的更改检测。必须在由于小部件数据更改而更新小部件HTML模板绑定时调用。

### updateWidgetParams()

类型： Function 描述：更新部件运行时设置的属性如 `WidgeTitle`、`hideTitlePanel` ，必须调用改方法才能生效。

### defaultSubscription

类型： IWidgetSubscription 描述：根据小部件类型，默认小部件订阅对象包含所有订阅信息，包括当前数据。请参见[Subscription object](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#subscription-object)。

### timewindowFunctions

类型：TimewindowFunctions 描述：一组`tiemwidnows`函数对象，常用于管理部件的数据，也可以用于time-series，和报警部件，请参见时间窗口函数。

### controlApi

类型： RpcApi 描述：提供的操作 RPC 部件的 API 函数，请参见[Control API]()

### actionsApi

类型： WidgetActionsApi 描述：设置可用的 API 函数，提供给用户定义行为。 请参见[Actions API](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#actions-api)

### stateController

类型： IStateController 描述：用于管理 dashboard 的状态管理，请参见 [State Controller](https://thingsboard.io/docs/user-guide/contribution/widgets-development/#state-controller)。

## 部件库基本JS函数API解释，及变量的使用，显示

### 前言

上一篇TB教程我们讲解了部件库的一些基本API，这些API大多是静态的变量，当如果我们要开发更为复杂的部件，还需要知道部件提供的JS 接口。 为了实现一个新的部件，我们还需要一些JavaScript让部件的功能更加强大，比如为按钮添加一个点击事件，比如监听部件的大小改变，以及或我们的部件配置数据。 这些函数是可选的，你可以使用，也可以不使用。每一个函数都实现了一个部件的特殊行为，下面我们一起来认识一下这些函数吧。

### onInit()

部件加载完毕后第一个触发的函数，用于部件的初始化。在触发该函数时，表明部件的dom已经准备好，可以放心地获取，使用dom元素。可以在该函数里 处理小部件设置和初始订阅信息。比如为一个按钮增加一个点击事件。

### onDataUpdated()

当部件订阅的数据更新或会触发该函数，最新的数据（由defaultSubscription object定义的）能够被访问从部件的上下文里。 如下图的报警表格，就是使用了该方法。才能保证显示最新的数据。

### onResize()

当组件调整了大小后，该函数会被触发。最新的height，width将被赋值到 部件的上下中 ctx中。 下图的控制面板，就是使用了该函数，能够保证控制台能够跟随窗口缩放改变大小。

### onEditModeChanged()

当仪表盘编辑模式被改变时调用，最新的模式被`ctx` 的 `isEdit` 函数接收

### onMobileModeChanged()

当仪表盘的宽度低于手机的像素值时，会触发该函数，最新的状态被ctx 中的`isMobile` 属性接收。

### onDestroy()

当部件的节点被销毁是触发，应该在此函数里清空所有不必要的资源。

### getSettingsSchema()

改函数会返回一个部件设置的json对象，它是在 Setting tab中设置的 Settings schema section。

### getDataKeySettingsSchema()

可选函数，从 Settings schema section. 对象中， 返回一个特定key的数据。

### typeParameters()

返回部件类型的参数。用于描述部件数据源的参数。 请参阅 Type parameters object.

### actionSources()

返回一个map对象，用于定义部件的额外操作，有用户定义的。 请参阅 Action sources object.

下面演示一下如何将数据显示在html中，创建一个静态页面的组件。 html

```html
<div>
    <div *ngFor="let dataKeyData of testdata" >
         <p>name: {{dataKeyData.name}}</p>
         <p>age: {{dataKeyData.age}}</p>
         <p>sex: {{dataKeyData.sex}}</p>
    </div>
</div>
```

```js
self.onInit = function() {
    self.ctx.$scope.testdata = [
        {name: 'fizz', age:29, sex:'meal'}
     ]
}
```

编辑完成后，点击保存。 就会显示以下页面。

这里涉及一点点 angular 的技术， 在 html 中展示一个变量需要使用 `{{变量名}}` 这种写法。 当然变量并必须被声明在 `self.ctx.$scope` 下

遍历一个数组使用 `*ngFor="let dataKeyData of testdata"` `testdata` 是 `self.ctx.$scope` 下的变量。`dataKeyData` 是每一个资源

如果你要为某一个`div`或者`button` 增加点击事件，那么就比较麻烦，需要在部件的高级功能中增加`action`。
