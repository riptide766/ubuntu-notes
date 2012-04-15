权限管理
==============

**和权限粘点边,用过的都记录到这里来...**

install  chown umask mknod  

useradd usermod userdel  passwd whoami id users

groupadd chgrp

visudo su sudo 


umask
----------

目录默认权限是777, 文件默认的权限是666 。 umask的值是实际要扣去的权限

>>> umask
0002

所以实际上目录的权限是775, 文件的权限是664

>>> ll -d d f
drwxrwxr-x 2 test test 4096  4月 15 13:13 d/
-rw-rw-r-- 1 test test    0  4月 15 13:13 f




.. _config_passwd:

/etc/passwd文件
----------------

格式

 ::

    name:password:uid:gid:comment:home:shell 

.. _config_group:

/etc/group文件
----------------

格式
 
 ::

    group_name:passwd:GID:user_list


伪用户
-----------

    有的地方也叫管理用户。用户id是 **1-499** . root 是 0.

    伪用户的说法可能是突出它不能登录

    管理用户的说法可能是突然程序对文件用户属性的要求。不知道具体是什么逻辑。存疑吧


粘位符
-------

777就不解释了，前面的1就是粘位符。

用1777设置目录的话，在这个目录下不能修改和删除其他用户的文件。

下面这句命令来自LFS，意思是用 **1777** 创建/tmp， /var/tmp目录。

>>> install -dv -m 1777 /tmp /var/tmp


sudo
--------

让用户可以使用sudo命令

>>> sudo adduser test admin
正在添加用户"test"到"admin"组...
正在将用户“test”加入到“admin”组中
完成。


visudo
-----------

编辑/etc/sudoers文件.

比打开文件强点。保证只有一个人在编辑

>>> sudo visudo

* 如何控制sudo认证有效时间？

  添加一个定义

  ::

    Defaults	timestamp_timeout=-1


id
----------------

查看用户和组


>>> id
uid=1001(test) gid=1001(test) 组=1001(test),118(admin),1000(xxx)




Ubuntu使用root用户
-------------------

需要设置密码

>>> sudo passwd root

或者

>>> sudo su


建立一个用户
-------------------------

之前学过，不过有更方便的图形界面，所以一直有为赋新诗强说愁的感觉。

下面倒是一个挺实际的应用。

LFS里建立工具链之前的准备工作:建立一个用户，用于防止误操作。


.. note:: su - lfs 切入到lfs用户，并进入lfs的主目录

>>> groupadd lfs
>>> useradd -s /bin/bash -g lfs -m -k /dev/null lfs
>>> passwd lfs
>>> chown -v lfs /mnt/lfs/tools
>>> chown -v lfs /mnt/lfs/sources
>>> su - lfs
>>> chown -R root:root /mnt/lfs/tools


