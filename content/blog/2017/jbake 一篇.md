title=jbake 一篇
date=03/01/2017
type=post
tags=blog
status=published
~~~~~~

最两天在改jbake,问题真多

### 目录更改问题
如果jbake目录做过更改
> 1.一定要用jbake -i 重新初始化一下。否则的话能起起来，但目录只要有改动就会自动关闭，报下面的错误

```exception
/root/.sdkman/candidates/jbake/current/bin/jbake: line 15:  4366 Killed                  java -jar "${EXEC_PARENT}/jbake-core.jar" $@

```

> 2.目录的名字一定不要写成jbake,应该写成：jbake-chenjiantao等。

### 起动问题
起动是不需要用 -b 参数的。-s 参数已经包含了**-b**

另外，content目录内容有变动，-s就会自动全部加载文件一次，也就是-b一次

### 页面分页问题
这两个选项没什么用处，写了下面也不会出页码标签

```properties

#是否要分页 默认false
index.paginate = true
#每页多少
index.posts_per_page = 10

```
> type=blog 是说所有页面都是内容，我们写的type都是blog
 type = page 这个是页面，不是内容。比如about.html这个是页面。
