=========================
个人软件仓库
=========================


本地
===========


配置里添加仓库
---------------

编辑 **/etc/pacman.conf** 

::

    [custom]
    Server = file:///home/matt/custompkgs


创建本地仓库
--------------

>>> repo-add custom.db.tar.gz \*.pkg.tar.xz
==> Adding package 'firefox-14.0.1-1-i686.pkg.tar.xz'
  -> Computing checksums...
  -> Creating 'desc' db entry...
  -> Creating 'depends' db entry...
==> Creating updated database file custom.db.tar.gz



安装验证
----------

>>> pacman -S custom/firefox



删除软件 
--------

>>> repo-remove custom.db.tar.gz firefox 


