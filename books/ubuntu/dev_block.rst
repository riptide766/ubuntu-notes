===================
块设备管理
===================

和块设备有关的都记录在这里 :

>>> whatis losetup
dd (1)               - convert and copy a file
losetup (8)          - set up and control loop devices
mkisofs              - create an iso9660 filesystem
cfdisk (8)           - Curses/slang based disk partition table manipulator

>>> whatis df blkid cfdisk fdisk du
df (1)               - report file system disk space usage
blkid (8)            - locate/print block device attributes
cfdisk (8)           - display or manipulate disk partition table
fdisk (8)            - manipulate disk partition table
du (1)               - estimate file space usage

>>> apropos label
dosfslabel (8)       - set or get MS-DOS filesystem label
e2label (8)          - Change the label on an ext2/ext3/ext4 filesystem
findfs (8)           - find a filesystem by label or UUID
mlabel (1)           - make an MSDOS volume label
ntfslabel (8)        - display/change the label on an ntfs file system
swaplabel (8)        - print or change the label or UUID of a swap area

>>> apropos mkfs
mkfs (8)             - build a Linux filesystem
mkfs.bfs (8)         - make an SCO bfs filesystem
mkfs.ext2 (8)        - create an ext2/ext3/ext4 filesystem
mkfs.ext3 (8)        - create an ext2/ext3/ext4 filesystem
mkfs.ext4 (8)        - create an ext2/ext3/ext4 filesystem
mkfs.ext4dev (8)     - create an ext2/ext3/ext4 filesystem
mkfs.minix (8)       - make a Minix filesystem
mkfs.msdos (8)       - create an MS-DOS file system under Linux
mkfs.ntfs (8)        - create an NTFS file system
mkfs.vfat (8)        - create an MS-DOS file system under Linux

备份一个liveusb
===================

备份U盘文件，备份U盘MBr

>>> tar cvjf liveusb_ext4.tar.bz /media/PENDRIVE
>>> sudo dd if=/dev/sdb of=liveusb.mbr bs=512 count=1

磁盘分区
==================

>>> cfdisk /dev/sda


启用swap分区
===================

>>> swapon /dev/sda9

file 判断文件类型
==================

>>> file cursor/
cursor/: directory

>>> file fedora.iso 
fedora.iso: # ISO 9660 CD-ROM filesystem data 'Fedora-16-i686-Live-Desktop.iso ' (bootable)

>>> file /media/mylivecd/SOURCES.img
/media/mylivecd/SOURCES.img: Squashfs filesystem, little endian, version 4.0, 421922764 bytes, 273 inodes, blocksize: 131072 bytes, created: Thu Mar 25 04:02:55 2010

mkisofs 制作ISO
================

把test目录转换成 test.iso

>>> mkisofs -o test2.iso test/

mount 挂载设备
====================

加载文件系统(块设备)

* /etc/fstab 自动挂载配置文件
* /etc/mtab 加载设备的记录


-a  加载/etc/fstab
-L  加载指定标签的文件系统
-o  选项
    rw
    ro
    remount
-t  指定文件系统类型
    iso9660
    ntfs
    auto
-v  详细信息

>>> sudo mount -v -t vfat -o ro /dev/sda1 /media/xp
/dev/sda1 on /media/xp type vfat (ro)

>>> sudo mount -L OS_XP /media/xp

>>> sudo mount LABEL=OS_XP -o iocharset=utf8 /media/xp


设置标签
==========================

文件系统设置标签

如: dosfslabel ntfslabel e2label

>>> sudo dosfslabel /dev/sda1 OS_XP
>>> sudo dosfslabel /dev/sda1
OS_XP

losetup
============

设置loop设备 , **把文件虚拟成块设备**

    查看

    >>> losetup /dev/loop0 

    建立

    >>> losetup /dev/loop0 ~/diskfile

    卸载

    >>> losetup -d /dev/loop0


df
===========

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

连同虚拟文件系统一起显示

>>> df -a
文件系统            1K-块     已用     可用 已用% 挂载点
/dev/sda8         9733688  5742652  3502796   63% /
proc                    0        0        0     - /proc
sysfs                   0        0        0     - /sys
none                    0        0        0     - /sys/fs/fuse/connections
none                    0        0        0     - /sys/kernel/debug
none                    0        0        0     - /sys/kernel/security
udev               505460        8   505452    1% /dev
devpts                  0        0        0     - /dev/pts
tmpfs              205084      832   204252    1% /run
none                 5120        0     5120    0% /run/lock
none               512700      280   512420    1% /run/shm
/dev/sda6        52825064 44168836  6009804   89% /home
/dev/sda5        51199120 10681240 40517880   21% /media/sda5
binfmt_misc             0        0        0     - /proc/sys/fs/binfmt_misc
gvfs-fuse-daemon        0        0        0     - /home/matt/.gvfs
/dev/sdb1         3811020     1912  3809108    1% /media/6859-59EB



fdisk
================

操作磁盘分区表，一般就简单使用。

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
=============

块设备属性

>>> sudo blkid /dev/sda1
/dev/sda1: UUID="B07D-272A" TYPE="vfat" LABEL="OS_XP" 

>>> sudo blkid
/dev/sda1: UUID="B07D-272A" TYPE="vfat" LABEL="OS_XP" 
/dev/sda5: LABEL="backup" UUID="7C30CF4030CEFFDE" TYPE="ntfs" 
/dev/sda6: UUID="8f2c7343-f892-488e-a4e3-1bf00a20449b" TYPE="ext4" 
/dev/sda7: UUID="3bbeddd8-a55b-4204-b11f-1e96ca765fb8" TYPE="ext4" 
/dev/sda8: UUID="a4aa011d-9980-41b0-af6d-82483c9d2c91" TYPE="swap"

