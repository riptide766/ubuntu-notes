=====================
周边基础 - Makefile
=====================


目标、条件、命令列表
======================

欲更新目标，必须首先更新它的所有条件；所有条件中只要有一个条件被更新了，目标也必须随之被更新。

所谓“更新”就是执行一遍规则中的命令列表。

只要执行了命令列表就算更新了目标，即使目标并没有生成也算。

规则
-------

::

    target ... : prerequisites ... 
        command1
        command2
        ...

目标
-------------


* 默认目标
  
  第一条规则的目标称为缺省目标，只要缺省目标更新了就算完成

* 伪目标

* 内建目标



规则的规则
-----------

如果一条规则的目标属于以下情况之一，就称为需要更新：

- 某个条件需要更新。

- 某个条件的修改时间比目标晚。

- 目标没有生成。


在一条规则被执行之前，规则的条件可能处于以下三种状态之一：

- 需要更新。能够找到以该条件为目标的规则，并且该规则中目标需要更新。

- 不需要更新。能够找到以该条件为目标的规则，但是该规则中目标不需要更新；或者不能找到以该条件为目标的规则，并且该条件已经生成。

- 错误。不能找到以该条件为目标的规则，并且该条件没有生成。


执行一条规则A的步骤如下：

1. 检查它的每个条件P：

    - 如果P需要更新，就执行以P为目标的规则B。之后，无论是否生成文件P，都认为P已被更新。

    - 如果找不到规则B，并且文件P已存在，表示P不需要更新。

    - 如果找不到规则B，并且文件P不存在，则报错退出。

2. 在检查完规则A的所有条件后，检查它的目标T，如果属于以下情况之一，就执行它的命令列表：

    - 文件T不存在。

    - 文件T存在，但是某个条件的修改时间比它晚。

    - 某个条件P已被更新（并不一定生成文件P）。



命令
-------

* @ 显示命令本身

* - 命令出错，make命令不会被中断


Make和选项
============

自动查找makefile文件，运行默认目标

>>> make

运行

>>> make -C dir

打印，不执行命令列表

>>> make -n

执行clean伪目标

>>> make clean


打印隐含规则

>>> make -p 

设置默认变量

>>> make CFLAGS=-g 


变量
========

* $(x) 引用变量

*  = 延迟展开变量

* := 立即展开变量
  
* ?= 如果变量没有定义过相当于=号，否则什么也不做

* += 追加变量值，维持=号的特性

* $@，表示规则中的目标。

* $<，表示规则中的第一个条件。

* $?，表示规则中所有比目标新的条件，组成一个列表，以空格分隔。

* $^，表示规则中的所有条件，组成一个列表，以空格分隔。



实例
========

编译c

.. code-block:: makefile


    main: main.o stack.o maze.o
            gcc main.o stack.o maze.o -o main

    main.o: main.c main.h stack.h maze.h
            gcc -c main.c

    stack.o: stack.c stack.h main.h
            gcc -c stack.c

    maze.o: maze.c maze.h main.h
            gcc -c maze.c

    clean:
        @echo "cleanning project"
        -rm main \*.o
        @echo "clean completed"

    .PHONY: clean


>>> make
gcc -c main.c
gcc -c stack.c
gcc -c maze.c
gcc main.o stack.o maze.o -o main



编译c的简化版本： 隐含规则

.. code-block:: makefile

    all: main

    main: main.o stack.o maze.o
        gcc $^ -o $@

    main.o: main.h stack.h maze.h
    stack.o: stack.h main.h
    maze.o: maze.h main.h

    clean:
        -rm main \*.o

    .PHONY: clean

>>> make
cc    -c -o main.o main.c
cc    -c -o stack.o stack.c
cc    -c -o maze.o maze.c
gcc main.o stack.o maze.o -o main



arch-install-scripts的Makefile

.. code-block:: makefile

    V=5

    PREFIX = /usr/local

    BINPROGS = \
        arch-chroot \
        genfstab \
        pacstrap

    all: $(BINPROGS)

    %: %.in Makefile common
        @printf '  GEN\t%s\n' "$@"
        @$(RM) "$@"
        @m4 -P $@.in >$@
        @chmod a-w "$@"
        @chmod +x "$@"

    clean:
        $(RM) $(BINPROGS)

    install: all
        install -dm755 $(DESTDIR)$(PREFIX)/bin
        install -m755 ${BINPROGS} $(DESTDIR)$(PREFIX)/bin
        install -Dm644 zsh-completion $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_archinstallscripts

    uninstall:
        for f in ${BINPROGS}; do $(RM) $(DESTDIR)$(PREFIX)/bin/$$f; done
        $(RM) $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_archinstallscripts

    dist:
        git archive --format=tar --prefix=arch-install-scripts-$(V)/ v$(V) | gzip -9 > arch-install-scripts-$(V).tar.gz
        gpg --detach-sign --use-agent arch-install-scripts-$(V).tar.gz

    .PHONY: all clean install uninstall dist

>>> make
printf '  GEN\t%s\n' "arch-chroot"
rm -f "arch-chroot"
m4 -P arch-chroot.in >arch-chroot
chmod a-w "arch-chroot"
chmod +x "arch-chroot"
printf '  GEN\t%s\n' "genfstab"
rm -f "genfstab"
m4 -P genfstab.in >genfstab
chmod a-w "genfstab"
chmod +x "genfstab"
printf '  GEN\t%s\n' "pacstrap"
rm -f "pacstrap"
m4 -P pacstrap.in >pacstrap
chmod a-w "pacstrap"
chmod +x "pacstrap"

