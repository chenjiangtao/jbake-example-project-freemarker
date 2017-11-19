## jbake 相关配置
* 配置

jbake prot :
8802
host:
45.76.65.36



* 下面这种做法是错误的，不要试图让nginx直接指向

```ssh
jbake -b -s /root/project /usr/local/nginx/html/jbake_output

nginx
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
  root /usr/local/nginx/html/jbake_output/;

```

* 正确的办法是
如果jbake目录做过更改
> 1.一定要用jbake -i 重新初始化一下。

> 2.目录的名字一定不要写成jbake,应该写成：jbake-chenjiantao等。




- 切记：
type=blog 这个是说内容是blog （所有文章都应该是这个）
type=page 这个是说内容是一个完整的页面（不能随便写）


## nginx 配置
nginx 修改配置文件：
```bash
/usr/local/nginx/conf/vhosts/chenjiangtao.com.conf

```

http://localhost:8802/就是jbake的起动端口

server {
  listen 80;
  server_name chenjiangtao.com www.chenjiangtao.com;
   location / {
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://127.0.0.1:8802;
    }
   access_log /usr/local/nginx/logs/chenjiangtao_access.log;
}

上面这样配置好像不行，暂时取消，直接占用80端口


## nginx常用命令

起动：
/usr/local/nginx/sbin/nginx

加载配置文件
/usr/local/nginx/sbin/nginx -s reload

停止：
/usr/local/nginx/sbin/nginx -s stop


## jbake 常用命令
```sh
编译
jbake -b

运行，**一定要加上 -b ，不然上传文件时会导致崩溃！**

nohup jbake -b -s &

查找杀掉进程
ps aux | grep jbake | grep -v grep


```





