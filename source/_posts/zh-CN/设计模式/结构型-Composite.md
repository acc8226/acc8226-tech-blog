组合模式的原理与实现在 GoF 的《设计模式》一书中，组合模式是这样定义的：

> Compose objects into tree structure to represent part-whole hierarchies.Composite lets client treat individual objects and compositions of objects uniformly.

翻译成中文就是：将一组对象组织（Compose）成树形结构，以表示一种“部分 - 整体”的层次结构。组合让客户端（在很多设计模式书籍中，“客户端”代指代码的使用者。）可以统一单个对象和组合对象的处理逻辑。

接下来，对于组合模式，我举个例子来给你解释一下。

假设我们有这样一个需求：设计一个类来表示文件系统中的目录，能方便地实现下面这些功能：

* 动态地添加、删除某个目录下的子目录或文件；
* 统计指定目录下的文件个数；
* 统计指定目录下的文件总大小。

```java
package pattern.structural.composite;

public abstract class FileSystemNode {

	protected String path;

	public FileSystemNode(String path) {
		this.path = path;
	}

	public abstract long countNumOfFiles();

	public abstract long countSizeOfFiles();

	public String getPath() {
		return path;
	}

}
```

文件类
```java
package pattern.structural.composite;

public class File extends FileSystemNode {

	public File(String path) {
		super(path);
	}

	@Override
	public long countNumOfFiles() {
		java.io.File file = new java.io.File(super.path);
		if (file.exists()) {
			return 1;
		}
		return 0;
	}

	@Override
	public long countSizeOfFiles() {
		java.io.File file = new java.io.File(super.path);
		if (file.exists()) {
			return file.length();
		}
		return 0;
	}

}
```

目录类

```java
package pattern.structural.composite;

import java.util.ArrayList;
import java.util.List;

public class Directory extends FileSystemNode {

	private List<FileSystemNode> subNodes = new ArrayList<>();

	public Directory(String path) {
		super(path);
	}

	@Override
	public long countNumOfFiles() {
		int countNum = 0;
		for (int i = 0; i < this.subNodes.size(); i++) {
			countNum += this.subNodes.get(i).countNumOfFiles();
		}
		return countNum;
	}

	@Override
	public long countSizeOfFiles() {
		int countSize = 0;
		for (int i = 0; i < this.subNodes.size(); i++) {
			countSize += this.subNodes.get(i).countSizeOfFiles();
		}
		return countSize;
	}

	public void addSubNode(FileSystemNode fileOrDir) {
		this.subNodes.add(fileOrDir);
	}

	public void removeSubNode(FileSystemNode fileOrDir) {
		int size = subNodes.size();
		int i = 0;
		for (; i < size; ++i) {
			if (subNodes.get(i).getPath().equalsIgnoreCase(fileOrDir.getPath())) {
				break;
			}
		}
		if (i < size) {
			subNodes.remove(i);
		}
	}
}
```

Main 方法调用

```java
package pattern.structural.composite;

public class Main {

	public static void main(String[] args) {
		Directory rootDir = new Directory("D:\\K_Workspace\\111\\src\\demo");
		buildFileSystemNode(rootDir);

		System.out.println(rootDir.countNumOfFiles());
		System.out.println(rootDir.countSizeOfFiles());
	}

	private static void buildFileSystemNode(Directory dir) {
		java.io.File file = new java.io.File(dir.getPath());
		for (java.io.File f : file.listFiles()) {
			if (f.isFile()) {
				dir.addSubNode(new File(f.getPath()));
			} else if (f.isDirectory()) {
				Directory directory = new Directory(f.getPath());
				dir.addSubNode(directory);
				buildFileSystemNode(directory);
			}
		}
	}

}
```

组合模式的设计思路，与其说是一种设计模式，倒不如说是对业务场景的一种数据结构和算法的抽象。其中，数据可以表示成树这种数据结构，业务需求可以通过在树上的递归遍历算法来实现。

组合模式，将一组对象组织成树形结构，将单个对象和组合对象都看做树中的节点，以统一处理逻辑，并且它利用树形结构的特点，递归地处理每个子树，依次简化代码实现。使用组合模式的前提在于，你的业务场景必须能够表示成树形结构。所以，组合模式的应用场景也比较局限，它并不是一种很常用的设计模式。

## 参考

设计模式之美_设计模式_代码重构-极客时间
<https://time.geekbang.org/column/intro/250>
