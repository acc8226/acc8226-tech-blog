---
title: 结构型-Proxy
date: 2021-06-14 10:25:35
updated: 2021-06-14 10:25:35
categories:
  - 设计模式
tags: 设计模式
---

代理模式（Proxy Design Pattern）的原理和代码实现都不难掌握。它在不改变原始类（或叫被代理类）代码的情况下，通过引入代理类来给原始类附加功能。

1. 代理模式的原理与实现
在不改变原始类（或叫被代理类）的情况下，通过引入代理类来给原始类附加功能。一般情况下，我们让代理类和原始类实现同样的接口。但是，如果原始类并没有定义接口，并且原始类代码并不是我们开发维护的。在这种情况下，我们可以通过让代理类继承原始类的方法来实现代理模式。

2. 动态代理的原理与实现
静态代理需要针对每个类都创建一个代理类，并且每个代理类中的代码都有点像模板式的“重复”代码，增加了维护成本和开发成本。对于静态代理存在的问题，我们可以通过动态代理来解决。我们不事先为每个原始类编写代理类，而是在运行的时候动态地创建原始类对应的代理类，然后在系统中用代理类替换掉原始类。

3. 代理模式的应用场景
代理模式常用在业务系统中开发一些非功能性需求，比如：监控、统计、鉴权、限流、事务、幂等、日志。我们将这些附加功能与业务功能解耦，放到代理类统一处理，让程序员只需要关注业务方面的开发。除此之外，代理模式还可以用在 RPC、缓存等应用场景

**什么时候使用接口，什么时候使用继承**
参照基于接口而非实现编程的设计思想，将原始类对象替换为代理类对象的时候，为了让代码改动尽量少，在刚刚的代理模式的代码实现中，代理类和原始类需要实现相同的接口。但是，如果原始类并没有定义接口，并且原始类代码并不是我们开发维护的（比如它来自一个第三方的类库），我们也没办法直接修改原始类，给它重新定义一个接口。在这种情况下，对于这种外部类的扩展，我们一般都是采用继承的方式。这里也不例外。我们让代理类继承原始类，然后扩展附加功能。

<!-- more -->

## 普通代理

直接上代码

interface IUserController 
```java
package proxy;


public interface IUserController {
  void login(String telephone, String password);
  void register(String telephone, String password);
}
```

class UserController
```java
package proxy;

public class UserController implements IUserController {

  public void login(String telephone, String password) {
    // ... 省略login逻辑...
	  System.out.println("login ...");
  }

  public void register(String telephone, String password) {
    // ... 省略register逻辑...
	  System.out.println("register ...");
  }
  
}
```

class UserControllerProxy
```java
package proxy;

import java.time.Instant;

public class UserControllerProxy implements IUserController {
	
  private IUserController userController;

  public UserControllerProxy(IUserController userController) {
    this.userController = userController;
  }

  @Override
  public void login(String telephone, String password) {
	System.out.println("-----使用了普通代理-----");

    long startTimestamp = Instant.now().toEpochMilli();

    // 委托
    userController.login(telephone, password);

    long endTimeStamp = Instant.now().toEpochMilli();
    long responseTime = endTimeStamp - startTimestamp;
    System.out.println(responseTime);
  }

  @Override
  public void register(String telephone, String password) {
	System.out.println("-----使用了普通代理-----");
    long startTimestamp = Instant.now().toEpochMilli();

    userController.register(telephone, password);

    long endTimeStamp = Instant.now().toEpochMilli();
    long responseTime = endTimeStamp - startTimestamp;
    System.out.println(responseTime);
  }
}
```

## 动态代理

所谓动态代理（Dynamic Proxy），就是我们不事先为每个原始类编写代理类，而是在运行的时候，动态地创建原始类对应的代理类，然后在系统中用代理类替换掉原始类。那如何实现动态代理呢？

示例代码

class UserControllerInvocationHandler
```java
package proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.time.Instant;

public class UserControllerInvocationHandler implements InvocationHandler {
	
	private Object proxiedObject;

	public UserControllerInvocationHandler(Object proxiedObject) {
		this.proxiedObject = proxiedObject;
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		System.out.println("-----使用了动态代理-----");
		Object invoke;
		String methodName = method.getName();
		if (methodName.equals("login") || methodName.equals("register")) {
			long startTimestamp = Instant.now().toEpochMilli();
			invoke = method.invoke(this.proxiedObject, args);
			long endTimeStamp = Instant.now().toEpochMilli();
			long responseTime = endTimeStamp - startTimestamp;
			System.out.println(responseTime);
		} else {
			invoke = method.invoke(this.proxiedObject, args);
		}
		return invoke;
	}

}
```

Main 调用类
```java
package proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public class Main {
	
	public static void main(String[] args) {
		IUserController controller = new UserController();		
		// 静态代理
		IUserController controllerProxy = new UserControllerProxy(new UserController());
		controllerProxy.register("lisi", "666666");
		
		// 动态代理
		ClassLoader loader = controller.getClass().getClassLoader();
        Class<?>[] interfaces = controller.getClass().getInterfaces();
        InvocationHandler handler = new UserControllerInvocationHandler(controller);
		IUserController proxy = (IUserController) Proxy.newProxyInstance(loader, interfaces, handler);
		proxy.register("wangwu", "111");
	}

}
```

## 更多

Proxy 只能对 interface 进行代理，无法实现对 class 的动态代理。观察动态生成的代理继承关系图可知原因，他们已经有一个固定的父类叫做 Proxy，Java语法限定其不能再继承其他的父类。要实现对 class 的动态代理，可以使用 CGLIB。

CGLIB是一个强大的、高性能的代码生成库。其被广泛应用于 AOP 框架（Spring、dynaop）中，用以提供方法拦截操作。Hibernate 作为一个比较受欢迎的ORM框架，同样使用 CGLIB 来代理单端（多对一和一对一）关联（延迟提取集合使用的另一种机制）。CGLIB 作为一个开源项目，其代码托管在github，地址为：[https://github.com/cglib/cglib](https://github.com/cglib/cglib)

相关资料
* https://docs.oracle.com/javase/8/docs/technotes/guides/reflection/proxy.html
* https://www.baeldung.com/java-dynamic-proxies

## 参考

设计模式之美_设计模式_代码重构-极客时间
https://time.geekbang.org/column/intro/250
