title=python一记 判断中文
date= 05/12/2017 
type=post
tags=blog python
status=published
~~~~~~
## 判断是中文
```
#-*- coding:utf-8 -*-
import random

def check_contain_chinese(check_str):
    for ch in check_str.decode('utf-8'):
        if u'\u4e00' <= ch <= u'\u9fff':
            return True
    return False

```

## 产生随机中文
```

def iter_chinese():
    str =''
    for i in range(0x5E00,0x5E30):
        str+= unichr(i)
    print str

    str=''
    for i in range(100):
        str+= unichr(random.randint(0x4E00, 0x9FCF))
    print str
```