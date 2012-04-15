准备工作 - 工具和目录
=========================

构建linux的准备工作。主要目的是准备好磁盘设备，然后告诉我们编译一个linux系统，需要哪些工具。

目录
--------

从零开始其实是从光盘开始。光盘指的是一个 :term:`Live CD`

从光盘启动后分区，挂上swap，挂上未来的根目录。 **(省略很多细节的命令)**


>>> cfdisk /dev/hda
>>> mkswap /dev/hda1
>>> mkfs.xfs /dev/hda2
>>> swapon /dev/hda1
>>> mount /dev/hda2 /mnt/lfs


sources目录是编译软件的地方，这些软件会被安装到tools目录。

而$LFS就是将来的根目录所在

>>> mkdir -v /mnt/lfs/sources
>>> mkdir -v /mnt/lfs/tools



工具链
-------------

工具链，编译源代码，需要四样东西。汇编器、连接器、编译器、库。

构建工具链
^^^^^^^^^^^^

* :term:`Binutils`
* :term:`GCC`
* :term:`Glibc`
* Linux-header


构建测试套件
^^^^^^^^^^^^^^

* Tcl
* Expect
* DejaGnu


实用工具
-------------


    gawk, sed, grep, bzip2, gzip, diffutils, finduitls,  coreutils, make, patch, tar, gettext,  ncurses, texinfo, bash, util-linux

**部分工具说明**

:term:`Coreutils` 一些基础工具

 ::
 
    basename, cat, chgrp, chmod, chown, chroot, cksum, comm, cp, csplit, cut, date, dd, df, dir, dircolors, dirname, du, echo, env, exp和, expr, factor, false, fmt, fold, groups, head, hostid, hostname, id, install, join, kill, link, ln, logname, ls, md5sum, mkdir, mkfifo, mknod, mv, nice, nl, nohup, od, paste, pathchk, pinky, pr, printenv, printf, ptx, pwd, readlink, rm, rmdir, seq, sha1sum, shred, sleep, sort, split, stat, stty, su, sum, sync, tac, tail, tee, test, touch, tr, true, tsort, tty, uname, unexp和, uniq, unlink, uptime, users, vdir, wc, who, whoami 和 yes


:term:`Diffutils` 
    
 ::

    cmp, diff, diff3 和 sdiff

:term:`Findutils`

 ::

    bigram, code, find, frcode, locate, updatedb 和 xargs


:term:`Gettext`  本地化工具

 ::

    autopoint, config.charset, config.rpath, gettext, gettextize, hostname, msgattrib, msgcat, msgcmp, msgcomm, msgconv, msgen, msgexec, msgfilter, msgfmt, msggrep, msginit, msgmerge, msgunfmt, msguniq, ngettext, project-id, team-address, trigger, urlget, user-email 和 xgettext

:term:`Ncurses` 文字界面接口

 ::

    captoinfo , clear, infocmp, infotocap, reset, tack, tic, toe, tput 和 tset


:term:`Texinfo` 文档工具

 ::

    info, infokey, install-info, makeinfo, texi2dvi 和 texindex

Bash

 ::

    bash, sh, bashbug

:term:`Util-linux` 系统管理、维护工具

 ::
 
    agetty, arch, blockdev, cal, cfdisk, chkdupexe, col, colcrt, colrm, column, ctrlaltdel, cytune, ddate, dmesg, elvtune, fdformat, fdisk, fsck.cramfs, fsck.minix, getopt, hexdump, hwclock, ipcrm, ipcs, isosize, kill, line, logger, look, losetup, mcookie, mkfs, mkfs.bfs, mkfs.cramfs, mkfs.minix, mkswap, more, mount, namei, parse.bash, parse.tcsh, pg, pivot_root, ramsize (link to rdev), raw, rdev, readprofile, rename, renice, rev, rootflags (link to rdev), script, setfdprm, setsid, setterm, sfdisk, swapoff (link to swapon), swapon, test.bash, test.tcsh, tunelp, ul, umount, vidmode (link to rdev), whereis 和 write


