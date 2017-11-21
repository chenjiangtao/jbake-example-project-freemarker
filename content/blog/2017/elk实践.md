title=elk实践
date= 21/11/2017 
type=post
tags=elk log-driver docker elasticsearch logstash kibana
status=published
~~~~~~
* ES启动
```
docker run --name myes -d -p 9200:9200 -p 9300:9300 elasticsearch
```
* kibana启动
```
docker run --name mykibana --link myes:es -e ELASTICSEARCH_URL=http://es:9200 -p 5601:5601 -d kibana
```
* logstash启动
启动 配置 filebeats
```
docker run -it —rm -p 5044:5044 -v "/Users/jiangtao/logstash-conf":/config-dir logstash -f /config-dir/logstash-beats.conf
```

一定要开5044，不然filebeats连不上

* filebeats启动
```
docker run -d -v /var/run/docker.sock:/tmp/docker.sock  -e LOGSTASH_HOST=192.168.1.115 -e LOGSTASH_PORT=5044 -e SHIPPER_NAME=$(hostname) bargenson/filebeat
```

参数：
LOGSTASH_HOST=192.168.1.115         logstash的ip地址
LOGSTASH_PORT=5044                  logstash 端口
SHIPPER_NAME=$(hostname)            不知道何用这样写死

- log-driver 使用 
```
docker run -it --rm --log-driver=syslog --log-opt syslog-address=udp://localhost:25826 --log-opt syslog-facility=daemon myapp
```
参数：
syslog-facility=daemon 指定日志级别为守护进程
syslog-address=udp://localhost:25826 logstash服务器（tcp|udp）
log-driver=syslog 有多种


* es-head 启动

起动时配置跨域：本地目录覆盖(切记把docker里原文件放入)

```
docker run -d  -p 9200:9200 -p 9300:9300 -v  /Users/jiangtao/config:/usr/share/elasticsearch/config  elasticsearch 
```

修改elasticsearch.yml加入，并起动时拉入
http.cors.enabled: true
http.cors.allow-origin: “*”

起动es-head
```
docker run -p 9100:9100 mobz/elasticsearch-head:5-alpine
```

* 注意

（不推荐直接覆盖container的配置目录）挂入本地目录和配置文件

```
docker run -d -p 9200:9200 -p 9300:9300 -v /Users/jiangtao:/data -e -Des.config=/data/elasticsearch.yml elasticsearch1
```

参数：-v /Users/jiangtao:/data 本地目录:docker container 里的目录
参数：-e 加参数必加，否则异常：ERROR: D is not a recognized option


- 这里面有两个坑：
1.ELASTICSEARCH_URL的ip配置，可以直接写成服务器的docker machine的ip
要么先用link ，再用link的别名--link myes:es -e ELASTICSEARCH_URL=http://es:9200
注意:直接用myes不行
参数：—network。 network有none,host,bridge，"container:name or id" 四种配置(docker network ls查看)
host 可以查看本机所有服务
none 没有ip地址。只能用link
bridge 默认的
container:name or id 是完全复用现成container的网络配置

- 端口使用注意
-p 80:80 指定映射端口
-P 将容器内的端口随机映射

- network 用法
查看
docker network ls
添加
docker network create mynet
使用
docker network connect myapp
docker run --net mynet myapp
查看网络信息
docker inspect mynet 
可看当前网络连接了哪些容器


- start up with config 写法
```
docker run -it --rm -v "$PWD/logstash-conf":/config-dir logstash -f /config-dir/logstash-sms.conf
```
参数说明: -v "\$PWD/logstash-conf":/config-dir 挂目录到docker容器上
注意$PWD参数

- logstash收集日志三种方式：filebeats、log-driver、logspout、logz.io

filebeats在小的docker-machine上用，收集整个machine的日志
log-driver 每个容器启动时独立使用 非常灵活
logspout、logz.io 待研究

 
