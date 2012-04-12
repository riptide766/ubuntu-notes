*******************
名词解释
*******************

.. sphinx markup

.. glossary::

    RPM 
        Redhat Package Manager


    Comma Separated Value (CSV)
        逗号分割型数值

    LTS
        Long-Term Support

    Loop device
        In Unix-like operating systems, a loop device, vnd (vnode disk), or lofi (loopback file interface) is a pseudo-device that makes a file accessible as a block device. `wiki Loop device <http://en.wikipedia.org/wiki/Loop_device>`_

    Free Software
        自由软件 自由软件是指允许任何人使用、拷贝、修改、分发（免费/少许收费）的软件。尤其是这种软件的源代码必须是可得到的。从某种意义上说，“没有源代码，就称不上是（自由）软件。” 详见  `自由软件及非自由软件的种类 <http://www.aka.org.cn/Magazine/Gnu/categories.html#TOCFreeSoftware>`_

    AT&T
        美国电话电报公司, 创始人是发明电话的贝尔。

    PPA
        Personal Package Archives (PPA) allow you to upload Ubuntu source packages to be built and published as an apt repository by  `Launchpad <https://launchpad.net/>`_ .

    ACPI
        Advanced Configuration and Power Interfacee

    SSH
        Secure Shell (SSH) is a network protocol for secure data communication, remote shell services or command execution and other secure network services between two networked computers that it connects via a secure channel over an insecure network: a server and a client (running SSH server and SSH client programs, respectively).[1] The protocol specification distinguishes two major versions that are referred to as SSH-1 and SSH-2. `WIKI - Secure Shell <http://en.wikipedia.org/wiki/Secure_Shell>`_

    VPS
        Virtual private server (VPS) is a term used by Internet hosting services to refer to a virtual machine `WIKI - Virtual private server <http://en.wikipedia.org/wiki/Virtual_private_server>`_

    GTK+
        GTK+（GIMP Toolkit)是一套跨多种平台的图形工具包,按LGPL许可协议发布的。虽然最初是为GIMP写的，但目前已发展为一个功能强大、设计灵活的一个通用图形库。特别是被GNOME选中使得GTK+广为流传，成为Linux下开发图形界面的应用程序的主流开发工具之一，当然GTK+并不要求必须在Linux上，事实上，目前GTK+已经有了成功的windows版本.

    XML
        eXtensible Markup Language

    UTC
        Coordinated Universal Time. unix认为1970年1月1日0点为纪元时间

    GMT
        十七世纪，格林威治皇家天文台为了海上霸权的扩张计画而进行天体观测。1675年旧皇家观测所(Old Royal Observatory) 正式成立，到了1884年决定以通过格林威治的子午线作为划分地球东西两半球的经度零度。观测所门口墙上有一个标志24小时的时钟，显示当下的时间，对全球而言，这里所设定的时间是世界时间参考点，全球都以格林威治的时间作为标准来设定时间，这就是我们耳熟能详的「格林威治标准时间( **Greenwich Mean Time** ，简称G.M.T.)的由来


    GRUB2
        GRUB 2 is the default boot loader and manager for Ubuntu since version 9.10 (Karmic Koala). As the computer starts, GRUB 2 either presents a menu and awaits user input or automatically transfers control to an operating system kernel. GRUB 2 is a descendant of GRUB (**GRand Unified Bootloader**). It has been completely rewritten to provide the user significantly increased flexibility and performance. GRUB 2 is Free Software. `Ubuntu Document - GRUB2 Guide <https://help.ubuntu.com/community/Grub2>`_

    DTD
        Document Type Definition (DTD) is a set of markup declarations that define a document type for SGML-family markup languages (SGML, XML, HTML). `DTD - Wiki <http://en.wikipedia.org/wiki/Document_Type_Definition>`_


    METADATA
        元数据（Metadata），又称元资料、中介资料，为描述数据的数据（data about data），主要是描述数据属性（property）的资讯，用来支持如指示储存位置、历史资料、资源寻找、文件纪录等功能。 `Metadata-Wiki <http://en.wikipedia.org/wiki/Metadata>`_

    memtest86+    
        memtest86+是基于由Chris Brady所写的著名的memtest86进行改写的一款内存检测工具。该软件的目标是要提供一个可靠的软件工具，进行内存故障检测。

    Hard link
        硬链接只能用于文件（而不是目录），实质上就是给同一个实体文件取多个名字。每个实体文件至少有一个硬链接，通常就是文件本身。所有指向同一实体文件的新名字（硬链接）与原目标文件必须位于同一个分区。实际上，辨别多个文件为硬链接的一种做法是，查看这些文件的inode号是否相同。更改指向文件的任意硬链接的权限、所有权、日期/时戳或内容，最终也会更改其他硬链接或原文件。不过，删除其中一个链接并不会删除所指文件，该文件仍会存在，直至指向文件的最后一个链接删除。


    Symbolic link
        符号链接是一个指针，指向文件在文件系统中的位置。符号链接可以跨文件系统，甚至可以指向远程文件系统中的文件。符号链接只是指明了原始文件的位置，用户需要对原始文件的位置有访问权限才可以使用链接。如果原始文件被删除，所有指向它的符号链接也就都被破坏了。它们会指向文件系统中并不存在的一个位置。

    BOM
        Byte Order Mark

    Linux From Scratch (LFS)
        Linux From Scratch (LFS) is a project that provides you with step-by-step instructions for building your own customized Linux system entirely from source. `linuxfromscratch.org <http://www.linuxfromscratch.org/lfs/>`_

    Internal field separator (IFS)
        In Unix operating systems, internal field separator (abbreviated IFS) refers to the character or characters designated as whitespace by the operating system. IFS is actually a system variable, and it can be modified, which is useful programmatically in a number of ways.

    Fork Bomb
        >>> forkbomb(){ forkbomb|forkbomb & } ; forkbomb
        >>> :(){ :|:& };:

    Back-quote
        反引用，可用于存储命令输出
        
        >>> output=`command`
    
    Live CD
        Live CD，又译为自生系统，是事先儲存於某种可移动儲存裝置上，可不特定於计算机硬件（non-hardware-specific）而启动的操作系统（通常亦包括一些其他軟件），不需安裝至计算机的本地外部存储器 - 硬盘。采用的介质包括CD-ROM（Live CD），DVD（Live DVD），闪存盘（Live USB）甚至是软盘等。退出自生系统並重新開機後，電腦就可以恢復到原本的操作系統。自生系统的運作機制，是透過「把原本放在硬碟裡的檔案，放到記憶體的虛擬磁碟中」來運作；因此系統記憶體愈大，則執行速度愈快。 `Live CD - wiki <http://zh.wikipedia.org/zh/Live_CD>`_
