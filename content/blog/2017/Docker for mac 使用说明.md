title=Docer for mac使用说明
date=05/03/2017
type=post
tags=blog
status=published
~~~~~~

从2015年开始接触到docker到现在，使用了不少docker管理工具，从最早的boot2docker 到docker toolbox再到现在的docker for mac，发现docker是越来越难用了(后面说)……

我记得第一次使用docker时同时装了boot2docker, docker toolbox两个工具。由于使用习惯问题，更多使用的是boot2docker，直接在后台用命令起动。

记得那时要用docker得办三件事儿：

一是起动boot2docker
```
$ boot2docker start
```
二是对初始化
```
$ boot2docker shellinit
```

第三步才是运行docker
```
$ docker run -d -P --name web nginx
```

做第三步前还得设置环境变量……麻烦，但照提示来，运行没有问题！！

docker toolbox用的少，已经不记得那时长什么样子了，但印象中它们都依赖VirtualBox。

>Docker for Mac does not use VirtualBox, but rather HyperKit, a lightweight macOS virtualization solution built on top of Hypervisor.framework in macOS 10.10 Yosemite and higher.

docker for mac 已经大大减化了配置流程，底层也去掉了对VirtualBox的依赖，换成了HyperKit。docker for mac以标准的mac app形式存在，内部还是包含：docker,docker-compose,docker-machine这三个东西，但VM使用已经不在依赖docker-machine了，直接由docker-for-mac(在mac电脑里对应的是docker.app，使用前起动即可)接管守护，对比boot2docker省掉了第一步起动和第二步的初始化。有兴趣可以自行参考官方说明 [Docker for Mac vs. Docker Toolbox](https://docs.docker.com/docker-for-mac/docker-toolbox/)。

docker toolbox 在docker官网product里面是推荐的，主要是考虑到macOS 10.10之前的用户，因为系统没有集成Hypervisor.framework， 如果macOS大于10.10,官方推荐docker for mac，all in ONE，很方便。

最近使用docker最困扰的是无法pull image，在网上找了很多方法，最后还是选择结合shadowsocks翻墙pull,具体方法如下：
##### 1 .安装polipo
```bash
brew install polipo
```
##### 2.通过polipo生成shadowsocks的http代理（重点）

shadowsocks开全局，以为可以pull docker了，但跟本不是那么回事儿……经查shadowsocks是socks5的协议，只有支持这个协议的软件才能使用它的代理功能，比如dropbox就可以设置socks5……docker走的是http和https协议,所以要想办法把socks5转成http，这时就要用到polipo工具了
```bash``````
polipo socksParentProxy=127.0.0.1:1080 proxyAddress="192.168.0.102"
```
其中127.0.0.1:1080是socks5的端口，192.168.0.102是mac的地址。显示下面的日志就算代理起动成功。
```bash
Established listening socket on port 8123.
```
这个窗口不要关闭！

可以用http://192.168.0.102:8123和https://192.168.0.102:8123来代理上网了。

测试一下：
```bash
➜  ~ curl ip.gs
当前 IP：140.207.223.158 来自：中国上海上海 联通
➜  ~ export http_proxy=http://localhost:8123
➜  ~ curl ip.gs
当前 IP：45.76.65.36 来自：美国新泽西州皮斯卡特维 choopa.com
➜  ~ unset http_proxy
➜  ~ curl ip.gs
当前 IP：140.207.223.158 来自：中国上海上海 联通
```

#####3.配置docker for mac
点docker起动后的图标，在“preferences”里面选proxies，如下图配置即可
![screenshot.png](http://upload-images.jianshu.io/upload_images/4658686-01a54b184cd44f58.png)

现在可以愉快的docker pull 了
