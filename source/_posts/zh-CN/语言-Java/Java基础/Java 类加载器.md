什么是 ClassLoader
ClassLoader 简称类加载器，主要用于加载和校验编译后的 Java 文件(即：以.class结尾的文件)；

有哪些类加载器(ClassLoader)
AppClassLoader(应用类加载器)
ExtClassLoader(扩展类加载器注意：JDK1.8后被修改为平台类加载器)
BootstrapClassLoader(启动类加载器)

获取类加载器
通过简单的 demo 来得到类加载器

```java
public class User {
    public static void main(String[] args) {
        User user = new User();
        Class<? extends User> userClass = user.getClass();
        System.out.println(userClass.getClassLoader());
        System.out.println(userClass.getClassLoader().getParent());
        System.out.println(userClass.getClassLoader().getParent().getParent());
    }
}
```

结果显示：
`sun.misc.Launcher$AppClassLoader@73d16e93`
`sun.misc.Launcher$ExtClassLoader@15db9742`
`null` 这里涉及到底层所以返回null

类加载器的加载顺序
由于当前的类加载器使用双亲模式

首先加载系统类加载器，此时系统类加载器会判断当前类是否已近是当前系统已定的类，如果是加载系统类，不会初始化被加载的类，不存在则由 ExtClassLoader 加载
ExtClassLoader 检测加载，一般都是 lib 包中，不存在则交给 AppClassLoader 加载
AppClassLoader 检测加载类，当前应用加载器会从当前应用中(就是启动类或者整个程序中)查找需要加载的类，存在即加载程序的类，不存在交给用户定义的类加载器处理
使用双亲模式的好处，可以保护 Java 程序的安全，防止非法的加载 Class

用户可以使用自定义类加载器用来实现对不同位置的类的加载和调用

```sh
mkdir -p aa/bb
vim aa/bb/Hello.java
javac aa/bb/Hello.java
```

Hello.java 代码

```java
package aa.bb;

public class Hello {

    static {
        System.out.println("init ...");
    }
}
```

自定义类加载器

```sh
mkdir -p aa/classloader
vim aa/classloader/MyClassLoader.java
javac -Xlint:deprecation aa/classloader/MyClassLoader.java
```

MyClassLoader.java 代码

```sh
package aa.classloader;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;

public class MyClassLoader extends ClassLoader {

    private String path;

    public MyClassLoader(String path) {
        this.path = path;
    }

    @Override
    public Class<?> findClass(final String name) throws ClassNotFoundException {
        final String classPath = path + "/" + name.replace(".","/") + ".class";
        try (InputStream in = new FileInputStream(classPath);
        ByteArrayOutputStream out = new ByteArrayOutputStream();) {
            int len;
            byte[] bytes = new byte[4096];
            while ((len = in.read(bytes)) != -1) {
                out.write(bytes, 0, len);
            }
            byte[] byteArray = out.toByteArray();
            return defineClass(name, byteArray, 0, byteArray.length);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
```

创建测试类  HelloTest.java

```sh
mkdir -p aa/test
vim aa/test/HelloTest.java
javac aa/test/HelloTest.java
```

```java
package aa.test;

import aa.classloader.MyClassLoader;

public class HelloTest {

    public static void main(String[] args) throws Exception {
        String path = HelloTest.class.getClassLoader().getResource("./").getPath();
        MyClassLoader myClassLoader = new MyClassLoader(path);
        Class<?> clazz = myClassLoader.findClass("aa.bb.Hello");
        clazz.newInstance();
    }
}
```

运行结果

```sh
java aa.test.HelloTest

init ...
```

总结：

1. 使用自定义的类加载器的时候需要继承 ClassLoader 来实现 class 的加载
2. 在加载的过程中须要使用 ByteArrayOutputStream 内存流
3. 解析的时候需要使用父类来解析获得二进制信息以此得到Class的信息(必须调用 super.defineClass(fileName, classBytes, 0, classBytes.length);)
4. 使用自定义的类加载器可以没有限制的在其他的地方加载类

## 参考

Java中自定义ClassLoader和ClassLoader的使用非
<https://blog.csdn.net/weixin_45492007/article/details/98875060>
