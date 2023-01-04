上一章我们已经介绍了 Gradle 脚本的基础，在其中我们也强调了 Gradle 中最要的 Projects 和 Tasks这两个概念，尤其是Tasks，我们的所有 Gradle 的构建工作都是由 Tasks 组合完成的，那么这一章我们就详细的介绍下 Tasks--任务。
任务的介绍也是从实用性出发，比如如何多种方式创建任务，如果访问任务的方法和属性等信息，如果对任务进行分组、排序，以及任务的一些规则性知识。

第一种是直接以一个任务名字创建任务的方式：

```groovy
//1:
def Task createTask1 = task(creatTask1)
//配置doLast方法
creatTask1.doLast{
    println "创建方法原型: Task task(String name)"
}
```

第二种是以一个任务名字 + 一个对该任务配置的Map对象来创建任务：

```groovy
//2: 任务名字 + 该任务配置的Map
def Task createTask2 = task(createTask2, group: BasePlugin.BUILD_GROUP)
createTask2.doLast{
    println "任务分组: ${createTask2.group}"
}
```

和第一种方式大同小异，只是多了一个 Map 参数，用于对要创建的Task进行配置，比如我们例子里为其指定了分组为 BUILD，我们通过执行该任务可以看到我们的配置其了作用。

![Map中可用的配置](http://upload-images.jianshu.io/upload_images/1662509-d0ae9297018a7c9f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

第三种方式就是任务名字+闭包配置的方式：

![](http://upload-images.jianshu.io/upload_images/1662509-5db9aaddb91590b3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

因为Map传参配置的方式（第二种）毕竟可配置的项有限，所以可以通过闭包的方式进行更多更灵活的配置，闭包里的委托对象就是 Task，所以你可以使用 Task 对象的任何方法、属性等信息进行配置，比如示例中我们配置了任务的描述和任务执行后要做的事情。

Project 中还有一种名字 + Map 参数 + 闭包的的方式，和上面演示的非常相似，就不列出了，下面我们说下 TaskContainer 创建任务的方式。如果我们去看 Project 对象中关于上面我们演示的 task 方法的源代码，就会发现其实他们最终都是调用 TaskContainer 对象中的create 方法，其参数和 Project 中的 task 方法基本一样，我们下面看例子，我们使用这种方式重写第三种方式的例子：

![](http://upload-images.jianshu.io/upload_images/1662509-07e5eadb7d9e62c9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**tasks 是 Project 对象的属性**，其类型是 TaskContainer，我们可以使用它来直接创建任务。对于关于 TaskContainer 其他几种创建方式和前面演示的 Project 的 task 方法基本上一样，就不一一写示例了，大家可以参考上面的练习写一下。

### 4.2 多种方式访问任务

首先呢，我们创建的任务都会作为项目(Project)的一个属性，属性名就是任务名，所以我们可以直接通过该任务名访问和操纵该任务：

通过索引访问的时候，任务名就是我们 Key（关键索引），其实这里说 key 不恰当，因为t asks 并不是一个 Map，这里再顺便扩展下 Groovy 的知识，[]在Groovy中是一个操作符，我们知道Groovy的操作符都有对应的方法让我们重载，a[b]对应的是 a.getAt(b)这个方法.

```groovy
//直接通过该任务名访问和操纵该任务
task creatTask1{
    doLast{
        println 'doLast'
    }
}

tasks['creatTask1'].doLast{
    //通过路径访问, find找不到会返回null, 而get找不到会抛异常
    println tasks.findByPath(':creatTask1')
    //通过名字访问，通过的名称的访问也有get和find两种，区别和路径访问方式一样。
    println tasks.findByName('creatTask1')
}
```

值得强调的时候，通过路径访问的时候，参数值可以是任务路径也可以是任务的名字，但是通过名字访问的时候，参数值只能是任务的名字，不能为路径。
通过以上几种方式我们发现访问 Gradle 的任务非常方便，当我们拿到这个任务的引用的时候，我们就可以按我们的业务逻辑去操纵它，比如配置任务依赖，配置任务的一些属性，调用方法呢，这是Ant做不到的，这也是Gradle的灵活之处。

### 4.3 任务分组和描述

任务是可以分组和添加描述的，**任务的分组**其实就是对任务的分类，便于我们对任务进行归类整理，清晰明了。**任务的描述**就是说明这个任务有什么作用，是这个任务的大概说明。

建议大家创建任务的时候，这两个都要进行配置，便于其他人在看到的时候能很快的了解你定义任务的分类和通途。

```groovy
def Task myTask = task task1
myTask.description = '这是一个构建的引导任务'
myTask.group = BasePlugin.BUILD_GROUP
myTask.doLast{
    println "group: ${group}, desc: ${description}"
}
```

### 4.4 << 操作符

详细读者们已经看到了我们很多例子中使用了这个操作符，这一小节我们就从源代码的角度来讲解下这个操作符，让大家对它有个更深入的了解。
<<操作符在 Gradle 的 Task 上是 doLast 方法的短标记形式，也就是说<<可以代替doLast

![](http://upload-images.jianshu.io/upload_images/1662509-3ff6a7cf71d52a50.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

过时了吧

### 4.5 任务的执行分析

当我们执行一个Task的时候其实就是执行其拥有的 Actions 列表，这个列表保存在Task对象实例中的actions成员变量中，其类型是一个List。

![](http://upload-images.jianshu.io/upload_images/1662509-ac9098554499f701.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接下来看实例

```groovy
Task task1 = task(task1, type: CustomTask)
task1.doFirst{
    println "doFirst"
}
task1.doLast{
    println "doLast"
}
task1.doFirst{
    println "new doFirst"
}

class CustomTask extends DefaultTask{
    @TaskAction
    def doSelf(){
        println 'doself'
    }
}
```

![Output](http://upload-images.jianshu.io/upload_images/1662509-141a96e9aac9773c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

结果和我们期望的一样。我们前面讲了，执行Tasks的时候就是在遍历执行 actions List，那么要达到这种 doFirst、doSelf、doLast 顺序的目的，就必须把 doFirst 的 Action s放在 actions List 的最前面，把 doSelf 的 Actions 放在 List 中间，把doLast的Actions放在List最后面，这样才能达到按约定顺序执行的目的。

当我们使用 task 方法创建task1这个任务的时候，Gradle会解析其带有TaskAction标注的方法作为其Task执行的Action，然后通过Task的prependParallelSafeAction方法把该Action添加到actions List里：

![](http://upload-images.jianshu.io/upload_images/1662509-f291b3a5a12702c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![doFirst和doLast这两个方法的实现代码](http://upload-images.jianshu.io/upload_images/1662509-774ae1559a6c0d01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
doFirst永远都是在actions List第一位添加，保证其添加的Action在现有actions List元素的最前面，doLast 永远都是在actions List末尾添加，保证其添加的Action在现有actions List元素的最后面。一个往最前面添加，一个往最后面添加，最后这个actions List按顺序就形成了 doFirst、doSelf、doLast 三部分的 Actions，就达到的 doFirst、doSelf、doLast 三部分的Actions顺序执行的目的。

这一小结是基于源代码对Task执行的分析，可能有点难，但是我还是建议大家仔细看，一遍看不懂多看几遍，结合着例子和源代码看，理解了对整个 Task 的执行就熟悉的多了。

### 4.6 任务排序

其实并没有真正的任务排序功能，这个排序不像我们想象的通过设置优先级或者Order顺序实现，而是通过任务的shouldRunAfter和mustRunAfter这两个方法来显示的，他们可以控制一个任务一定或者应该在某个任务之后执行，通过这种方式你可以在某些情况下控制任务的执行顺序，而不是通过强依赖的方式。

这个功能是非常有用的，比如我们公司自己设置的必须先执行单元测试，才能进行打包，这就保证了 App 的质量。类似情况还有很多，比如必须要单元测试之后才能进行集成测试；打包成功之后才能进行部署发布等。

**taskB.shouldRunAfter(taskA)** 表示 taskB 应该在 taskA 执行之后执行，这里的应该而不是必须，所以有可能任务顺序并不会按预设的执行。
**taskB.mustRunAfter(taskA)** 表示 taskB 必须在 taskA 执行之后执行，这个规则就比较严格。

```groovy
task task1{
    doLast{
        println 'task1.doLast'
    }
}

task task2{
    doLast{
        println 'task2.doLast'
    }
}

task2.mustRunAfter(task1)
```

然后在此执行`./gradlew  task2 task1`，查看输出

![](http://upload-images.jianshu.io/upload_images/1662509-bc69055cf28ccc85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个排序目前还属于 Beta 版，以后的 Gradle 版本可能会有变动，但是如果正好项目中遇到了类似的情况，不妨试试，很有用。

### 4.7 任务的启用和禁用

Task 中有个 enabled 属性，用于启用和禁用任务，默认是 true 表示启用的，设置为 false 则禁止该任务执行，输出会提示该任务被跳过.

![](http://upload-images.jianshu.io/upload_images/1662509-6d17d60f2aa7cfd4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在某些情况下可以通过该属性灵活的控制任务的执行，这种方式需要在执行到具体逻辑的时候才能进行判断设置，下面我们讲一种提前设置条件的方式来控制任务执行还是跳过。

### 4.8 任务的 onlyIf 断言

断言就是一个条件表达式，Task有一个 onlyIf 方法，它接受一个闭包作为参数，如果该闭包返回true则该任务执行，否则则跳过。这有很多用途，比如控制哪些情况下打什么包，什么时候执行单元测试，什么情况下执行单元测试的时候不执行网络c而是等等，现在就以一个打首发包的例子来说明。

假如我们的首发渠道是应用宝和百度，直接执行 build 会编译出来所有包，这个太慢也不符合我们的需求，现在我们就采用onlyIf的方式通过属性来控制：
**略**

### 4.9 任务规则

我们通过以上章节知道了我们创建的任务都在 TaskContainer 里，是由其进行管理的。所以我们当我们访问任务的时候时候都是通过TaskContainer进行访问，而 TaskContainer又是一个NamedDomainObjectCollection（继承它），所以我们说的任务规则其实是NamedDomainObjectCollection的规则。

NamedDomainObjectCollection是一个具有唯一不变名字的域对象的集合，它里面所有的元素都有一个唯一不变的名字，该名字是String类型，所以我们可以通过名字获取该元素，比如我们通过任务的名字获取该任务。

说完唯一不变的名字，我们再说规则，NamedDomainObjectCollection 的规则有什么用呢？我们上面说了要想获取一个NamedDomainObjectCollection 的元素是通过一个唯一的名字获取的，那么这个唯一的名字可能在 NamedDomainObjectCollection 中并不存在，具体到任务中就是说你想获取的这个任务不存在，这时候就会调用我们添加的规则来处理这种异常情况，我们看下源代码：

![](http://upload-images.jianshu.io/upload_images/1662509-30925dabf635a35f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以名字查找的时候，如果没有找到则调用applyRules(name)应用我们添加的规则。
我们可以通过调用addRule来添加我们自定义的规则，它有两个用法：

![](http://upload-images.jianshu.io/upload_images/1662509-bdb668ab43a2a984.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一个是直接添加一个 Rule，一个是通过闭包配置成一个 Rule 再添加，两种方式大同小异，如果仔细观察你会发现，Gradle中基本上都是这种写法，成对出现。

当我们执行、依赖一个不存在的任务时，Gradle 会执行失败，失败信息是任务不存在，我们使用规则对其进行改进，当执行、依赖不存在的任务时，不会执行失败，而是打印提示信息提示该任务不存在：

![](http://upload-images.jianshu.io/upload_images/1662509-ebfc4fbd5720ee5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

此外它还可以根据不同的规则动态创建需要的任务等情况。

- - -

本文属自学历程, 仅供参考
详情请支持原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)
