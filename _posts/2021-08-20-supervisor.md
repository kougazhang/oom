---
layout:     post
title:      "supervisor"
subtitle:   "supervisor"
date:       2021-08-20 09:33:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - supervisor
  - linux
  - devops
---
## 常用命令
```bash
// 更新所有配置, 不会重启应用
supervisorctl update

// 更新该 job 关于 supervisor 的配置
supervisorctl update <jobName>

// 重启该 job 的任务
supervisorctl restart <jobName>

// 重启某 group 下所有任务
supervisorctl restart <groupName>:*

// 查看该 job 的状态
supervisorctl status

// 重启所有应用
supervisorctl reload
```

## supervisord.conf 常用配置
文件路径：`/etc/supervisord.conf`
```ini
[unix_http_server]
file=/var/run/upyun-supervisor.sock

#[inet_http_server]
#port=127.0.0.1:9001
#username=user
#password=123

[supervisord]
logfile_maxbytes=10MB
logfile_backups=3
loglevel=info
nodaemon=false
minfds=1024
minprocs=200
pidfile=/var/run/supervisord.pid
logfile=/disk/ssd1/logs/supervisor/supervisord.log
childlogdir=/disk/ssd1/logs/supervisor

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[include]
files = /etc/supervisor.d/*.conf
```

## 使用 group 配置

```ini
# job,rawlog,upload 这三个 program 属于 <groupName>
# 它们可以写到不同文件中.
[group:<groupName>]
# programs 中的程序都必须存在
programs=job,rawlog,upload

[program:job]
command = 
autostart = true
autorestart = true
startsecs = 3
logfile_maxbytes = 50MB
stdout_logfile =

[program:rawlog]
...

[program:upload]
...
```

## supervisor 常见问题

1. too many files open

除了系统的 `ulimit` , supervisor 也限制了文件打开数, 出现这个异常修改以下两项:

```ini
[supervisord]
minfds=102400
minprocs=20000
```

2. 跟docker 一样, 守护的进行必须前台运行.(守护的程序还不能再开子进程). 也就是说, 程序的启动命令不能封装在脚本里.
