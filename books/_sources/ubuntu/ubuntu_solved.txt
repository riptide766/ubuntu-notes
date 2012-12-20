********************
疑难解决
********************


.. _grub-acpi:

电源问题引起的死机
--------------------

1. 修改 /etc/default/grub 的 **GRUB_CMDLINE_LINUX_DEFAULT** 项。  添加 **acpi=off**
   
   ::

        GRUB_CMDLINE_LINUX_DEFAULT="acpi=off quiet splash"
     
2. 刷新grub

   ::

        update-grub

.. note::

    安装的时候防止死机可以在选择系统时进入编辑状态, 在kernel后面追加  **acpi=off**


.. _sources-locked:

无法更新源
-------------

>>> sudo aptitude update
E: 无法获得锁 /var/lib/apt/lists/lock - open (11: 资源暂时不可用)
E: 无法对目录 /var/lib/apt/lists/ 加锁
>>> sudo rm -rf /var/lib/apt/lists/*


删除软件异常
------------------------

1. 找到dpkg数据文件 
   
    ::
   
        gvim /var/lib/dpkg/status

    


#. 修改相关项目的 **Status** 字段。 [1]_

    ::
    
        Status: purge ok not-installed



.. index:: find , mp3
        
Mp3 标签乱码
-------------

    ::

        sudo apt-get install convmv iconv python-mutagen
        find . -iname "*.mp3" -execdir mid3iconv -e GBK {} \;



用户目录下的默认目录改成英文
--------------------------------

    ::

        export LANG=en_US 
        xdg-user-dirs-gtk-update 



xterm解决中文问题
------------------
1. 写配置文件

   ::
    
        ! English font
        xterm*faceName: DejaVu Sans Mono:antialias=True:pixelsize=14
        ! Chinese font
        xterm*faceNameDoublesize: WenQuanYi Micro Hei:pixelsize=14


#. 加载配置文件

    ::

        xrdb -load .Xdefaults


|

|


参考文章
--------

.. [1]    `软件包安装、删除出错的终极解决方法！ <http://forum.ubuntu.org.cn/viewtopic.php?f=77&t=213816>`_
