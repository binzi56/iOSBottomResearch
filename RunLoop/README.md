# RunLoop

RunLoop在iOS开发中是一个比较基础的知识，笔者也从本篇文章正式开启iOS底层探究篇，深入了解iOS底层原理，涨涨姿势，顺便记录一下心路历程。

文章目录
* 初识RunLoop
* RunLoop与线程
* RunLoop的相关类
* RunLoop的执行过程
* RunLoop的应用



学习:
video:
[iOS线下分享《*Run**Loop*》by *孙源*@sunnyxx](https://v.youku.com/v_show/id_XODgxODkzODI0.html?spm=a2h7l.searchresults.soresults.dtitle "iOS线下分享《RunLoop》by 孙源@sunnyxx")
[*Run**Loop*实战上](https://v.youku.com/v_show/id_XMTUwODMwNTQ2OA==.html?spm=a2h7l.searchresults.soresults.dtitle "RunLoop第一讲")
[*Run**Loop*实战下](https://v.youku.com/v_show/id_XMTUwODMyOTI2NA==.html?spm=a2h7l.searchresults.soresults.dtitle "RunLoop实战")
blog:
[深入理解RunLoop](http://blog.ibireme.com/2015/05/18/runloop/)
 [iOS刨根问底-深入理解RunLoop](https://www.cnblogs.com/kenshincui/p/6823841.html)
