************************
系统和软件安装
************************

这篇主要记录Ubuntu系统的安装和引导的过程; 软件和数据的备份和还原
    

GRUB2 引导
-------------

GRUB2的调整就目录结构来说，主要三块地方:

* /etc/default/grub 配置grub参数
* /boot/grub/
    * \*.mod  GRUB模块
    * grub.cfg 最终文件
* /etc/grub.d/* 具体生成GRUB菜单的脚本

设备安装GRUB
^^^^^^^^^^^^^^^^^

  一般情况，系统安装好的同时也就配置好。但之后如果再安装了其他linux就需要这个方法了。

  >>> sudo grub-install /dev/sda

U盘作启动盘
^^^^^^^^^^^^

  以防万一，还可以复制一份grub.cfg 

  >>> sudo grub-install --root-directory=/media/6859-59EB/ /dev/sdb

指定GRUB菜单分辨率
^^^^^^^^^^^^^^^^^^^

 修改 /etc/default/grub

 ::

    GRUB_GFXMODE=640x480


追加内核参数
^^^^^^^^^^^^^

  修改 **/etc/default/grub**  

  ::
     
    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=off "
 
禁止检测其他系统的启动项
^^^^^^^^^^^^^^^^^^^^^^^^^^

  一般情况用不上，除非想精细化控制

  >>> sudo chmod -x /etc/grub.d/30_os-prober

  或者向 **/etc/default/grub** 中添加 
  
  ::
   
   GRUB_DISABLE_OS_PROBER=true



安装和升级系统
---------------

设置软件源
^^^^^^^^^^^

    >>> software-properties-gtk


系统维护升级
^^^^^^^^^^^^^

* 界面
 
    >>> update-manager

* 命令

    >>> sudo aptitude upgrade

    
系统版本升级
^^^^^^^^^^^^^^

* 在线升级版本

    >>> update-manger -d

* 光盘挂载ISO升级 （alternate）
        
    >>> sudo mount -t iso9660 -o loop /home/xxxx/ubuntu-12.04.beta1-alternate-i386.iso /media/cdrom
    >>> sudo apt-cdrom -d /cdrom -m -o=Dir::Media::MountPath=/cdrom add
    >>> sudo aptitude update
    >>> sudo aptitude dist-upgrade

* GRUB2挂载ISO升级

  :term:`GRUB2` 的系统选择菜单按 **c** 进入命令行

  **Tab** 键像一般shell一样有自动完成功能

  >>> set root=(hd0,5)
  >>> loopback loop (hd0,5)/precise-desktop-i386.iso
  >>> linux (loop)/casper/vmlinz boot=casper iso-scan/filename=/precise-desktop-i386.iso acpi=off quiet splash
  >>> initrd (loop)/casper/initrd.lz
  >>> boot

问题解决
^^^^^^^^^^

:ref:`sources-locked`

:ref:`grub-acpi`



备份软件包
^^^^^^^^^^^

* 备份

    >>> tar uPvf ~/backup-`lsb_release -r | cut -f 2`.tar /var/cache/apt/archives --exclude=/var/cache/apt/archivesa/partial/* --exclude=/var/cache/apt/archives/lock



* 清理（旧包）

    >>> sudo aptitude autoclean

* 清理（全部）

    >>> sudo aptitude clean

* 还原

    >>> sudo tar xPvf backup.tar


PPA备份
^^^^^^^^

.. code-block:: bash


    #! /bin/bash

    # classicmenu
    sudo apt-add-repository ppa:diesch/testing

    # simple LightDM Manager
    sudo apt-add-repository ppa:claudiocn/slm

    # pastie 
    sudo add-apt-repository ppa:hel-sheep/pastie

    # rabbitvcs
    sudo add-apt-repository ppa:rabbitvcs/ppa

    # sopcast
    sudo add-apt-repository ppa:ferramroberto/sopcast

    # Unity Plugin Rotated
    sudo add-apt-repository ppa:paullo612/unityshell-rotated

    # Nautilus Terminal
    sudo add-apt-repository ppa:flozz/flozz

    # Nvidia
    sudo add-apt-repository ppa:ubuntu-x-swat/x-updates 

    # update
    sudo aptitude update


软件安装
------------

安装常用软件
^^^^^^^^^^^^^^

::

 nvidia-current mc gparted tree freemind smplayer p7zip-full vim-gnome exuberant-ctags  unrar freepats wallch fcitx zim compizconfig-settings-manager chmsee shutter amule ubuntu-restricted-extras classicmenu-indicator indicator-weather pysdm ntfs-config pastie sopcast-player wine simple-lightdm-manager  unityshell-rotated virtualbox nautilus-terminal nautilus-open-terminal gconf-editor  ubuntu-restricted-extras  gnome-tweak-tool terminator clipit unetbootin deluge dconf-tools myunity



安装开发用软件
^^^^^^^^^^^^^^^^^

::

 python-docutils git debian-reference python-doc lighttpd qgit gitk python-sphinx rabbitvcs-core rabbitvcs-nautilus3 rabbitvcs-cli dpkg-dev debhelper dh-make python-setuptools python-distutilus-extra build-essential anjuta python-feedparser xbindkeys wmctrl

 


安装其他软件
^^^^^^^^^^^^^^^


* `ubuntu-tweak <https://launchpad.net/ubuntu-tweak/+download>`_

* `indicator-places <https://github.com/shamil/indicator-places>`_

* `pomodairo <http://code.google.com/p/pomodairo/>`_

* `feedindicator <http://feedindicator.googlecode.com/files/feedindicator_1.03-1_all.deb>`_

* `Adobe Air 2.6 <http://kb2.adobe.com/cps/853/cpsid_85304.html>`_

    >>> wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin        
    >>> ./AdobeAIRInstaller.bin


* `flashplugin <http://get.adobe.com/cn/flashplayer/completion/?installer=Flash_Player_11_for_other_Linux_(.tar.gz)_32-bit>`_
   
 ::

  复制到 /usr/lib/firefox-addons/plugins/

 
* autojump

 ::

  git clone git://github.com/joelthelion/autojump.git autojump


* nodejs / coffeescript

 ::

    sudo aptitude install nodejs
    curl http://npmjs.org/install.sh | sudo sh
    sudo npm install -g coffee-script




系统和软件配置
^^^^^^^^^^^^^^^

* unity-2d

 自动隐藏
 >>> dconf write /com/canonical/unity-2d/launcher/hide-mode 1

* 鼠标主题
  
  ::

    解压到 /usr/share/icons目录下


.. index::
    single:Terminal;nautilus termianl

* Nautilus Terminal 
  
  :配置文件: ~/.nautilus-terminal    
  
  ::
    
    [general]
    #调整终端高度
    def_term_height=8
    #在新的窗口终端默认可见？ （1：可见，0：隐藏）
    def_visible=0
    #终端位置 (1: 顶部, 0: 底部)
    #注意：不建议设置在底部
    term_on_top=1

    [terminal]
    #使用shell（Nautilus Terminal默认使用用户定义的shell）
    shell=/bin/bas
        
* Sopcast

  频道

  ::

    sop://broker.sopcast.com:3912/6004  凤凰中文
    sop://broker.sopcast.com:3912/6005  凤凰资讯

    

  报错   **ImportError\: No module named vlc_1_0_x**

  编辑 /usr/share/sopcast-player/lib/VLCWidget.py，注释该模块 

  ::
    
    #import vlc_1_0_x


