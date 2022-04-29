## 部件组与部件

所谓的部件组，就是将一组部件整理放到一个群组里，这个群组就是部件组，在tb安装后，官方会有一些默认的部件组，大致有这些。官方想的还是很周到的，知道这东西对于新手有一定的难度，所以给几个例子，让我们学习，好好看看里面的用法。这里的例子都很好，有图表，地图，告警，基础的，高级的都有。

创建部件库只需要点击有右上角的加号即可。

可以导入，也可以新建。

新建只需要填写标题即可，其余的描述与部件库的预览图，可以选填。不过能填写了更好，对于后续查找部件，或者预览部件效果有很好的帮助。

这既是新建部件组。 导入部件组，一般是导入一个json文件。 导入导出是一个很方便的功能，如果要使用别人配置好的部件组，只需要让别人导出给自己，自己导入后就能使用了。非常快捷方便,易于分发。

创建完部件组后，进入部件组的详情，是没有部件的。 下面讲解创建部件。

### 部件的分类

部件的分类大致分为这几类 进入部件组的详情，点击右下角的红色加号 ，就可以新建部件，也可以导入

* Timeseries
* 最新值
* 控件部件
* 警告部件
* 静态部件

在创建时，选择哪一种类型都可以，在进入编辑部件的页面这个可以修改。 只是每一个部件类型，在初始化部件代码时，会采用不用的模板。 如 选择 Timeseries，编辑模板是这样的。

### 静态资源js，css的引入

在部件中 引入 js 资源，与 css 资源也是非常简单的 在右上角的编辑面板中，点击资源标签，点击添加，输入你要在部件中引入的 js，css 路径。即可。

### 编写一个简单的静态部件

好了上面介绍了一些基本操作，下面我们来创建一个简单的静态部件，凡事都是由易到难，由简到繁。 一步一步学，你也能配置，写出超级炫酷的部件库。

那么让我开始吧 首先创建一个静态部件，进入编辑页面。 我将编辑面板分为四个区域。

1 号面板 是html面板，可以添加js，css资源，编写html，编写css
2 号面板 是设置面板 可以设置一些函数，数据建，部件预览效果
3 号面板 是js面板，可以使用js实现一些业务逻辑，处理点击事件，数据转化等
4 号面板 是预览面板，可以预览你的部件效果，不过要在点保存后可以看到，也可以对这个进行编辑。

首先我们清空所有面板的数据， 然后在1号面板引入 jquery 和 bootstrap 的 css

```url
https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js
https://cdn.jsdelivr.net/npm/bootstrap@3/dist/css/bootstrap.min.css
```

在 1 号面板中的 html 标签下，写入以下内容

```html
<div class="my-first-widgets">
    <button type="button" class="btn btn-primary">（首选项）Primary</button>
    <h2>拿我格子衫来</h2>
</div>
```

点击保存，我们就能看到 预览面板的内容改变了。蓝色的按钮就是使用bootstrap的样式来实现的。

说明 bootstrap 的样式确实生效了。 这里就是一个非常简单的静态组件，只是用于展示信息，没有任何业务逻辑处理，和事件处理。

另外对于 css 的处理，我们只需要在第1面板下的css标签下编写即可 比如编写

```css
.my-first-widgets{
    color: red;
    border: 2px dashed  #ddd;
}
```

## 部件库中使用 echarts

echarts 具有丰富，美观的案例，如果能移植到 tb 中，那么对我们开发仪表盘，dashboard 将会事半功倍。下面让我们一起看一下如何在部件库中使用 echarts。

引入 echarts 外部资源

我们创建一个部件库，然后再创建一个部件，进入到部件的编辑页面。 在资源 tab下，引入 echarts.js 地址为 https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js

### 设置容器

`html`面板下，写一个div用于显示图表

```html
<div id="chart-container"></div>
```

创建了div后，还不行，必须要给这个div设置宽高，要不然显示不出图表。 在css面板下写下

```css
#chart-container{
    height: 500px;
    width: 500px;
}
```

### 编写初始化代码

渲染图表的代码是写在js的面板里 首先需要获取图表的容器 使用以下代码

```js
const chartDom = $("#chart-container", self.ctx.$container)[0];
```

我们使用 `self.ctx` 来获取部件的上下文，其中`$container` 代表当前部件的最外层的div。需要图表容器必须要在`self.ctx.$container` 中寻找，此外，我们不必引入`jquery`，官方默认是引入了，直接使用即可。 获取图表容器后下面就很简单了。 定义图表的配置参数 `optinon` js面板的完整代码如下

```js
 self.onInit = function() {
    const chartDom = $("#chart-container", self.ctx
        .$container)[0];
    const myChart = echarts.init(chartDom);
    var option;

    option = {
        // color: ['#5470c6', '#fac858'],
        color: ['#fff', '#fff'],
        legend: {
            data: ['已用产能', '剩余产能']
        },
        xAxis: {
            type: 'category',
            data: ["制芯", "组芯", "熔炼", "浇注", "冷却",
                "落砂", "切割", "抛丸", "打磨", "检测"
            ]
        },
        yAxis: {
            type: 'value',
            axisLabel: {
                formatter: '{value}%'
            }
        },
        series: [{
                name: '已用产能',
                type: 'bar',
                stack: 'total',
                label: {
                    show: true,
                    formatter: '{c}%'
                },
                emphasis: {
                    focus: 'series'
                },
                data: [76, 54, 62, 59, 67, 81,
                    84, 92, 96, 83
                ],
                itemStyle: {
                    decal: {
                        symbol: 'rect',
                        symbolSize: 1,
                        maxTileWidth: 512,
                        maxTileHeight: 512,
                        symbolKeepAspect: true,
                        dashArrayX: [1, 0],
                        dashArrayY: [2, 2],
                        color: '#5470c6',
                        // rotation: 0.5235987755982988
                    }
                }
            },
            {
                name: '剩余产能',
                type: 'bar',
                stack: 'total',
                label: {
                    show: true,
                    formatter: '{c}%'
                },
                emphasis: {
                    focus: 'series'
                },
                data: [24, 46, 38, 41, 33, 19,
                    16, 8, 4, 17
                ],
                itemStyle: {
                    decal: {
                        symbol: 'rect',
                        symbolSize: 1,
                        maxTileWidth: 512,
                        maxTileHeight: 512,
                        symbolKeepAspect: true,
                        dashArrayX: [1, 0],
                        dashArrayY: [2, 2],
                        color: '#fac858',
                    }
                }
            },
        ],
        aria: {
            enabled: true,
            decal: {
                show: true,
            }
        }
    };

    option && myChart.setOption(option);

}
```

这个时候保存后就能看到效果了

### 配置部件库显示到系统首页

我们配置好后如何将这个部件放到首页，让用户一登录系统就能看到。 首先我们需要先找个租户管理员的账号，登录系统 可以使用系统默认的账户 tenant@thingsboard.org / tenant

登录系统后，进入到仪表盘库菜单，点击右上角创建一个`home`仪表盘库。

创建后，点击home那一列，打开 仪表盘的编辑页面

打开仪表盘后，点击添加新的部件

然后选择自己的部件所在的部件库

选择后部件库，还需要选择部件库中的某一个部件。

点击添加即可。然后点右下角的对号保存。

配置完我们的仪表盘库后， 然后进入 Home Setting 的菜单。找到我们刚刚创建的仪表盘库，点击保存。

最后在点击首页，就能看到首页已经变成了我们配置的仪表盘。

这个案例写的比较粗浅，echarts的数据不是动态的，仪表盘的大小不能全屏。 后面我们会讲解更多有关仪表盘的配置项，敬请关注。