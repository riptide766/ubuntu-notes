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


>>> ln -b -s _backup source target

>>> ln -b -v t source target


chmod
-------

设置读写权限对文件的所有者，清空所有权限对file的用户组和其他用户
    
>>> chmod u=rw,go= file


对目录docs和其子目录层次结构中的所有文件增加所有用户的读权限，而对用户组和其他用户删除读权限

chmod -R u+r,go-r docs

