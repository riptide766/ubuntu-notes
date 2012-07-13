Ubuntu学习笔记
-------------------

不仅记录Ubuntu系统日常使用上的问题。还包括一些：

* linux/bash 的总结
* linux历史
* IT术语表
* LFS 笔记

编写工具
---------

**本笔记采用reStructedText标记语言编写，配合sphinx生成html**


如何生成网页和查阅
-------------------

1. 编译

>>> ./makebook.sh

2. 打开index.html 添加书签

>>> firefox build/build/html/index.html


辅助批处理
---------------

- build.sh 构建脚本(编译, 清理, 修复链接)

- deploy.sh 发布脚本. 将最新版本发布到gh-pages分支

- makebook.sh 完整构建的快速方式

- quickmake.sh 构建本地版.(不修复链接)


在线访问
-------------

编译好的html版会提交到pg分支，由git托管。

`点击访问 <http://riptide766.github.com/ubuntu-notes/books/>`_


