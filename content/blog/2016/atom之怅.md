title=Atom之怅
date=25/11/2016
type=post
tags=atom
status=published
~~~~~~

昨天弄这个[atom](https://atom.io/)搞了一天。本来我只是想用它写个blog，也就是做个markdown的工具，因为idea的那个markdown太烂了。我在网上查了写作用的插件，看上去很多，我找了几个必备的装上，然后又发现很多开发相关的插件。下载的人很多，我不自觉的都给它装上了......插件下载是很慢的，不知道为什么，所以我决定到星游城去，那里可能有快的WIFI，我选择了sunday smile(SS)这个咖啡馆，出发，一路很顺利，停好车，背着包来到SS，结果人太多了，我一看时间，5点了，都是大家买晚饭的时候，咖啡馆里排着长队买单，想了想还是换家吧。于是来到对面的ZOO COFFEE.里面人是不多的，已经5点多了，还是不喝咖啡了，再加上早上在SS吃早饭，咖啡买一送一。喝的我有点腻了，还是换个伯爵茶吧，不便宜，35RMB。点好，坐下，打开电脑准备充分利用他们的wifi把我的atom插件给弄好。装了几个，准备再试下我最想用的markdown,我记得在家里时这个可以自动提示的，很棒，只要按下一个字母加一个tab就可以出完整的标签了，比如img标签，只要按下"i"就会出提示，再按tab,就自动出""[]()"这几个标签，提升写作速度很棒的......我试了下，居然不成功，我排查了所有插件，是哪里的问题？找不到。我能想到的应该是快捷键冲突，但每个插件都有快捷键，几十个插件我要一个一个的去排查，想想就疯了，我的处理办法是把所有插件都卸载了，然后看是否能自动恢复，结果不行。我干脆把atom给卸了重装吧，还是不行。WTF~，焦虑的查了大半个小时，一无所获，装了卸，卸了装......我得回家了，已经快7点了，拿车回去，路上理了理思路，发现错误就在快捷键冲突上。到家把电脑打开，再从头开始排查，这时偶然发现在Mac下，可以用apm这个命令，于是用apm list 把所以package 列出来了，一一看了，定位到

```
language-gfm
```

这个包，因为在之前解决这个问题时，重复在网上看到过，在atom里面把这个package找到，猛然发现，插件下面一个大大大"Enable"，意思是这个插件是disable的,不可用，忽然觉得我找到问题了，在网上一搜，果不其然，这个插件是默认的

```
github fivoer markdown(gfm) language.
```

因为后来我装了一个叫

```
language-markdown
```

的插件，两个可能有冲突，自动把官方的这个给disable了......以为这个才是正统，其实是它妈渣......果断卸载了无多说。 好吧，打开后问题解决了，耗费了我4个小时的问题，就是因为一个"Enable"

# 提出atom的几个问题

1.atom是很热，插件开发热度非常高，但不要忽略了插件管理的问题。language-gfm disable是在我不知情的情况下发生的。wtf~

2.atom的包管理明显，我装了十几个包，但在客户端里硬是查不到几个。看不出来哪个是新装的，哪些是旧的。就算是我用apm包管理list出来所有的包，也只是个排序罢了，打不出来。

3.atom没有恢复默认的功能，里面那么多的配置，每个插件都有很多，很多插件加在一起，会有多少个，每个插件配置都是独立的没有集中管理，起了冲突要排查是非常可怕的事情。

任何工具，简单明了，易用才是王道，学习成本太高，稳定性不好，隐性问题太多，给用户带来的灾难是毁灭性的，试想如果是一个普通用户遇到我昨天的问题，怕是早就放弃了......现在看来，appstore里面推荐的[bear](http://www.bear-writer.com/)这个markdown工具反倒是更好......推荐给hacker以为的人使用。大力推荐。包括我自己都准备转过去了。

# 引申一点话题：大道至简！

>大道是唯一的，就是“至简”，除此之外，再没有第二个道。

大道至简这话，自古有之，说的是真正的为人处事之道非常简单，按照孔子门下的规矩，我是不应在"大道至简""这四个字之外加任何的描述和引申，因为都是多余的，不"至简"。但我是凡人，我还是想说，放在心里难过。我最好的解决办法是在黑夜的房间里，独自一个，滔滔不绝，对着空气，对着墙壁，对着月亮对着星星，表达我对圣人的敬意。

>大道至简，简单说就是所有事情就都是简单的，都要用最自然的方式去处理。

- 吃饭用筷子不自然，用叉子也不自然，应该用手。用碗自不自然？自然，因为用手盛汤不方便，所以用手不自然，用碗自然。
- 学会了windows又去学macos，这不自然，它们都是操作系统，会一样就满足日常需求了，为什么要学两样，不至简......
- 学会了eclipse又学idea不自然，不至简，都是开发工具，差不多，idea能比idea好多少？
- 电脑里有一个文本编辑器，还想再装一个，这不自然，因为你可能永远也用不到，这个至简......
- 住在外环的人想搬到内环，这不自然，上海的内外环之间相隔不过十多公里，交通不过十几二十分钟，有什么差别？不需要搬家，那不自然，硬说内环好的那是傻瓜。
- 有了一个老婆，还在喜欢其它漂亮姑娘，这不自然。都是女人，高矮能差多少，胖瘦也就差十几斤，有什么大的差别，能差几百斤吗？说话再好听，也不会好听过歌声，声音再尖也不会刺破耳朵吧。再聪明，再会说话，对话的也主要是你，也不可能天天对成百人进行演讲吧，老婆会不会说话有什么差别？
- 看到别人有一件漂亮衣服，自己也想买，这不自然。你已经有衣服了，可以保暖，再买就不是最基本需求了，不至简
- 你有一辆本田，还想再买一辆BMW这不自然。都是代步工具，能舒适多少，能安全多少，为了那一点点的性能，牺牲几十万，这不至简，有钱捐给灾区，这才自然。

古人只做两件事，读书和耕田，我觉得这很自然，一个是养好思想，一个是供养身体。这够简单，这很自然。

现代人无法像古代圣人那样了，社会也已经不再提供这样的条件给我们，我们只能与时俱进，这也是自然的，但无论时代如何发展，道还是相同的，我们依然只需要做两件事情：

>供养好我们的思想和身体。

- 供养思想，可能不再需要像古人那样炳烛夜读，但我们可以在网上学习，我们也可以看书，但不再是竹简，而是用纸质书，也可能是kindle电子书......
- 供养身体，可能已经没有那么多地让我们去种了，将来可能都是机器种，但我们还是学会一样技能，足以体面的养活自己。比如你喜欢做手工，那就拼命的做吧，好好做，做天下最好的手工。喜欢写代码，那就好好写，努力写，写最好的代码。喜欢码字那就天天码，用心专一，写出大道，阐明道理，做圣人的代言人，影响世风，移风易俗，倡导天下大同......

>以上这些都是废话，因为孔子只倡导四个字：大道至简！然后就是：身体力行！最后达到知行合一！
