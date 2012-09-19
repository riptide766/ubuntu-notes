***********************************
Systemd
***********************************

systemctl
==========

* show
* list-units
* start
* stop
* restart
* condrestart
* status
* enable
* disable
* is-enabled
* isolate 类似改变运行级别
* default
* rescue
* halt
* poweroff
* reboot

Target
========

类似运行基本

* poweroff.target
* rescue.target
* multi-user.target
* graphical.target
* reboot.target

设置启动运行级别
====================

>>> ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target


重要目录
=============

* /lib/systemd/system/\*.service
* /etc/systemd/system/\*.service
* /etc/systemd/system/\*.wants/


