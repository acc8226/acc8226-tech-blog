Groovy 是基于 JVM 虚拟机的一种动态语言，它的语法和 Java 非常相似，由 Java 入门Groovy，基本上没有任何障碍。Groovy 完全兼容 Java，又在此基础上增加了很多动态类型和灵活的特性，比如支持闭包，支持 DSL，可以说它是一门非常灵活的动态脚本语言。

Groovy 的特性虽然不多，但也有一些，我们不可能在这里都讲完，这也不是这本书的初衷，在这里我挑一些和Gradle有关的知识讲，让大家很快的入门 Groovy，并且能看懂这门脚本语言，知道在Gradle为什么这么写。其次是每个 Gradle 的 build 脚本文件都是一个 Groovy 脚本文件，你可以在里面写任何符合 Groovy 的代码，比如定义类，生命函数，定义变量等等，而 Groovy 又完全兼容Java，这就意味着你可以在build脚本文件里写任何的Java代码，非常灵活方便。

## 字符串

字符串，每一门语言都会有对字符串的处理，Java 相对要稍微复杂一些，限制比较多，相比而言，Groovy 非常方便，比如字符串的运算、求值、正则等等。

从现在开始我们算是正式的介绍 Groovy 了，在此之前我们先要知道，在 Groovy 中，分号不是必须的。相信很多用 Java 的朋友都习惯了，每一行的结束必须有分号，但是 Groovy 没这个强制规定，所以你看到的 Gradle 脚本很多都没有分号，其实这个是 Groovy 的特性，而不是 Gradle 的。没有分号的时候，我们阅读的时候每一行默认为有分号就好了。

在Groovy中，**单引号和双引号**都可以定义一个字符串常量（Java里单引号定义一个字符），不同的是单引号标记的是纯粹的字符串常量，而不是对字符串里的表达式做运算，但是双引号可以。

* 单引号没有运算的能力，它里面的所有都是常量字符串。
* 双引号可以直接进行表达式计算的这个能力非常好用，我们可以用这种方式进行字符串链接运算，再也不用 Java 中繁琐的 +号了。**记住这个嵌套的规则，一个美元符号紧跟着一对花括号，花括号里放表达式**，比如`${name}`,`${1+1}`等等，**只有一个变量的时候可以省略花括号**，比如 `$name`。

```groovy
task printStringVar << {
    def str1 = "我是火车王"
    println"$str1"
    println"${str1}, 谁敢召唤我, 你想借个${str1}"
}
```

## 集合

集合，也是我们在 Java 中经常用到的，Groovy 完全兼容了 Java 的集合，并且进行了扩展，使得生命一个集合，迭代一个集合、查找集合的元素等等操作变得非常容易。常见的集合有 List、Set、Map 和 Queue，这里我们只介绍常用的 List 和 Map。

### List

```groovy
task list << {
    def list = [1, 3, 5, 7, 9]

    println list.getClass().name
    println list[0]
    println list[-1]//访问最后一个元素
    println list[-2]//访问倒数第二个元素
    println list[1..3]//访问第2到第4个元素

    // it 变量就是正在迭代的元素，这里有闭包的知识
    list.each {
        println it
    }
}
```

### Map

``` groovy
task map << {
    def map = ['width': 1366, 'height': 768]

    println map.getClass().name
    // 以下下方式都能快速的取出指定key的值
    println map.width
    println map["height"]

    map.each{
        println "${it.key}: ${it.value}"
    }
}
```

对于集合，Groovy 还提供了诸如 collect、find、findAll 等便捷的方法，有兴趣的朋友可以找相关文档。

### 方法

* 括号是可以省略的
* return是可以不写的

```groovy
task testMethod <<{
    def i1 = 12
    def i2 = 67

    //括号, 分号都不要了
    printSum i1, i2

    def maxResult = getMax i1, i2
    println maxResult
}

// 无 return
def printSum(int i1, int i2){
    println i1+i2
}

// 有 return 值, 为最后一句为返回值
def getMax(int i1, int i2) {
    def max = i1;
    if (i2 > i1) {
        max = i2;
    }
    "max is $max"
}
```

**代码块是可以作为参数传递的**
代码块--一段被花括号包围的代码，其实就是我们后面要将的闭包，Groovy 是允许其作为参数传递的，但是结合这我们上面方法的特性，最后的基于闭包的方法调用就会非常优雅、易读。以我们的集合的each方法为例，它接受的参数其实就是一个闭包。

![](http://upload-images.jianshu.io/upload_images/1662509-72f3bfd7fbf9e588.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### JavaBean

```groovy
task testJavaBean << {
    Person p = new Person();
    p.name = "砰砰博士"

    println p.name
    println "${p.name}"
    println "${p.age}"
    println "${p.brand}" //能这么用, 其实只是因为该对象里定义了相应的getter/setter方法而已
}

class Person {
    String name;
    private int age;

    public String getBrand(){
        'hearthstone'
    }
}
```

## 闭包

闭包是 Groovy 的一个非常重要的特性，可以说他是 DSL 的基础。闭包不是 Groovy 的首创，但是它支持这一重要特性，这就使用我们的代码灵活、轻量、可复用，再也不用像Java一样动不动就要搞一个类了，虽然 Java 后来有了匿名内部类，但是一样冗余不灵活。

### 初识闭包

前面我们讲过，闭包其实就是一段代码块，下面我们就一步步实现自己的闭包，了解闭包的it变量的由来。集合的 each 方法我们已经非常熟悉了，我们就以其为例，实现一个类似的闭包功能。

![](http://upload-images.jianshu.io/upload_images/1662509-a0a4d0333795d2db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在上面的例子中我们定义了一个方法 customEach，它只有一个参数，用于接收一个闭包（代码块），那么这个闭包如何执行呢？很简单，跟一对括号就是执行了，会 JavaScript 的朋友是不是觉得很熟悉，把它当做一个方法调用，括号里的参数就是该闭包接收的参数，如果只有一个参数，那么就是我们的 it 变量了。

### 向闭包传递参数

当闭包有一个参数时，默认就是it；当有多个参数是，it就不能表示了，我们需要把参数一一列出。

```groovy
task helloClosure << {
    customEachMap{k,v ->
        println "${k}: ${v}"
    }
}

def customEachMap(closure) {
    def map1 = ['张三': 18, '李四': 20, '老五': 25]
    map1.each{
        closure it.key, it.value
    }
}
```

### 闭包委托

Groovy 闭包的强大之处在于它支持闭包方法的委托。Groovy 的闭包有 thisObject、owner、delegate 三个属性，当你在闭包内调用方法时，由他们来确定使用哪个对象来处理。默认情况下 delegate 和 owner 是相等的，但是 delegate 是可以被修改的，这个功能是非常强大的，Gradle 中的很闭包的很多功能都是通过修改 delegate 实现的。

```groovy
task testDelegate << {

    new Delegate().test{
        println thisObject.getClass().name
        println owner.getClass().name
        println delegate.getClass().name

        method1()
        it.method1()
    }
}

def method1(){
    println "Context this: ${this.getClass().name} in root, method1 in root"
}

class Delegate{

    def method1(){
        println "Context this: ${this.getClass().name} in Delegate, method1 in Delegate"
    }

    def test(Closure<Delegate> closure){
        closure(this)
    }

}
```

运行我们可以看到输出：

![](http://upload-images.jianshu.io/upload_images/1662509-f46f3240cbd3f674.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

闭包内方法的处理顺序是thisObject > owner > delegate。

## DSL

DSL(Domain Specific Language),领域特定语言，说白了就是专门关注某一领域专门语言，在于专，而不是全，所以才叫领域特定的，而不是像 Java 这种通用全面的语言。

Gradle 就是一门 DSL，他是基于 Groovy 的，专门解决自动化构建的 DSL。自动化构建太复杂、太麻烦、太专业，我们理解不了，没问题，专家们就开发了 DSL--Gradle，我们作为开发者只要按照 Gradle DSL 定义的，书写相应的 Gradle 脚本就可以达到我们自动化构建的目的，这也是 DSL 的初衷。

DSL 涉及的东西还有很多，这里我们简单的提一下概念，让大家有个了解，关于这方便更详细的可以阅读世界级软件开发大师 Martin Fowler 的《领域特定语言》，这本书介绍的非常详细。

## 参考

本文纯属自学历程 + 一些记录，绝大部分内容来自原书 [Android Gradle权威指南](https://yuedu.baidu.com/ebook/14a722970740be1e640e9a3e)。觉得对你有用，请支持原书。
