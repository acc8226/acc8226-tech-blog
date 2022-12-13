使用 df 命令查看磁盘的容量

```sh
df
```

使用 du 命令查看目录的容量

```sh
# 默认同样以 块 的大小展示
$ du
# 加上`-h`参数，以更易读的方式展示
$ du -h
```

-d参数指定查看目录的深度

```sh
du -h #同--human-readable 以K，M，G为单位，提高信息的可读性。
du -a #同--all 显示目录中所有文件的大小。
du -s #同--summarize 仅显示总计，只列出最后加总的值。

来自: http://man.linuxde.net/du
```

## 简单的磁盘管理

dd命令用于转换和复制文件，不过它的复制不同于cp。

dd的命令行语句与其他的 Linux 程序不同，因为它的命令行选项格式为选项=值，而不是更标准的--选项 值或-选项=值。dd默认从标准输入中读取，并写入到标准输出中，但可以用选项if（input file，输入文件）和of（output file，输出文件）改变。

```sh
# 输出到文件
dd if=/dev/stdin of=test bs=10 count=1
# 或者省略 if=/dev/stdin 也是可以的

# 输出到标准输出
$ dd if=/dev/stdin of=/dev/stdout bs=10 count=1
# 注在打完了这个命令后，继续在终端打字，作为你的输入
```

使用 dd 命令创建虚拟镜像文件
 从/dev/zero设备创建一个容量为 256M 的空文件：

```sh
dd if=/dev/zero of=virtual.img bs=1M count=256
du -h virtual.img
```

使用 mkfs 命令格式化磁盘（我们这里是自己创建的虚拟磁盘镜像）
我们可以简单的使用下面的命令来将我们的虚拟磁盘镜像格式化为ext4文件系统：

```sh
sudo mkfs.ext4 virtual.img
```

**使用 mount 命令挂载磁盘到目录树**
用户在 Linux/UNIX 的机器上打开一个文件以前，包含该文件的文件系统必须先进行挂载的动作，此时用户要对该文件系统执行 mount 的指令以进行挂载。该指令通常是使用在 USB 或其他可移除存储设备上，而根目录则需要始终保持挂载的状态。又因为 Linux/UNIX 文件系统可以对应一个文件而不一定要是硬件设备，所以可以挂载一个包含文件系统的文件到目录树。

Linux/UNIX 命令行的 mount 指令是告诉操作系统，对应的文件系统已经准备好，可以使用了，而该文件系统会对应到一个特定的点（称为挂载点）。挂载好的文件、目录、设备以及特殊文件即可提供用户使用。

我们先来使用mount来查看下主机已经挂载的文件系统：

```sh
sudo mount
```

那么我们如何挂载真正的磁盘到目录树呢，mount命令的一般格式如下：

```sh
mount [options] [source] [directory]
```

一些常用操作

```sh
mount [-o [操作选项]] [-t 文件系统类型] [-w|--rw|--ro] [文件系统源] [挂载点]
```

```sh
$ mount -o loop -t ext4 virtual.img /mnt
# 也可以省略挂载类型，很多时候 mount 会自动识别

# 以只读方式挂载
$ mount -o loop --ro virtual.img /mnt
# 或者mount -o loop,ro virtual.img /mnt
```

使用 umount 命令卸载已挂载磁盘

```sh
# 命令格式 sudo umount 已挂载设备名或者挂载点，如：
$ sudo umount /mnt
```

**使用 fdisk 为磁盘分区（关于分区的一些概念不清楚的用户请参看[主引导记录](http://zh.wikipedia.org/wiki/%E4%B8%BB%E5%BC%95%E5%AF%BC%E8%AE%B0%E5%BD%95)）**

```sh
# 查看硬盘分区表信息
$ sudo fdisk -l

# 进入磁盘分区模式
$ sudo fdisk virtual.img
```

找出当前目录下面占用最大的前十个文件。

```sh
du -ah -d 1 | sort -hr | head -n 10
```

解释：-a 是所有文件，-h是可读方式，-d是深度，1 代表 2 层，也就保证了作业要求恶的当下目录中，sort 是排序，-r 是倒着排，-h和之前的一样，head 是取头部，-n 是取的数量，10 是是个文件。 注：初学，如有错误，欢迎指正。
