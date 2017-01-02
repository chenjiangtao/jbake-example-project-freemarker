title=nginx配置
date=02/01/2017
type=post
tags=nginx
status=published
~~~~~~
今天忙了一下午，配置nginx

**下面这种做法是错误的，不要试图让nginx直接指向
**
```sh

jbake -b -s /root/project /usr/local/nginx/html/jbake_output

server {
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  root /usr/local/nginx/html/jbake_output/;
}
```

**正确的办法是：**

```conf

root@vultr conf]# cat vhosts/chenjiangtao.com.conf
server {
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  access_log /usr/local/nginx/logs/chenjiangtao_access.log;
  error_log /usr/local/nginx/logs/chenjiangtao_error.log;

  location / {
      proxy_pass http://localhost:8802;
  }
}

```
起动还是用

```sh
cd /app/jbake

jbake -b -s

```

**关于nginx配置学习**

配置指向跳转
```conf

[root@vultr conf]# cat vhosts/chenjiangtao.com.conf
server {
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  access_log /usr/local/nginx/logs/chenjiangtao_access.log;
  error_log /usr/local/nginx/logs/chenjiangtao_error.log;

  location / {
      proxy_pass http://localhost:8802;
      proxy_set_header Host $host:80;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}


```
配置本地目录
```conf
[root@vultr conf]# cat vhosts/cm.chenjiangtao.com.conf
server {
  listen 80;
  server_name cm.chenjiangtao.com ;
  root /usr/local/nginx/html/cm;
  index index.html;
  access_log /usr/local/nginx/logs/cm_access.log;
  error_log /usr/local/nginx/logs/cm_error.log;

}

```
