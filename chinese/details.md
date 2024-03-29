@def title = "由做饭想到的"
@def date = Date(2020, 8, 23)


## 缘起

近来饮食欠佳，叫外卖太多，要么口味不符，要么司机迟送，每次叫外卖也是游移不定不知道点什么，选择综合症，以至于等到饿了才叫外卖，吃饭时间滞后... 
心想是时候开始给自己做饭了。
买了牛腩跟土豆，开始烧菜，发觉自己很多细节都已忘记，盲目跟随做饭视频，出锅那一刻就觉得哎呀，能填肚子就可以了，还奢求什么！

那土豆烧牛肉的视频讲解中不免有很多细节，甚至于前后矛盾也是有的。
放多少水，用多大火候，先放葱还是后放葱？
这牛肉这土豆是先炸一下还是先用水焯？
作为厨房“文盲”，我对做饭的定义就是“把东西弄熟”而已。
吃着将将可以下咽的牛肉，我想，这种不顾细节的态度，大概是我做不出好菜的原因之一吧。

## 代码

于是我想到最近写代码的事情。
在学校的实验室也好，公司的实验室也好，写代码不为做产品，更多时候为看到结果，所以怎么快怎么来。
给一个变量命名？那就是a, b, 或 c。
要改个参数看看结果如何变化？那就是复制与粘贴。
运行时候出现警告？警告又不是错误，直接忽略。
表面上好像很快，殊不知做数据分析，方法很多，情况很多，十行代码很快就成百上千，这时候可就焦头烂额了。
参数数值改来改去，忘了哪个结果对应哪个数值；
这块代码和那一块看着很像，忘了其中哪里不同；
那行给了警告的代码做了你未料到的事，浪费好长时间才弄明白。

我尝到这些坏习惯的苦果之后，开始培养自己好的习惯，以至于达到类似强迫症的程度。
一些重要的，比如代码重复利用（写函数），用有意义的词命名变量等等自不必多言，
一些不重要的我也很在乎，比如每行代码不至于太长，等号两边留空格等等。
看似简单的习惯，实施起来有看不见的难处，比如变量或函数命名，其实很难很难，有时候左右推敲，总拿不定。
有时候会专门去查某个概念的正确叫法，只为了命名准确。
这种习惯达到高峰之时，每次遇到不确定的情况，会专门去相应的风格指南 (Style Guide) 去查找，给自己设上条条框框，好像写的是八股文。

这是不是矫枉过正呢？
我觉得不是。
我能坚持下来，除了一种美感在里面，更因为尝到甜头；
比如别人问：你能不能改一下这个参数？
十有八九，我可以直接改这个参数，就能看到相应结果。
这背后的努力不可忽视，因为这意味着我没有重复定义这个参数，并且与这个参数相关的其他参数会自动更新。
结果是这代码可以变得很复杂，但同时条理并不紊乱。

这么做不仅结果好，过程也变得容易。
比如重复的代码想办法重复利用，写函数是方法之一。
写函数的时候，从设计到实施，整个问题是独立的，不需考虑这函数外的东西，以至于达到脑资源的高效利用。

其实这些东西对专业的程序员来说，自然是理所应当的；
但是在实验室里搞研究的人，多半是自己摸爬滚打出来的，对这些条条框框执着追求的人大概占少数。
但放眼望去，很多一流程序包的作者都不是计算机科班出身，但凭着超人的学习能力与执着追求，写出优质的包给大家用。

## 画图

再多说一个例子，比如几何，很多问题需要画图解决。
很多小伙伴来问几何题目的时候，我首先让他们仔细把图画好，或者我帮他们画一副好的，
多半时候这题目的答案就显而易见了。
但是这个画好图的建议，却不被珍视，我想，这是他们没意识到画图的重要性吧，就好像我不能理解先放葱花和后放葱花的区别。

但是同时，我也听说那个总拿年级第一的女生，在解代数题目的时候会工工整整一笔一划地写出公式，甚至于可以在面巾纸上做验算。
这对我来说就是没必要的：工整的公式并不像工整的图一样能给你带来新的视角。
我想，不同细节的重要性在每个人眼中也许都是不同的。

## 结语

这篇文章也真是老套了，类似的道理谁没听过呢？“细节决定成败”，这句话被很多人宣扬过吧。
这种类似口号的所谓道理，有时候会被人当做口号对待：随便听听罢了。
这里不高调声称成败能用细节来决定，而是仅仅用我自己的体会，给个小小的注解。

