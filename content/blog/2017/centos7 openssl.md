title=centos7/6.9 docker-ce-17/1.7.1使用证书登陆(openssl tls)
date= 21/11/2017 
type=post
tags=blog
status=published
~~~~~~
* 生成证书
* ca key

```
openssl genrsa -aes256 -out ca-key.pem 4096
```

* ca

```
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
```

* server key

```
openssl genrsa -out server-key.pem 4096
```

* 生成server 证书

```
openssl req -subj "/CN=192.168.1.144" -sha256 -new -key server-key.pem -out server.csr
```

```
echo subjectAltName = IP:192.168.1.144,IP:127.0.0.1 >> extfile.cnf
echo extendedKeyUsage = serverAuth >> extfile.cnf
```

```
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem   -CAcreateserial -out server-cert.pem -extfile extfile.cnf
```



* 生成client证书

```
rm extfile.cnf
```

 

```
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
```

```
echo extendedKeyUsage = clientAuth >> extfile.cnf
```

```
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem   -CAcreateserial -out cert.pem -extfile extfile.cnf
```

```
 rm -v client.csr server.csr
```

```
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
```

不推荐用dockerd

```
dockerd --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem   -H=0.0.0.0:2376
```


* 修改配置，使用证书
归集服务器证书

```
cp server-*.pem  /etc/docker/
cp ca.pem /etc/docker/
```

归集客户端证书

```
cp -v {ca,cert,key}.pem ~/.docker
```

修改docker配置

```
vi /lib/systemd/system/docker.service
```

```
ExecStart=/usr/bin/dockerd
替换
ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock
```

重起docker

```
systemctl restart docker 
```

* centos 6.9

```
vi /etc/sysconfig/docker
```
添加

```
OPTIONS='--selinux-enabled --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock'
```

iptables 开端口

```
iptables -I INPUT -p tcp --dport 2376 -j ACCEPT
iptables -L -n
/etc/init.d/iptables save
```

重起docker

```
service docker restart
```
 
* 客户端使用
证书拷贝到本地

```
scp -r root@192.168.1.144:~/.docker/ .
```

使用bash文件

```
#!/bin/sh
docker -H 192.168.1.144:2376 --tlsverify --tlscacert=/Users/jiangtao/myapp/192.168.1.144/ca.pem --tlscert=/Users/jiangtao/myapp/192.168.1.144/cert.pem  --tlskey=/Users/jiangtao/myapp/192.168.1.144/key.pem $@
```


出现
Error response from daemon: client is newer than server (client API version: 1.24, server API version: 1.19)

```
export DOCKER_API_VERSION=1.19
```
