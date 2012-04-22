=======================
理解Linux启动
=======================

1. 系统启动（BIOS）
#. 引导程序 （Bootloader）
    1. stage 1 (MBR)
    2. stage 2 
#. 内核启动 （Kernel）
#. 启动控制 (Init)
#. 登录管理 (LightDM)
#. 交互环境 (/etc/profile)

.. .. image:: ./pics/linux_boot_load.gif

系统启动（BIOS）
=================

:term:`CMOS` 是一个可读写的RAM，记录一些配置信息， 比如从硬盘启动。 

:term:`BIOS` 是一个程序，开机 :term:`POST` 后，根据 :term:`CMOS` 的设置搜索处于活动状态的可引导设备。

然后 **BIOS交权给MBR**


引导程序 （Bootloader）
=====================

Bootloader有许多种，这里讲Ubuntu实际应用的GRUB2。

GRUB2有个命令：grub-install，install GRUB to a device。这个命令的帮助里有这句话

::
  
 grub-install copies GRUB images into /boot/grub, and uses grub-setup to install grub into the boot sector.
 
所以平常说的stage1(MBR)和stage2只是一个程序分开放在两处。BIOS引导MBR，MBR引导GRUB2，GRUB2引导Kernel。

Stage 1
^^^^^^^^^^^^^^^^^^^^^

:term:`MBR` 位于硬盘第一个扇区。由三部分组成引导程序、分区表、特殊结束字节

前446字节的引导程序会直接去引导stage2 

* MBR的结构

.. image:: ./pics/mbr.gif

::

    512 = 446 + (4 X 16) + 2


* 通过命令，读取显示MBR里的 **分区表和结束标志位** ，具体观察下。

>>> sudo dd if=/dev/sda of=mbr.bin bs=1 skip=446 count=66
记录了66+0 的读入
记录了66+0 的写出
66字节(66 B)已复制，0.000403999 秒，163 kB/秒
>>> xxd mbr.bin 
0000000: 8001 0100 0cfe ffff 3f00 0000 72a1 a903  ........?...r...
0000010: 0000 feff 0f35 f4ff eea1 a903 12f6 f70e  .....5..........
0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000040: 55aa  


.. note:: 为什么只用4个分区表记录? 够不够用？

    因为就是这样，只能有四个分区表记录，对应四个主/扩展分区。

    不过扩展分区可以划逻辑分区。


Stage 2
^^^^^^^^^^^^^^^^^^^^^^

这个阶段的GRUB能够提供文件系统的查询以及一些交互等功能。任务是加载 Linux 内核和可选的初始 RAM 磁盘。

下面是/boot/grub/grub.cfg里某个菜单选项的片段。也可以直接在grub的shell里输入执行。

::

	set root='(hd0,msdos8)'
	search --no-floppy --fs-uuid --set=root 577f602b-deab-440b-8bd9-9995ccff351d
	linux	/boot/vmlinuz-3.2.0-23-generic root=UUID=577f602b-deab-440b-8bd9-9995ccff351d ro   quiet splash acpi=off  $vt_handoff
	initrd	/boot/initrd.img-3.2.0-23-generic

    
根据 `GRUB官方手册 <http://www.gnu.org/software/grub/manual/grub.html>`_ 的说明，这四句的大意是

1. 设置环境变量root。如果在其他表示路径却没有显式的标识设备的地方，都会把这个当作默认。
#. 查找指定的设备(by uuid)。如果存在就设置到指定的环境变量里。 （第一、二句算个双保险吧）
#. 装载一个内核映像。**vmlinuz-3.2.0-23-generic** 之后的都是内核参数。root是指定根文件系统。其他参数见: `Kernel Paramters <http://www.kernel.org/doc/Documentation/kernel-parameters.txt>`_
#. 装载一个initrd。

会这四句，可保万世....


内核启动
=================

GRUB2 加载两个东西。一个是vmlinuz，一个是initrd。

它们都是什么？ 起什么作用？


vmlinuz是什么
^^^^^^^^^^^^^^^^^

vmlinuz就是linux的kernel。

::
   
 它负责管理系统的进程、内存、设备驱动程序、文件和网络系统。


.. image:: ./pics/kernel.jpg
  
.. image:: ./pics/linux_arch.jpg

如果自己编译一个内核就比较直观，可以自己选择需要的功能。并设定是 **内核模块** 还是 **内置编译**

>>> make menuconfig

.. image:: ./pics/menuconfig.png



initrd是什么
^^^^^^^^^^^^^^^

这东西主要发行版本为了兼容。

安装发行版本的时候，它可能面对各种各样的硬件。

linux内核可以模块化的，所以它不是很大。

>>> sudo du -sh /boot/vmlinuz-3.2.0-23-generic 
4.7M	/boot/vmlinuz-3.2.0-23-generic



另外资料里说

 ::
 
  initrd是一个小型的文件系统。内部包含启动所需的命令和内核模块。


那initrd具体是什么？ 还可以解压出来，直接看看...

>>> cp /boot/initrd.img-3.0.0-12-generic  .
>>> file initrd.img-3.0.0-12-generic
initrd.img-3.0.0-12-generic: gzip compressed data, from Unix, last modified: Wed Apr  4 22:03:00 2012
>>> 7z x initrd.img-3.0.0-12-generic 
>>> file initrd.img-3.0
initrd.img-3.0: ASCII cpio archive (SVR4 with no CRC)
>>> cpio -ivmd < initrd.img-3.0
>>> ls -F
bin/   etc/   initrd.img-3.0               lib/  sbin/
conf/  init*  initrd.img-3.0.0-12-generic  run/  scripts/



启动控制
=================

所有程序的父进程，可通 **pstree** 直观的查看。

>>> pstree | head -n 1
init-+-/usr/bin/termin-+-/usr/bin/termin


登录管理
=================

Ubuntu最新的几个版本所用的登录管理程序都是LightDM。其他linux的发行版也有用KDM的。

可以选择不同的登录用户和桌面系统。


交互环境
================

用户登录后会执行一系列的脚本，初始化。

1. /etc/profile
#. /etc/bash.bashrc
#. ~/.bash_profile
#. ~/.bashrc
#. ~/.bash_aliases

Ubuntu的话，还有一个 **~/.config/autostart** 目录会自动执行里面的desktop文件。

