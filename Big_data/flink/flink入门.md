# Flink 本地安装调试

[官方文档](https://ci.apache.org/projects/flink/flink-docs-release-1.12/try-flink/local_installation.html) 非常详细了, 以下内容做个简单的总结.

**本地安装**

使用[清华镜像源](https://mirrors.tuna.tsinghua.edu.cn/apache/flink/) 下载安装即可.

# 相关命令

## 集群

+ 后台启动集群: `./bin/start-cluster.sh`
+ 停止后台启动的集群: `./bin/stop-cluster.sh`

## Job

+ 命令行提交 job: `./bin/flink run examples/streaming/WordCount.jar`