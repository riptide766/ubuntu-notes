========================
准备工作 - 进入目标系统
========================

创建必要的系统目录，挂载上和内核、硬件、进程交互的虚拟文件系统后，使用chroot进入目标系统。

目标系统还是个空系统，在这个空系统使用的命令都是位于/tools下面的


挂载虚拟内核文件系统
--------------------------

.. code-block:: bash

    mkdir -pv $LFS/{dev,proc,sys}
    mknod -m 600 $LFS/dev/console c 5 1
    mknod -m 666 $LFS/dev/null c 1 3
    mount --bind /dev $LFS/dev
    mount -vt devpts devpts $LFS/dev/pts
    mount -vt tmpfs shm $LFS/dev/shm
    mount -vt proc proc $LFS/proc
    mount -vt sysfs sysfs $LFS/sys

========  ========================
目录        用途
========  ========================
/dev      设备文件
/proc     进程文件系统proc的根目录
/sys      设备配置信息的根目录   
========  ========================


* mknod 
  
 创建特殊文件（块 b ; 字符 c ; 管道 p）

 最后两位数字是主设备号和次设备号。

 主设备号对应驱动程序。

 次设备号是区分。（一个驱动可能对应很多设备）


* virtual file system
    
  devpts，devtmpfs， proc，sysfs 什么的都是虚拟的文件系统。

  挂载之后，这些目录下会出现文件。它们其实并不是真实存在于硬盘上。

  虚拟文件系统，隐藏硬件的具体细节，为所有设备提供一个统一的接口。可以像普通文件一样，通过读写与进程、硬件以及内核进行通讯。


* tmpfs

  tmpfs是一个 **ramdisk** 。读写速度快，关机会清空内容。

  现在 **tmp shm run** 这些常用的临时目录都挂载这种文件系统。

    


改变根目录
----------------

.. code-block:: bash

    chroot "$LFS" /tools/bin/env -i \
    HOME=/root TERM="$TERM" PS1='\u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h


这句话含有三个命令: chroot、env、bash。


chroot
```````

run command or interactive shell with special root directory

执行命令的例子

>>> sudo chroot --userspec=lfs:lfs / whoami
lfs


env
``````

run a program in a modified environment


显示用户变量

>>> env


忽略用户变量

>>> env -i
>>> env -


修改环境变量执行命令

>>> cat script
echo $PATH
>>> env PATH=test ./script


bash
`````

- **--login** -- Make bash act as if it had been invoked as a login shell

    
    :ref:`登录Bash启动读取的配置文件和和非登录的有区别 <bash_startup_file>` ,但这里的login感觉没什么必要。理由是没什么启动文件需要读的，因为还没有呢。而需要用到的环境变量在前面的env里都指定了


- **+h** -- 关闭hash功能，每次都通过path查找命令


     


