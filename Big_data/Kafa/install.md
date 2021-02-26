# Kafka 安装

Kafka 需要 Zookeeper 进行监控, 所以在安装 Kafka 之前先要安装 Zookeeper.

## 安装 Zookeeper

1、下载zookeeper. 推荐使用国内镜像源. 比如[清华镜像源](https://mirrors.tuna.tsinghua.edu.cn/)

2、创建zookeeper配置文件.

在zookeeper解压后的目录下找到conf文件夹，进入后，复制文件zoo_sample.cfg，并命名为zoo.cfg

zoo.cfg中一共四个配置项，可以使用默认配置。

3、启动zookeeper。

进入zookeeper根目录执行 bin/zkServer.sh start

4  对于启动 zookeep 命令的介绍:

+ `bin/zkServer.sh start`, 表示后台运行
+ `bin/zkServer.sh start-foreground`, 表示前台运行

### Dockerfile

+ Github [地址](https://github.com/kougazhang/zookeeper)







