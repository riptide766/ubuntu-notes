准备工作 - 创建系统结构
=========================

创建系统目录结构
-----------------

目录结构有个标准 :term:`Filesystem Hierarchy Standard (FHS)` ,但没有要求完全遵守。每个发行版都会有点不一样

.. code-block:: bash

    mkdir -pv /{bin,boot,etc/opt,home,lib,mnt,opt}
    mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
    install -dv -m 0750 /root
    install -dv -m 1777 /tmp /var/tmp
    mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
    mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
    mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
    mkdir -pv /usr/{,local/}share/man/man{1..8}
    for dir in /usr /usr/local; do
      ln -sv share/{man,doc,info} $dir
    done
    mkdir -v /var/{lock,log,mail,run,spool}
    mkdir -pv /var/{opt,cache,lib/{misc,locate},local}


根目录
"""""""

.. note::

    install -d -m 创建目录并设置权限; 1777的1是粘位符
    
>>> mkdir -pv /{bin,boot,etc/opt,home,lib,mnt,opt}
>>> mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
>>> install -dv -m 0750 /root
>>> install -dv -m 1777 /tmp /var/tmp

==============  ========================================================
目录                用途
==============  ========================================================
/bin            各种用户(系统，系统用户，普通用户)可共享的常用命令 好像大多数来源与coreutils
/boot           系统引导程序, 内核程序文件 **vmlinuz**, 磁盘内存映像 **initrd** 
/etc            各种配置文件
/etc/opt        附加软件的配置文件
/home           用户主目录的根目录 
/lib            内核模块和动态链接库
/mnt            文件系统临时安装点。（手动命令mount）
/opt            附加软件的安装目录。（比如 adobe的air应用）
/media          自动挂载的文件系统会mount到这个目录
/media/floopy
/media/cdrom
/sbin           系统引导、管理、维护有关的命令
/srv            放系统服务进程所用的数据文件
/var            放可变长文件(日志文件)、暂存文件(apt下载的deb包)、待处理文件. **(可单独一个文件系统)**
/root           root用户的主目录
/tmp
/var/tmp
==============  ========================================================


usr目录
"""""""""
    
.. note:: **/usr和/usr/local的区别**

    前者随发行版本用，后者是系统管理员用。下面/usr/local/\* 被省略


>>> mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}  

==================  ========================================================
目录                用途
==================  ========================================================
/usr                放共享数据。系统发行所自带的。 **(可单独一个文件系统)**
/usr/bin            命令(用户常用)
/usr/include        头文件
/usr/lib            库函数
/usr/sbin           系统引导之后，系统管理和维护用的命令
/usr/src            源代码
/usr/local          本地管理员管理的目录
==================  ========================================================


>>> mkdir -pv /usr/{,local/}share/{doc,info,locale,man}

========================  =================
目录                        用途
========================  =================
/usr/share                  共享目录
/usr/share/doc              软件包文档
/usr/share/info             Gnu info 文档
/usr/share/locale           语言环境
/usr/share/man              联机文档
========================  =================


>>> mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}

=========================  =================================================================
目录                        用途
=========================  =================================================================
/usr/share/misc             和系统独立的杂项文件目录 **没感受，不太懂**
/usr/share/terminfo         一个描述终端符号的数据库，使用屏幕向导程序…… **没感受，不太懂**
/usr/share/zoneinfo         时区定义
=========================  =================================================================



>>> mkdir -pv /usr/{,local/}share/man/man{1..8}

=============================   ================================================================
目录                            用途
=============================   ================================================================
/usr/share/man/man1             Executable programs or shell commands
/usr/share/man/man2             System calls (functions provided by the kernel)
/usr/share/man/man3             Library calls (functions within program libraries)
/usr/share/man/man4             Special files (usually found in /dev)
/usr/share/man/man5             File formats and conventions eg /etc/passwd
/usr/share/man/man6             Games
/usr/share/man/man7             Miscellaneous  (including  macro  packages  and  conventions)
/usr/share/man/man8             System administration commands (usually only for root)
=============================   ================================================================


.. note:: ln -sv share/{man,doc,info} $dir 分别建立/usr，/usr/local的是相对路径的链接。 

>>> for dir in /usr /usr/local; do
>>>  ln -sv share/{man,doc,info} $dir
>>> done

var目录
""""""""

.. note:: ubuntu的实际情况
    
    /run和/var/run是链着点的; /run/lock和/var/lock是链着的

>>> mkdir -v /var/{lock,log,mail,run,spool}
>>> mkdir -pv /var/{opt,cache,lib/{misc,locate},local}

==================  ====================================
目录                用途
==================  ====================================
/var/lock           服务进程访问特定设备和文件的封锁文件
/var/log            系统日志
/var/mail           各个用户的邮箱文件
/var/run            系统运行信息文件
/var/spool          缓存待处理文件
/var/opt            
/var/cache          
/var/lib
/var/lib/misc
/var/lib/locate
/var/local
==================  ====================================


构建必须的链接和文件
---------------------------


.. note:: 为什么链接一些命令？ 编译的时候可能会按绝对的路径找东西。

    感觉不太靠谱，算经验的东西。比如：更新的版本可能就不需要这样了

.. code-block:: bash

    ln -sv /tools/bin/{bash,cat,echo,grep,pwd,stty} /bin
    ln -sv /tools/bin/perl /usr/bin
    ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
    ln -sv bash /bin/sh
    touch /etc/mtab
    touch /var/run/utmp /var/log/{btmp,lastlog,wtmp}


==================  ============================
文件                    用途
==================  ============================
/etc/mtab           mount的清单文件
==================  ============================

构建用户和组
----------------

:ref:`config_passwd`

:ref:`config_group`

.. note:: 第一条命令的意思

    exec /tools/bash 替换旧的交互shell

    \-\-login 替换的shell是登录启动。也就是说会按常规读取一系列脚本

    +h 关闭hash。 也就是说，不会缓存执行过的命令，每次都会再到路径里去找

.. code-block:: bash

    exec /tools/bin/bash --login +h

构建日志和临时文件
--------------------

.. code-block:: bash

    chgrp -v utmp /var/run/utmp /var/log/lastlog
    chmod -v 664 /var/run/utmp /var/log/lastlog

==================  ============================
文件                    用途
==================  ============================
/var/run/utmp       记录着现在登录的用户。
/var/log/wtmp       记录所有的登录和退出。
/var/log/lastlog    记录每个用户最后的登录信息。
/var/log/btmp       记录错误的登录尝试
==================  ============================

