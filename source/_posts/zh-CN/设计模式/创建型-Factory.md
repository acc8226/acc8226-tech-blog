一般情况下，工厂模式分为三种更加细分的类型：简单工厂、工厂方法和抽象工厂。不过，在 GoF 的《设计模式》一书中，它将简单工厂模式看作是工厂方法模式的一种特例，所以工厂模式只被分成了工厂方法和抽象工厂两类。实际上，前面一种分类方法更加常见，所以，在今天的讲解中，我们沿用第一种分类方法。

## 简单工厂（Simple Factory）

```java
package factory.simple;

public class RuleConfigParserFactory {

	public static IRuleConfigParser createParser(String configFormat) {
	    IRuleConfigParser parser = null;
	    if ("json".equalsIgnoreCase(configFormat)) {
	      parser = new JsonRuleConfigParser();
	    } else if ("xml".equalsIgnoreCase(configFormat)) {
	      parser = new XmlRuleConfigParser();
	    }
	    return parser;
	  }
}
```

大部分工厂类都是以**“Factory”**这个单词结尾的，但也不是必须的，比如 Java 中的 DateFormat、Calender。除此之外，**工厂类中创建对象的方法一般都是 create 开头**，比如代码中的 createParser()，但有的也命名为 getInstance()、createInstance()、newInstance()，有的甚至命名为 valueOf()（比如 Java String 类的 valueOf() 函数）等等，这个我们根据具体的场景和习惯来命名就好。

在上面的代码实现中，我们每次调用 RuleConfigParserFactory 的 createParser() 的时候，都要创建一个新的 parser。实际上，如果 parser 可以复用，为了节省内存和对象创建的时间，我们可以将 parser 事先创建好缓存起来。当调用 createParser() 函数的时候，我们从缓存中取出 parser 对象直接使用。这有点类似单例模式和简单工厂模式的结合，具体的代码实现如下所示。在接下来的讲解中，我们把上一种实现方法叫作简单工厂模式的第一种实现方法，把下面这种实现方法叫作简单工厂模式的第二种实现方法。

```java
package factory.simple;

import java.util.HashMap;
import java.util.Map;

public class RuleConfigParserFactory2 {
  private static final Map<String, IRuleConfigParser> cachedParsers = new HashMap<>();

  static {
    cachedParsers.put("json", new JsonRuleConfigParser());
    cachedParsers.put("xml", new XmlRuleConfigParser());
  }

  public static IRuleConfigParser createParser(String configFormat) {
    if (configFormat == null || configFormat.isEmpty()) {
      return null;//返回null还是IllegalArgumentException全凭你自己说了算
    }
    IRuleConfigParser parser = cachedParsers.get(configFormat.toLowerCase());
    return parser;
  }
}
```

## 工厂模式

我们前面提到，之所以将某个代码块剥离出来，独立为函数或者类，原因是这个代码块的逻辑过于复杂，剥离之后能让代码更加清晰，更加可读、可维护。但是，如果代码块本身并不复杂，就几行代码而已，我们完全没必要将它拆分成单独的函数或者类。

基于这个设计思想，当对象的创建逻辑比较复杂，不只是简单的 new 一下就可以，而是要组合其他类对象，做各种初始化操作的时候，我们推荐使用工厂方法模式，将复杂的创建逻辑拆分到多个工厂类中，让每个工厂类都不至于过于复杂。而使用简单工厂模式，将所有的创建逻辑都放到一个工厂类中，会导致这个工厂类变得很复杂。

```java
package factory.method;

import factory.common.IRuleConfigParser;

public interface IRuleConfigParserFactory {

	IRuleConfigParser createParser();

}
```

```java
package factory.method;

import factory.common.IRuleConfigParser;
import factory.common.JsonRuleConfigParser;

public class JsonRuleConfigParserFactory implements IRuleConfigParserFactory{

	@Override
	public IRuleConfigParser createParser() {
		return new JsonRuleConfigParser();
	}
}
```

```java
package factory.method;

import factory.common.IRuleConfigParser;
import factory.common.XmlRuleConfigParser;

public class XmlRuleConfigParserFactory implements IRuleConfigParserFactory{

	@Override
	public IRuleConfigParser createParser() {
		return new XmlRuleConfigParser();
	}

}
```

使用

```java
package factory.method;

import factory.common.IRuleConfigParser;
import factory.common.RuleConfig;

public class Main {

	public static void main(String[] args) {

		IRuleConfigParserFactory parserFactory = RuleConfigParserFactoryMap.getParserFactory("xml");
		IRuleConfigParser parser = parserFactory.createParser();
		RuleConfig config = parser.parse("xml text ...");

		System.out.println(config);

	}

}
```

除此之外，在某些场景下，如果对象不可复用，那工厂类每次都要返回不同的对象。如果我们使用简单工厂模式来实现，就只能选择第一种包含 if 分支逻辑的实现方式。如果我们还想避免烦人的 if-else 分支逻辑，这个时候，我们就推荐使用工厂方法模式。

## 抽象工厂模式

我们可以让一个工厂负责创建多个不同类型的对象（IRuleConfigParser、ISystemConfigParser 等），而不是只创建一种 parser 对象。这样就可以有效地减少工厂类的个数。

```java
package factory.complex;

import factory.common.IRuleConfigParser;
import factory.common.ISystemConfigParser;

public interface IConfigParserFactory {

	IRuleConfigParser createRuleParser();

	ISystemConfigParser createSystemParser();

}
```

```java
package factory.complex;

import factory.common.IRuleConfigParser;
import factory.common.ISystemConfigParser;
import factory.common.JsonRuleConfigParser;
import factory.common.JsonSystemConfigParser;

public class JsonConfigParserFactory implements IConfigParserFactory{

	@Override
	public IRuleConfigParser createRuleParser() {
		return new JsonRuleConfigParser();
	}

	@Override
	public ISystemConfigParser createSystemParser() {
		return new JsonSystemConfigParser();
	}
}
```

```java
package factory.complex;

import factory.common.IRuleConfigParser;
import factory.common.ISystemConfigParser;
import factory.common.JsonRuleConfigParser;
import factory.common.JsonSystemConfigParser;

public class XmlConfigParserFactory implements IConfigParserFactory{

	@Override
	public IRuleConfigParser createRuleParser() {
		return new JsonRuleConfigParser();
	}

	@Override
	public ISystemConfigParser createSystemParser() {
		return new JsonSystemConfigParser();
	}
}
```

第一种情况：类似规则配置解析的例子，代码中存在 if-else 分支判断，动态地根据不同的类型创建不同的对象。针对这种情况，我们就考虑使用工厂模式，将这一大坨 if-else 创建对象的代码抽离出来，放到工厂类中。

还有一种情况，尽管我们不需要根据不同的类型创建不同的对象，但是，单个对象本身的创建过程比较复杂，比如前面提到的要组合其他类对象，做各种初始化操作。在这种情况下，我们也可以考虑使用工厂模式，将对象的创建过程封装到工厂类中。

对于第一种情况，当每个对象的创建逻辑都比较简单的时候，我推荐使用简单工厂模式，将多个对象的创建逻辑放到一个工厂类中。当每个对象的创建逻辑都比较复杂的时候，为了避免设计一个过于庞大的简单工厂类，我推荐使用工厂方法模式，将创建逻辑拆分得更细，每个对象的创建逻辑独立到各自的工厂类中。同理，对于第二种情况，因为单个对象本身的创建逻辑就比较复杂，所以，我建议使用工厂方法模式。

完整示例代码见码云项目地址。

## 参考

设计模式之美_设计模式_代码重构-极客时间
<https://time.geekbang.org/column/intro/250>
