**********************
其他命令
**********************

临时记录一些命令的使用。适时将完整的内容迁移到其他文章里。

lsb_release
------------

查看发行版本

>>> lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu precise (development branch)
Release:	12.04
Codename:	precise


losetup
----------

设置loop设备 , **把文件虚拟成块设备**

    查看

    >>> losetup /dev/loop0 

    建立

    >>> losetup /dev/loop0 ~/diskfile

    卸载

    >>> losetup -d /dev/loop0

ln 
----

连接目录或文件

-b  覆盖时备份。
-V  覆盖时，指定不同备份方式。numbered / t ; simple never ; existing / nil 
-S  指定备份后缀文字
-f  强制覆盖，否者报错。
-i  覆盖时交互。
-s  符号链接
-v  显示命令过程


>>> ln -b -S _backup source target

>>> ln -b -V t source target

mount
--------

加载文件系统(块设备)

* /etc/fstab 自动挂载配置文件
* /etc/mtab 加载设备的记录


-a  加载/etc/fstab
-L  加载指定标签的文件系统
-o  选项
    rw
    ro
-t  指定文件系统类型
    iso9660
    ntfs
    auto
-v  详细信息

>>> sudo mount -v -t vfat -o ro /dev/sda1 /media/xp
/dev/sda1 on /media/xp type vfat (ro)

>>> sudo mount -L OS_XP /media/xp

>>> sudo mount LABEL=OS_XP -o iocharset=utf8 /media/xp


\* lable
--------------------------------

文件系统设置标签

如: dosfslabel ntfslabel e2label

>>> sudo dosfslabel /dev/sda1 OS_XP
>>> sudo dosfslabel /dev/sda1
OS_XP


df
-------------

文件系统使用情况

>>> df
文件系统          1K-块     已用     可用 已用% 挂载点
/dev/sda6      19465224  6035152 12453536   33% /
udev             505448       12   505436    1% /dev
tmpfs            205084      804   204280    1% /run
none               5120        0     5120    0% /run/lock
none             512700      160   512540    1% /run/shm
/dev/sda7      52825064 42313336  7865304   85% /home
/dev/sda5      51199120 47634576  3564544   94% /media/sda5
/dev/sda1      30709264 16087984 14621280   53% /media/xp

>>> df -hT
文件系统       类型      容量  已用  可用 已用% 挂载点
/dev/sda6      ext4       19G  5.8G   12G   33% /
udev           devtmpfs  494M   12K  494M    1% /dev
tmpfs          tmpfs     201M  804K  200M    1% /run
none           tmpfs     5.0M     0  5.0M    0% /run/lock
none           tmpfs     501M  160K  501M    1% /run/shm
/dev/sda7      ext4       51G   41G  7.6G   85% /home
/dev/sda5      fuseblk    49G   46G  3.4G   94% /media/sda5
/dev/sda1      vfat       30G   16G   14G   53% /media/xp


fdisk
-------

操作磁盘分区表，一般的简单使用。

>>> sudo fdisk -l
Disk /dev/sda: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders, total 312581808 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xbf5fbf5f
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *          63    61448624    30724281    c  W95 FAT32 (LBA)
/dev/sda2        61448686   312580095   125565705    f  W95 Ext'd (LBA)
/dev/sda5        61448688   163846934    51199123+   7  HPFS/NTFS/exFAT
/dev/sda6       163848192   202909695    19530752   83  Linux
/dev/sda7       202911744   308768767    52928512   83  Linux
/dev/sda8       308770816   312580095     1904640   82  Linux swap / Solaris


blkid
--------

块设备属性

>>> sudo blkid /dev/sda1
/dev/sda1: UUID="B07D-272A" TYPE="vfat" LABEL="OS_XP" 

>>> sudo blkid
/dev/sda1: UUID="B07D-272A" TYPE="vfat" LABEL="OS_XP" 
/dev/sda5: LABEL="backup" UUID="7C30CF4030CEFFDE" TYPE="ntfs" 
/dev/sda6: UUID="8f2c7343-f892-488e-a4e3-1bf00a20449b" TYPE="ext4" 
/dev/sda7: UUID="3bbeddd8-a55b-4204-b11f-1e96ca765fb8" TYPE="ext4" 
/dev/sda8: UUID="a4aa011d-9980-41b0-af6d-82483c9d2c91" TYPE="swap"


date
------

>>> date
2012年 03月 30日 星期五 12:34:01 CST

>>> date -R
Fri, 30 Mar 2012 12:33:25 +0800

>>> date -u
2012年 03月 30日 星期五 04:33:46 UTC

>>> date +%Y%m%d-%H:%M:%S
20120330-12:36:38


chmod
-------

设置读写权限对文件的所有者，清空所有权限对file的用户组和其他用户
    
>>> chmod u=rw,go= file


对目录docs和其子目录层次结构中的所有文件增加所有用户的读权限，而对用户组和其他用户删除读权限

chmod -R u+r,go-r docs

