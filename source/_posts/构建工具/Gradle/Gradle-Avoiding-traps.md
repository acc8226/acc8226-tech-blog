## [Groovy script variables 4\. Groovy 脚本变量](https://docs.gradle.org/6.3/userguide/potential_traps.html#sec:groovy_script_variables)

对于 Groovy DSL 的用户来说，了解 Groovy 如何处理脚本变量非常重要。 有两种类型的脚本变量。 一个具有本地作用域，另一个具有脚本范围。

### [Example: Variables scope: local and script wide 示例: 变量范围: 本地范围和脚本范围](https://docs.gradle.org/6.3/userguide/potential_traps.html#example_variables_scope_local_and_script_wide)

scope.groovy

```
String localScope1 = 'localScope1'
def localScope2 = 'localScope2'
scriptScope = 'scriptScope'

println localScope1
println localScope2
println scriptScope

closure = {
    println localScope1
    println localScope2
    println scriptScope
}

def method() {
    try {
        localScope1
    } catch (MissingPropertyException e) {
        println 'localScope1NotAvailable'
    }
    try {
        localScope2
    } catch(MissingPropertyException e) {
        println 'localScope2NotAvailable'
    }
    println scriptScope
}

closure.call()
method()
```

Output of 产量groovy scope.groovy
```
> groovy scope.groovy
localScope1
localScope2
scriptScope
localScope1
localScope2
scriptScope
localScope1NotAvailable
localScope2NotAvailable
scriptScope
```

使用类型修饰符声明的变量在闭包中可见，但在方法中不可见。

## [Configuration and execution phase 配置和执行阶段](https://docs.gradle.org/6.3/userguide/potential_traps.html#sec:configuration_and_execution_phase)

记住 Gradle 有一个独特的配置和执行阶段是很重要的(请参阅构建生命周期)。

build.gradle
```
def classesDir = file('build/classes')
classesDir.mkdirs()
task clean(type: Delete) {
    delete 'build'
}
task compile {
    dependsOn 'clean'
    doLast {
        if (!classesDir.isDirectory()) {
            println 'The class directory does not exist. I can not operate'
            // do something
        }
        // do something
    }
}
```

```
> gradle -q compile
The class directory does not exist. I can not operate
```

在配置阶段创建目录时，清理任务会在执行阶段删除目录。
