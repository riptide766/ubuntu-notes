===================================
#!/usr/bin/env bash 和 #!/bin/bash
===================================

脚本第一行中使用 **#!/usr/bin/env bash** 和 **#!/bin/bash** 有什么区别？


bash和coreutils
=================

那首先了解下env和bash的区别。

>>> pacman -Qo bash       
/bin/bash is owned by bash 4.2.037-1

>>> pacman -Qo env       
/usr/bin/env is owned by coreutils 8.17-3

从上面可以看出它们分别属于不同的两个软件包。也就意味着他们可能不是同时存在于系统中。

.. code-block:: bash

    for cmd in `pacf coreutils |grep bin | grep -e "[^/]$"| cut -d" " -f2 ` ; do
    echo ${cmd##*\/}
    done | tr "\n" " "


执行上面的脚本可以更清晰的了解到:原来一些常用的命令都是属于coreutils的。对linux来说，这就是必备的。


::

    cat chgrp chmod chown cp date dd df echo false ln ls mkdir mknod mv pwd rm rmdir stty su sync true uname [ base64 basename chcon cksum comm csplit cut dir dircolors dirname du env expand expr factor fmt fold head hostid id install join link logname md5sum mkfifo mktemp nice nl nohup nproc od paste pathchk pinky pr printenv printf ptx readlink realpath runcon seq sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sleep sort split stat stdbuf sum tac tail tee test timeout touch tr truncate tsort tty unexpand uniq unlink users vdir wc who whoami yes chroot

说回bash，虽然使用很普遍，但作为shell的一种，却不是必备的。发行版本不一定预装bash。


区别
======

如果系统没有装bash，那么两种写法都是一个效果。

两者想比之下 **#!/usr/bin/env bash** 兼容性更好一点，因为它会从路径里区找bash，而不是一个固定位置。 


