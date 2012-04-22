===================
Live USB 制作总结
===================

作了一个LiveUSB。4G的U盘，分了三个区。 分别放grub，各种发行版本的iso，以及一个pussy系统。


* 可以引导各个发行版本的ISO进行安装。

* 可以导入使用备份的grub.cfg。

* 也可以直接进入pussy, 当一个随身携带的系统，救急使用。


分区 格式化 打标签
====================

* 分区

    >>> sudo cfdisk /dev/sdb

* 格式化

    >>> sudo mkfs.ext4 /dev/sdb1
    >>> sudo mkfs.ext4 /dev/sdb2
    >>> sudo mkfs.ext4 /dev/sdb3

* 设置标签

    >>> sudo e2label /dev/sdb1 LIVEUSB_BOOT
    >>> sudo e2label /dev/sdb2 LIVEUSB
    >>> sudo e2label /dev/sdb3 LIVEUSB_PUPPY


安装GRUB
====================

安装GRUB之后, 重启就可以按F12选择usb启动了。

    >>> sudo grub-install --root-directory=/mnt /dev/sdb
    >>> sudo gvim /dev/sdb1/boot/grub/grub.cfg
    >>> sudo cp /boot/grub/grub.cfg /media/LIVEUSB_BOOT/boot/grub/grub2.cfg

::
 
    set timeout=10
    set default=0

    menuentry "Run Ubuntu Live ISO" {
     search --label --set=root LIVEUSB
     loopback loop /ubuntu.iso
     linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=/ubuntu.iso splash  --
     initrd (loop)/casper/initrd.lz
    }

    menuentry "Run Arch Live ISO" {
     search --label --set=root LIVEUSB
     loopback loop /archlinux.iso 
     linux (loop)/arch/boot/i686/vmlinuz  plash --
     initrd (loop)/arch/boot/i686/archiso.img
    }

    menuentry "Puppy" {
        search -f --label --set=root LIVEUSB_PUPPY
        linux /puppy528/vmlinuz pmedia=usbhd nosmp
        initrd /puppy528/initrd.gz
    }

    menuentry "Load original grub.cfg" {
        search --label --set=root LIVEUSB_BOOT
        configfile /boot/grub/grub2.cfg
    }

根据 `GRUB官方手册 <http://www.gnu.org/software/grub/manual/grub.html>`_ 的说明，几个用到的命令差不多是这样的：


1. search

    查找指定的设备。如果发现就设置到指定的环境变量里。 可以通过uuid也可以是label
   
    环境变量 **root** 的作用： 如果在其他表示路径却没有显式的标识设备的地方，都会把这个当作默认。

2. loopback 

    挂载映像文件

3. configfile

    指定一个配置文件

4. linux 

 .. warning:: iso-scan这个参数的解释在文档里没用找到。 

 装载一个内核映像。 **vmlinuz** 之后的都是内核参数。参数见: `Kernel Paramters <http://www.kernel.org/doc/Documentation/kernel-parameters.txt>`_

5. initrd

    装载一个initrd。



复制发行版镜像
===============

就是把各种发行版本的镜像复制到U盘第二个分区。


安装Puppy
===========

`Puppy <http://puppylinux.org/main/Overview%20and%20Getting%20Started.htm>`_ 是一个小型的linux，100M左右。
 
相比上面引导的Ubuntu，Puppy有可以保存、速度相对快捷的优点。尴尬时候的使用。

所谓的安装其实就是复制映像里的文件到一个目录

    >>> sudo mount ~/lupu-528.005.iso /mnt
    >>> cp /mnt /media/LIVEUSB_PUPPY/puppy528


