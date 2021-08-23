---
layout:     post
title:      "zookeeper"
subtitle:   ""
date:       2021-08-23 20:08:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - zookeeper
  - bigdata
---

## 常用命令
+ 启动 sh zkServer.sh start
+ 停止 sh zkServer.sh stop
+ 查看状态 sh zkServer.sh status 
+ 连接本机服务器 sh zkCli.sh
+ 连接指定服务器 sh zkCli.sh -server ip:port
+ 创建节点 create [-s] [-e] path data acl（ -s 顺序 -e 临时 acl 权限控制）
    + create /test qaz
+ 列出路径 ls path
    + ls /
+ 获取节点数据内容和属性 get path
    + get /test
+ 更新数据 set path data
    + set /test wsx
+ 删除
    + delete path 删除一个节点需要该节点下没有子节点. eg: delete /test
    + deleteall path 递归删除某节点