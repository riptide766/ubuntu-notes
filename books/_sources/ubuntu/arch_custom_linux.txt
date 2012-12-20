=========================
堆砌archlinux (一)
=========================


堆砌原理和工具
=================


原理
----------

堆砌的原理就是没什么原理，把二进制包和配置文件复制来复制去就好了。

通过两个脚本计算依赖并复制文件到 **新系统** 。在这个过程中，还会额外生成三个文件.

* dependlist 相关软件包的列表

* decfile 相关软件包的简单描述

* etclist 各个软件包相关的配置文件


|


上述的文件可以帮组我了解

* 系统主要的软件包
  
* 相关的配置文件


|


最后，引导这个新系统，验证下。


工具
----------

.. code-block:: bash


    #!/bin/bash

    cachedir=/tmp/customlinux
    cachelist="$cachedir/dependlist"
    desclist="$cachedir/descfile"

    mkdir -p $cachedir

    function countdepend(){
        dependlist=`pactree -ul $1 | cut -d" " -f1`
        [  -a $cachelist ] || echo > $cachelist
        for item in $dependlist ; do
            grep -q -e "^$item$" "$cachelist"
            if [[ $? != 0  ]] ; then
                # 打印软件包名，记录到文件
                echo $item | tee -a $cachelist
                # 以两行的形式记录软件包的名字和描述，记录到文件里
                pacman -Qi $item | grep Desc | sed -e "s/\(Description\s*\):\(.*\)/$item\n\t\2/" >> $desclist
            fi
        done
    }

    for pkg in $@ ; do
        countdepend $pkg
    done


.. code-block:: bash

    targetdir=/media/customlinux


    cachedir=/tmp/customlinux
    cachelist="$cachedir/dependlist"
    desclist="$cachedir/descfile"
    cachelist="$cachedir"/dependlist
    installedlist="$cachedir"/installedlist
    etclist="$cachedir"/etclist

    mkdir -p $cachedir

    function cpkg(){
        grep -q -e "$1$" $installedlist
        [ $? == 0 ] && return
        for f in `pacman -Ql $1 | cut -d" " -f2    `; do
            [ -d $f  ] && mkdir -p "$targetdir"$f || cp -v $f "$targetdir"$f
            # 记录软件相关的配置文件
            [ ${f:1:3} == "etc" ] && echo "$1 --- $f" >> $etclist
        done
        echo $1 >> $installedlist
    }


    for pkg in \`cat $cachelist\` ; do
        cpkg $pkg
    done



引导和修改系统
-----------------


堆砌了系统，那能够用了么？不行， 还需要有东西引导它。

最简单方法：直接用当前系统的grub检查下新系统就行了。

原理就是它去各个挂载点找/boot目录,看见内核和内存盘就视为一个系统，然后据此生成新的grub.cfg

有了系统，有了引导，还需要修改必要的配置文件，比如fstab、passwd、shells、rc.conf什么的

>>> /boot/grub grub-mkconfig -o /boot/grub/grub.cfg





堆砌过程
==============

目标
------

我的目标是一个能够运行w3m的archlinux，今后可以直接移动到liveusb当急救系统用。


过程
-------


挂一个无用的分区，作为新系统的根目录

>>> mkdir /media/customlinux
>>> mount /dev/sda10 /media/customlinux

计算w3m依赖

>>> countdependence.sh w3m
w3m
openssl
perl
gdbm
glibc
linux-api-headers
tzdata
bash
readline
ncurses
db
gcc-libs
coreutils
pam
cracklib
zlib
libtirpc
libgssglue
pambase
acl
attr
gmp
libcap
gc

计算init程序sysvinit的依赖

>>> countdependence.sh sysvinit
sysvinit
util-linux
gawk


>>> countdependence.sh initscripts 
initscripts
systemd-tools
glib2
pcre
libffi
libsystemd
xz
kmod
hwids
kbd
iproute2
findutils

计算ip配置工具的依赖

>>> countdependence.sh iputils
iputils
sysfsutils


>>> countdependence.sh dhcpcd
dhcpcd

计算linux内核的依赖

>>> countdependence.sh linux 
linux
linux-firmware
mkinitcpio
mkinitcpio-busybox
libarchive
bzip2
expat
grep
filesystem
iana-etc
file
gzip


根据依赖复制文件

>>> cpkg.sh 

复制内核和内存盘

>>> cp /boot/vmlinuz-linux boot
>>> cp /boot/initramfs-linux.img boot

配置
-------

archlinux下面的lib其实已经空掉了，为了兼容，需要软链到usr/lib


>>> cd /media/customlinux
>>> rmdir lib
>>> ln -s usr/lib lib

chroot到这个环境，看看有无问题

>>> env -i PATH=/bin:/usr/bin /usr/sbin/chroot /media/customlinux bash
>>> exit


调整挂载点

>>> cd etc
>>> vi fstab

当前系统默认的shell是zsh，新系统还原成bash

>>> vi sheel
>>> vi passwd

清空mtab，要不然会新系统会挂错分区

>>> vi mtab

去掉不必要daemon，保留network

>>> vi rc.conf


重启
------------

>>> /boot/grub grub-mkconfig -o /boot/grub/grub.cfg
>>> reboot

结果文件
================

现在来看下


软件包描述
------------

::

    w3m
         Text-based Web browser, as well as pager
    openssl
         The Open Source toolkit for Secure Sockets Layer and Transport Layer Security
    perl
         A highly capable, feature-rich programming language
    gdbm
         GNU database library
    glibc
         GNU C Library
    linux-api-headers
         Kernel headers sanitized for use in userspace
    tzdata
         Sources for time zone and daylight saving time data
    bash
         The GNU Bourne Again shell
    readline
         GNU readline library
    ncurses
         System V Release 4.0 curses emulation library
    db
         The Berkeley DB embedded database system
    gcc-libs
         Runtime libraries shipped by GCC
    coreutils
         The basic file, shell and text manipulation utilities of the GNU operating system
    pam
         PAM (Pluggable Authentication Modules) library
    cracklib
         Password Checking Library
    zlib
         Compression library implementing the deflate compression method found in gzip and PKZIP
    libtirpc
         Transport Independent RPC library (SunRPC replacement)
    libgssglue
         Exports a gssapi interface which calls other random gssapi libraries
    pambase
         Base PAM configuration for services
    acl
         Access control list utilities, libraries and headers
    attr
         Extended attribute support library for ACL support
    gmp
         A free library for arbitrary precision arithmetic
    libcap
         POSIX 1003.1e capabilities
    gc
         A garbage collector for C and C++
    linux
         The Linux Kernel and modules
    linux-firmware
         Firmware files for Linux
    kmod
         Linux kernel module handling
    mkinitcpio
         Modular initramfs image creation utility
    gawk
         GNU version of awk
    mkinitcpio-busybox
         base initramfs tools
    util-linux
         Miscellaneous system utilities for Linux
    libarchive
         library that can create and read several streaming archive formats
    bzip2
         A high-quality data compression program
    xz
         Library and command line tools for XZ and LZMA compressed files
    expat
         An XML parser library
    findutils
         GNU utilities to locate files
    grep
         A string search utility
    pcre
         A library that implements Perl 5-style regular expressions
    filesystem
         Base filesystem
    iana-etc
         /etc/protocols and /etc/services provided by IANA
    file
         File type identification utility
    gzip
         GNU compression utility
    systemd-tools
         standalone tools from systemd
    glib2
         Common C routines used by GTK+ and other libs
    libffi
         A portable, high level programming interface to various calling conventions
    libsystemd
         systemd client libraries
    hwids
         hardware identification databases
    kbd
         Keytable files and keyboard utilities
    iputils
         IP Configuration Utilities (and Ping)
    sysfsutils
         System Utilities Based on Sysfs
    sysvinit
         Linux System V Init
    initscripts
         System initialization/bootup scripts
    iproute2
         IP Routing Utilities


软件包配置文件
---------------------

::

    openssl --- /etc/ssl/misc/CA.pl
    openssl --- /etc/ssl/misc/CA.sh
    openssl --- /etc/ssl/misc/c_hash
    openssl --- /etc/ssl/misc/c_info
    openssl --- /etc/ssl/misc/c_issuer
    openssl --- /etc/ssl/misc/c_name
    openssl --- /etc/ssl/misc/tsget
    openssl --- /etc/ssl/openssl.cnf
    perl --- /etc/profile.d/perlbin.csh
    perl --- /etc/profile.d/perlbin.sh
    glibc --- /etc/gai.conf
    glibc --- /etc/locale.gen
    glibc --- /etc/nscd.conf
    glibc --- /etc/rc.d/nscd
    glibc --- /etc/rpc
    bash --- /etc/bash.bash_logout
    bash --- /etc/bash.bashrc
    bash --- /etc/skel/.bash_logout
    bash --- /etc/skel/.bash_profile
    bash --- /etc/skel/.bashrc
    readline --- /etc/inputrc
    coreutils --- /etc/pam.d/su
    pam --- /etc/default/passwd
    pam --- /etc/environment
    pam --- /etc/security/access.conf
    pam --- /etc/security/group.conf
    pam --- /etc/security/limits.conf
    pam --- /etc/security/namespace.conf
    pam --- /etc/security/namespace.init
    pam --- /etc/security/pam_env.conf
    pam --- /etc/security/time.conf
    libtirpc --- /etc/netconfig
    libgssglue --- /etc/gssapi_mech.conf
    pambase --- /etc/pam.d/other
    pambase --- /etc/pam.d/system-auth
    pambase --- /etc/pam.d/system-local-login
    pambase --- /etc/pam.d/system-login
    pambase --- /etc/pam.d/system-remote-login
    pambase --- /etc/pam.d/system-services
    linux --- /etc/mkinitcpio.d/linux.preset
    mkinitcpio --- /etc/mkinitcpio.conf
    mkinitcpio --- /etc/mkinitcpio.d/example.preset
    util-linux --- /etc/pam.d/chfn
    util-linux --- /etc/pam.d/chsh
    util-linux --- /etc/pam.d/login
    filesystem --- /etc/arch-release
    filesystem --- /etc/crypttab
    filesystem --- /etc/fstab
    filesystem --- /etc/group
    filesystem --- /etc/gshadow
    filesystem --- /etc/host.conf
    filesystem --- /etc/hosts
    filesystem --- /etc/issue
    filesystem --- /etc/ld.so.conf
    filesystem --- /etc/motd
    filesystem --- /etc/mtab
    filesystem --- /etc/nsswitch.conf
    filesystem --- /etc/os-release
    filesystem --- /etc/passwd
    filesystem --- /etc/profile
    filesystem --- /etc/resolv.conf
    filesystem --- /etc/securetty
    filesystem --- /etc/shadow
    filesystem --- /etc/shells
    iana-etc --- /etc/protocols
    iana-etc --- /etc/services
    systemd-tools --- /etc/udev/udev.conf
    glib2 --- /etc/profile.d/glib2.csh
    glib2 --- /etc/profile.d/glib2.sh
    iputils --- /etc/xinetd.d/tftp
    initscripts --- /etc/inittab
    initscripts --- /etc/logrotate.d/bootlog
    initscripts --- /etc/profile.d/locale.sh
    initscripts --- /etc/rc.conf
    initscripts --- /etc/rc.d/functions
    initscripts --- /etc/rc.d/hwclock
    initscripts --- /etc/rc.d/netfs
    initscripts --- /etc/rc.d/network
    initscripts --- /etc/rc.local
    initscripts --- /etc/rc.local.shutdown
    initscripts --- /etc/rc.multi
    initscripts --- /etc/rc.shutdown
    initscripts --- /etc/rc.single
    initscripts --- /etc/rc.sysinit
    iproute2 --- /etc/iproute2/ematch_map
    iproute2 --- /etc/iproute2/group
    iproute2 --- /etc/iproute2/rt_dsfield
    iproute2 --- /etc/iproute2/rt_protos
    iproute2 --- /etc/iproute2/rt_realms
    iproute2 --- /etc/iproute2/rt_scopes
    iproute2 --- /etc/iproute2/rt_tables

后续计划
==========

* linux瘦身

* 编译小号内核

