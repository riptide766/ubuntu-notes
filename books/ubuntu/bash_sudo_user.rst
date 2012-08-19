=========================
谁在用sudo命令
=========================


一个比较困扰的地方: 有sudo命令的存在，脚本判断当前用户有点麻烦。

在学习 **autojump** 的时候，看到一种解决的办法。使用环境变量： $SUDO_USER


.. code-block:: bash

    #!/bin/bash
    echo $UID
    echo $SUDO_USER
    echo $USER
    echo $HOME
    

在matt用户下使用sudo命令执行脚本

>>> sudo test.sh
0
matt
root
/root


大部分时候脚本还需要获取 **当前的用户的家目录** ，autojump里也提供了一种比较新鲜的办法

.. code-block:: bash
    
    user=${SUDO_USER:-${USER}}
    user_home=$(getent passwd ${user} | cut -d: -f6)


这个 **gentent** 命令可以通过关键词查询“数据库”

==========  =============================================================  
数据库       说明
==========  =============================================================  
aliases     邮件别名, sendmail(8) 使用该文件.
ethers      以太网号.
group       用户组, getgrent(3) 函数使用该文件.
hosts       主机名和主机号, gethostbyname(3) 以及类似的函数使用了该文件.
netgroup    网络内主机及其用户的列表, 访问规则使用该文件.
network     网络名及网络号, getnetent(3) 函数使用该文件.
passwd      用户口令, getpwent(3) 函数使用该文件.
protocols   网络协议, getprotoent(3) 函数使用该文件.
publickey   NIS+及NFS 所使用的secure_rpc的公开密匙.
rpc         远程过程调用名及调用号, getrpcbyname(3) 及类似函数使用该文件.
services    网络服务, getservent(3) 函数使用该文件.
shadow      shadow用户口令, getspnam(3) 函数使用该文件.
==========  =============================================================  






