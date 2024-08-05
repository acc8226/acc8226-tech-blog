---
title: 创建型-Builder
date: 2021-06-14 10:25:35
updated: 2021-06-14 10:25:35
categories:
  - 设计模式
tags: 设计模式
---

**Builder 模式**，中文翻译为建造者模式或者构建者模式，也有人叫它生成器模式。
实际上，建造者模式的原理和代码实现非常简单，掌握起来并不难，难点在于应用场景。

**直接使用构造函数或者配合 set 方法就能创建对象，为什么还需要建造者模式来创建呢？**

* 我们把类的必填属性放到构造函数中，强制创建对象的时候就设置。如果必填的属性有很多，把这些必填属性都放到构造函数中设置，那构造函数就又会出现参数列表很长的问题。如果我们把必填属性通过 set() 方法设置，那校验这些必填属性是否已经填写的逻辑就无处安放了。
* 如果类的属性之间有一定的依赖关系或者约束条件，我们继续使用构造函数配合 set() 方法的设计思路，那这些依赖关系或约束条件的校验逻辑就无处安放了。
* 如果我们希望创建不可变对象，也就是说，对象在创建好之后，就不能再修改内部的属性值，要实现这个功能，我们就不能在类中暴露 set() 方法。构造函数配合 set() 方法来设置属性值的方式就不适用了。

除此之外，在今天的讲解中，我们还对比了工厂模式和建造者模式的区别。工厂模式是用来创建不同但是相关类型的对象（继承同一父类或者接口的一组子类），由给定的参数来决定创建哪种类型的对象。建造者模式是用来创建一种类型的复杂对象，可以通过设置不同的可选参数，“定制化”地创建不同的对象。

**为了解决这些问题，建造者模式就派上用场了。**
使用方法：

1. 将原先的构造私有化，且入参改为 Builder 类型
2. 构建内部类 Builder，一般会选择为静态的
3. Builder暴露 set 方法，方法返回值为自身
4. Builder 类创建 build 方法，可以在这里统一做校验逻辑，包括必填项校验、依赖关系校验、约束条件校验等

**建造者模式和工厂模式都可以创建对象，那它们两个的区别在哪里呢？**
工厂模式是用来创建不同但是相关类型的对象（继承同一父类或者接口的一组子类），由给定的参数来决定创建哪种类型的对象。建造者模式是用来创建一种类型的复杂对象，可以通过设置不同的可选参数，“定制化”地创建不同的对象。

## 示例代码

```java
package build;

public class ResourcePoolConfig2 {
  private String name;
  private int maxTotal;
  private int maxIdle;
  private int minIdle;

  // 私有化构造
  private ResourcePoolConfig2(Builder builder) {
    this.name = builder.name;
    this.maxTotal = builder.maxTotal;
    this.maxIdle = builder.maxIdle;
    this.minIdle = builder.minIdle;
  }

  public static class Builder {

    private static final int DEFAULT_MAX_TOTAL = 8;
    private static final int DEFAULT_MAX_IDLE = 8;
    private static final int DEFAULT_MIN_IDLE = 0;

    private String name;
    private Integer maxTotal = DEFAULT_MAX_TOTAL;
    private Integer maxIdle = DEFAULT_MAX_IDLE;
    private Integer minIdle = DEFAULT_MIN_IDLE;

    public Builder setName(String name) {
      this.name = name;
      return this;
    }

    public Builder setMaxTotal(Integer maxTotal) {
      this.maxTotal = maxTotal;
      return this;
    }

    public Builder setMaxIdle(Integer maxIdle) {
      this.maxIdle = maxIdle;
      return this;
    }

    public Builder setMinIdle(Integer minIdle) {
      this.minIdle = minIdle;
      return this;
    }

    public ResourcePoolConfig2 build() {
      // 校验逻辑放到这里来做，包括必填项校验、依赖关系校验、约束条件校验等
      if (null == name) {
        throw new IllegalArgumentException("name should not be empty.");
      }
      if (maxTotal != null) {
        if (maxTotal <= 0) {
          throw new IllegalArgumentException("maxTotal should be positive.");
        }
      }
      if (maxIdle != null) {
        if (maxIdle < 0) {
          throw new IllegalArgumentException("maxIdle should not be negative.");
        }
      }
      if (minIdle != null) {
        if (minIdle < 0) {
          throw new IllegalArgumentException("minIdle should not be negative.");
        }
      }
      if (maxIdle > maxTotal) {
        throw new IllegalArgumentException("...");
      }
      if (minIdle > maxTotal || minIdle > maxIdle) {
        throw new IllegalArgumentException("...");
      }

      return new ResourcePoolConfig2(this);
    }

  }

}
```

## 参考

* 设计模式之美_设计模式_代码重构-极客时间 <https://time.geekbang.org/column/intro/250>
