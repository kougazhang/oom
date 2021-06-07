---
layout:     post
title:      "Linux 常用命令"
subtitle:   "Linux useful command"
date:       2021-05-29 18:47:00
author:     "kgzhang"
catalog: false
header-style: text
tags:
  - linux
---

## Notice
除非明确指出，本文命令的执行环节为 Centos7.

## content
+ [网络](#网络)
+ [进程](#进程)
+ [文件处理](#文件处理)
+ [文本处理](#文本处理)
+ [磁盘](#磁盘)
+ [系统文件](#系统文件)
+ [资源管理](#资源管理)
+ [时间](#时间)

## 网络
+ [curl](#curl)

+ hostname: 主机名, 内网地址
+ hostname, 显示机器的主机名
+ hostname -I, 显示机器的内网 IP.

### curl
+ 指定 DNS 服务器
```bash
curl http://xxx -x 指定DNS服务器 -vo /dev/null
```
+ 发送 POST 请求
```bash
curl --location --request POST address \
--header 'Content-Type: application/json' \
--data 'json格式的参数'
```
---

## 进程

### `&` 的作用

终端执行的程序是 shell 进程的子进程. 

每一个命令行终端都是一个 shell 进程，你在这个终端里执行的程序实际上都是这个 shell 进程分出来的子进程。

**正常情况下shell 会阻塞.**

正常情况下，shell 进程会阻塞，等待子进程退出才重新接收你输入的新的命令。

* `&` 只是让 shell 不再阻塞.

加上&号，只是让 shell 进程不再阻塞，可以继续响应你的新命令。但是无论如何，你如果关掉了这个 shell 命令行端口，依附于它的所有子进程都会退出。

**`(cmd &)` 把 cmd 命令挂载到 `systemd` 下.**

而(cmd &)这样运行命令，则是将cmd命令挂到一个systemd系统守护进程名下，认systemd做爸爸，这样当你退出当前终端时，对于刚才的cmd命令就完全没有影响了。

### nuhup 进程守护

```bash
nohup 命令 > log 位置 2&>1 &
```

### screen 进程守护

- 创建新的窗口, `screen -S 窗口名_xxxx`

- 进入创建的窗口, `screen -r 窗口名_xxxx`

- 退出窗口，让进程后台运行：`ctrl + a + d`
- 查看所有进程: `screen -ls`

### supervisor 进程守护

```bash
// 更新该 job 关于 supervisor 的配置
supervisorctl update <jobName>

// 重启该 job 的任务
supervisorctl restart <jobName>

// 查看该 job 的状态
supervisorctl status
```

### supervisord.conf 常用配置
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

### supervisor 常见问题

1. too many files open

除了系统的 `ulimit` , supervisor 也限制了文件打开数, 出现这个异常修改以下两项:

```ini
[supervisord]
minfds=102400
minprocs=20000
```

2. 跟docker 一样, 守护的进行必须前台运行.(守护的程序还不能再开子进程)

---

### systemd 进程管理

1. 启动/重启/停止某服务. 如果启动失败, 看输出的日志进行处理.

```bash
systemctl start/restart/stop xxx.service
```

查看当前服务的状态

```bash
systemctl status xxx.service
```

2. 对服务进行开机启动项的控制.

```bash
# 将服务加入开机自启动
systemctl enable Service_Name

# 禁止服务开机自启动
systemctl disable Service_Name

# 查看服务是否开机自启动
systemctl is-enabled Service_Name

# 重启 systemctl 服务使配置生效
systemctl daemon-reload
```

3. Centos7 使用 systemctl 添加自定义服务.

   1. 配置文件一般路径:
      + 系统服务目录: `/usr/lib/systemd/system/`，经测试放在系统服务目录下才会生效。
      + 用户服务目录: `/usr/lib/systemd/user/`
      + 查看某个服务的配置文件：`systemctl cat <seriveName>`
   2. 配置文件后缀:
      + `.target` 后缀是开机级别的 unit.
      + `.service` 后缀是服务级别的 unit.
   3. 服务级别的 unit 文件.

   ```
   # Unit: 启动顺序与依赖关系
   [UNIT]
   #服务描述
   Description=Media wanager Service
   #指定了在systemd在执行完那些target之后再启动该服务
   After=network.target
   
   # Service: 启动行为
   [Service]
   #定义Service的运行类型
   Type=simple
   
   #定义systemctl start|stop|reload *.service 的执行方法（具体命令需要写绝对路径）
   #注：ExecStartPre为启动前执行的命令
   ExecStartPre=/usr/bin/test "x${NETWORKMANAGER}" = xyes
   ExecStart=/home/mobileoa/apps/shMediaManager.sh -start
   ExecReload=
   ExecStop=
   
   #创建私有的内存临时空间
   PrivateTmp=True
   
   [Install]
   #多用户为 multi-user.target 的, 表示开机启动.
   WantedBy=multi-user.target
   ```

   修改完配置后, 需要重启 systemctl 服务：
   ```shell
   systemctl daemon-reload
   systemctl enable <serviceName>
   systemctl start <serviceName>
   ```

4. 例子：部署 supervisord

部署 supervisord 程序，使用 systemd 托管。

前提：supervisord 已经安全成功。

首先配置如下文件, [源文件可以从这里获取](https://github.com/kougazhang/linux/tree/master/supervisor)：
+ supervisord.service, 把该文件放置到 `/usr/lib/systemd/system/supervisord.service` 目录下
+ supervisord, 把该文件放置到 `/etc/rc.d/init.d/` 目录下
    + 该文件中 `exec` 的值应该等于 `which supervisord` 的值
+ supervisord.conf，把该文件放到 `/etc` 目录下

使用 ansible 部署可以参考 [此链接](https://github.com/kougazhang/ansible/tree/master/supervisor)

执行命令：
```shell 
# 加载配置文件 supervisord.service
systemctl daemon-reload
# 配置开机自启
systemctl enable supervisord
# 启动服务
systemctl start supervisord
```

---

## 查找文件

### find
+ 查找 $YouPath 路径下 10 天前的文件并删除
``` 
# -exec rm -f {} \;, 表示查找到后执行的动作
find $YouPath -type f -mtime +10 -exec rm -f {} \;
```

## 文件处理

### 文件软链接

+ readlink: 显示软链接文件完整的路径
+ readlink -f <softLinkName>

### rename: 文件重命名

rename 这个命令要区分不同的版本, 下述以 Centos 中的 rename 为例.
该rename用法较为简单：
rename [options] expression replacement file... 
如下述命令将当前目录后缀为.htm的文件改为.html。

```bash
  rename .htm .html *.htm 
```

### 压缩/解压

解压 `tgz`:
```shell
tar -xzvf xx.tgz -C <指定解压包的路径>
```

---

## 磁盘

+ iostat: 磁盘读写情况
+ iostat -x 1, 查看磁盘当前的读写情况.
+ iostat -m, 以 mb 为单位进行显示.

---

## 文本处理

### awk: 文本分割

基本用法: awk '{print $n}'. 有以下注意点:

+ n 的取值从 1 开始, 0 代表文本自身.
+ 必须是单引号.
+ 分隔符默认是空格, 使用 -F 指定新的分隔符.

```bash
echo 'a/b/c'|awk -F / '{print $1}'
```

+  使用 NF 可以获取最后一个元素.

```bash
echo 'a/b/c'|awk -F / '{print $NF}'
```

### grep: 文本匹配

+ 使用引号包含空格的关键字

```bash
grep '2019-10-24 00:01:11' *.log
```

+ 使用 -i 来忽略大小写.

```bash
grep –i 'x' 文件名
```

+ 使用 -v(verse. 翻转).表示反选.
+ 使用 -E 表示使用 RegExp

```bash
docker images|grep -E ^k.*
```

+ 使用 -C 来显示显示前后几行

```bash
grep -C 10 'ok' <fileName>
```

+ 使用 `-R` 匹配目录.
```bash
grep -R 'xxx' directory.
```

### sed: 文本替换

+ 语法模板

```bash
// g 代表全局替换.
 s/pattern/replaced/g
```

+ sed 对正则表达式的支持程度
  + 不支持 \d , 可以使用 [0-9] 代替
  + 不支持 +, 使用 * 可以, 但是语义不同, * 表示 0到多个.
  + 转义符为 \
  + 分组匹配时, 使用 \1, \2, \3 作为匹配项, 举例:

```bash
echo 2021010100|sed -E 's/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]*)/\1-\2-\3 \4/g'
//输出: 2021-01-01 00
```

+ sed 处理文件
  -i 表示把结果输出到文件. 不加 -i 不会输出到文件的. 所以可以先不加 -i 验证 sed 的处理程序, 验证通过后再写回文件.

```bash
~/temp $ cat a     
dsadadsqd213234234
~/temp $ sed -i 's/[0-9]/got/g' a
```

---

## 系统文件

### lsof

+ 查看某进程打开的文件, socket 链接:
  +  `lsof -p <pid>`
  + `lsof -c <progressName>`
+ 查看端口占用, `lsof -i:<port>`
+ 查看某文件的进程: `lsof <fileName>`
+ 查看某目录下文件的进程:
  + 不递归: `lsof +d <dirName>`
  + 递归: `lsof +D <dirName>`

---

## 资源管理

### top

+ load average: 负载均衡, 机器过去 5min, 10min, 15min 负载均衡的情况. 一般在 3, 4 左右比较正常.
+ wa: wait io. 比如网络请求或磁盘读写都属于该项. 一般小于 1 时比较正常.
+ %CPU, 表示程序使用的核数. 每 100 表示使用了 1 个核.
+ 按下1, 会显示该机器有几个逻辑核, 每个核的使用情况.

---

## 时间

### date

+ 当前格式化

```shell
date +"%Y-%m-%d %H:%M:%S"
// 2021-03-09 14:09:17
```

+ 时间运算: 指定日期减 1 天.

```shell
// 20210316 被减数
// -1 要减去的天数
// "%Y-%m-%d": 输出格式
date -d "20210316 -1 days" +"%Y-%m-%d"
// 2021-03-15
```

+ 日期转为时间戳

```shell
date -d "Nov  4 15:49:41 CST 2018" +%s
```

+ 时间戳转为日期

```
date -d @1541317781
```

+ 将时间戳转换为日期，并按特定格式显示

```
 date -d @1541317781 +'%Y%m%d %H:%M:%S'
```

+ 日期时间格式的转换, 将 Mon Jul 27 20:31:33 2020 转换为  2020-07-27 20:31:33

```
[root@localhost ~]# date -d 'Mon Jul 27 20:31:33 2020' +'%Y-%m-%d %H:%M:%S'
2020-07-27 20:31:33
```

## 未归类

### xargs

+ -n, 每次执行命令时替换的最大参数个数, 如-n1
+ -I 指定一个替换字符串

```bash
realpath ./sugar| xargs -t -I '{}' ln -s {} /root/sugar
```

+ -d, 定界符. 默认使用空格. 使用 -d 来指定新的分隔符.

```bash
printf "abn"|xargs -d b
a n
```

### wc: word count

wc -l, 统计出现的行

### crontab: 定时任务

**配置时间**
> 推荐到在线网站上验证时间配置

crontab的命令构成为 时间+动作，其时间有分、时、日、月、周五种，操作符有:
+ `*` 取值范围内的所有数字
+ `/` 每过多少个数字
+ `-` 从X到Z
+ `,` 散列数字

**常用命令**
+ 编辑定时任务项: crontab -e
+ 列出当前 crontab 计划: crontab -l
+ 查看执行记录: tail -f /var/log/cron
+ 查看 crontab 执行任务的日志, 这个不一定会有: tail -f /var/spool/mail/

**crontab 常用配置文件**

我们经常使用的是crontab命令是cron table的简写，它是cron的配置文件，也可以叫它作业列表，我们可以在以下文件夹内找到相关配置文件。

+ /var/spool/cron/ 目录下存放的是每个用户包括root的crontab任务，每个任务以创建者的名字命名
+ /etc/crontab 这个文件负责调度各种管理和维护任务。
+ /etc/cron.d/ 这个目录用来存放任何要执行的crontab文件或脚本。
+ 我们还可以把脚本放在/etc/cron.hourly、/etc/cron.daily、/etc/cron.weekly、/etc/cron.monthly目录中，让它每小时/天/星期、月执行一次。

**记录日志**
程序要自己写日志，便于后期排查问题。

最简单的方法：
```
# 注意 >> 添加符号
# 2>&1 是要把标准输出和标准错误都统一输出到一个文件.
* * * * * find $YouPath -type f -mtime +10 -exec rm -f {} \; >> /disk/ssd1/crontab-log 2>&1
```

**踩坑: 一定要调试**
  
+ 非系统命令需要写出它的绝对路径.

+ 脚本能运行成功, 不代表在 crontab 下一定会执行成功. 

比如 hdfs 这个命令在 shell 下可以正常调用, 但是 crontab 执行时就会抛出找不到该命令之类的异常, 需要写出 hdfs 的绝对路径才能执行成功.

比如 `find $YouPath -type f -mtime +10 -exec rm -f` 在命令行下可以执行，但是在 crontab 中需要加 `\;`, 即：
```
* * * * * find $YouPath -type f -mtime +10 -exec rm -f {} \; >> /disk/ssd1/crontab-log 2>&1
``` 

**排查 crontab 任务没有执行的原因:**
+ 查看执行记录: tail -f /var/log/cron
+ 如果日志显示任务执行了但是没生效, 应该是程序问题, `查看 crontab 执行任务的日志: tail -f /var/spool/mail/root` , 执行日志中应该有具体错误的原因.
+ 如果日志显示任务根本没执行:
    + 排查时间配置是否正确, 可以找个在线网站校验一下.
    + `ps -ef|grep cron` , 排查 crontab 程序是否正常运行.
    + `/sbin/service cron start`, centos6 启动 crontab

## 包管理 yum

### 安装 epel-release
 EPEL (Extra Packages for Enterprise Linux)是基于Fedora的一个项目，为“红帽系”的操作系统提供额外的软件包，适用于RHEL、CentOS和Scientific Linux.
```shell
yum install epel-release
```
yum 官方提供的包不全，所以必须先安装 `epel-release`，才能找到常用的软件。
