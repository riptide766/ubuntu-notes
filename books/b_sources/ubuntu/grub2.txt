*******************
grub2
*******************

查询安装位置
------------

- device
    sudo grub-probe -t device /boot/grub


- uuid
    sudo grub-probe -t fs_uuid /boot/grub


主要配置文件
------------

:/boot/grub/grub.cfg: 最终文件
:/boot/grub/\*.mod: 模块文件
:/etc/default/grub: 内核追加配置
:/etc/grub.d /00_header:



