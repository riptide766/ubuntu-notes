*********************
常用目录和文件
*********************

1111
--------

:/etc/passwd:       账户管理
:/etc/shadow:       账户管理
:/var/log/lastlog:  最后登录信息

:/bin/bash: 默认shell
:/etc/group: 用户组
:/etc/profile: 环境设置
:/etc/bash.bashrc: 环境设置
:/etc/skel: 骨架目录，添加用户时会用到。
:/etc/bash_completion: shell自动完成脚本
:/dev/pts: 伪终端目录  echo test > /dev/pts/1
:/etc/init.d: 存放各个运行等级要用的脚本 
:/var/backups: 看到有些定时脚本会存东西到这里
:/var/lib/apt/lists: apt索引目录 
:/var/cache/apt/archives:   apt缓存目录
:/etc/apt/sources.list:     软件源
:/etc/apt/apt.conf.d: apt配置
:/etc/lightdm/unity-greeter.conf: lightdm配置文件

用户目录
--------------

:./.local/share/recently-used.xbel: 数据文件。最近打开的文件
