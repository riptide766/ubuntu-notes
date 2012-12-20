===================
Bash常识
===================


.. _bash_startup_file:

Bash配置文件调用顺序
=====================


.. image:: ./pics/bash_flow.png


- These files are sourced by bash in different circumstances.

    - if interactive + login shell → /etc/profile then the first readable of ~/.bash_profile, ~/.bash_login, and ~/.profile
      
        Bash will source ~/.bash_logout upon exit. 
    
    - if interactive + non-login shell → /etc/bash.bashrc then ~/.bashrc
    
    - if login shell + legacy mode → /etc/profile then ~/.profile 

- But, in Arch, by default:

    - /etc/profile (indirectly) sources /etc/bash.bashrc
    
    - /etc/skel/.bash_profile which users are encouraged to copy to ~/.bash_profile, sources ~/.bashrc 

**which means that /etc/bash.bashrc and ~/.bashrc will be executed for all interactive shells, whether they are login shells or not.** 



LC_系列的环境变量
====================


=============   =========================================================================
变量名 	        说明
=============   =========================================================================
LANG 	        一次性定义全部locale设置，但是允许通过下面的LC_*设置进一步作单项定制。
LC_COLLATE 	    定义字符串的字母排序方式。例如这会影响目录列表的分类显示。
LC_CTYPE 	    定义系统的字符处理性能。这决定哪些字符能被视为字母、数字，等等。
LC_MESSAGES     使用基于消息机制的本地化方式的应用程序的本地化信息。
LC_MONETARY     定义货币单位和货币型数值的格式。
LC_NUMERIC 	    定义非货币型数值的格式。影响到千位分隔符和小数分隔符等。
LC_TIME 	    定义日期和时间的格式。
LC_PAPER 	    定义默认的纸张尺寸。
LC_ALL 	        一个用于覆盖所有其它设置的特殊变量。
=============   =========================================================================


