**************************
辅助命令
**************************

date
---------

**格式化时间用**

>>> date +%Y%m%d-%H:%M:%S
20120319-14:22:09

>>> touch backup_`date +%Y%m%d-%H:%M:%S`.txt

cut
-------------

**截取文字**

-c  select only these characters
-d  use DELIM instead of TAB for field delimiter
-f  select only these fields
-s  do not print lines not containing delimiters


>>> echo 1a2345a678 | cut  -c 1,3-6,8-
12345678

>>> echo -e "a\tbc" | cut -f 2
bc

>>> echo 1a2345a678 | cut -da  -f 2
2345


sort 
---------------

**结果排序**

-t SEP  使用SEP来替代空格的转换non-.
-n      按照字符串的数值顺序比较
-k      从关键字POS1开始,*到*POS2结束.字段数和字符偏移量都从1开始计数



按文件的数值大小的后两位排序（以空格区分，第六列的三到四位）

>>> ll -s | sort -t\  -nk 6.3,6.4
0 -rw------- 1 matt matt    0  3月 11 16:38 nohup.out
总用量 36
8 -rw-rw-r-- 1 matt matt 5115  2月 24 22:23 make.bat
4 -rw-rw-r-- 1 matt matt 3339  2月 24 22:15 setting.txt
8 -rw-rw-r-- 1 matt matt 5593  2月 24 22:23 Makefile
4 drwxrwxr-x 4 matt matt 4096  2月 25 07:40 build/
4 drwxrwxr-x 4 matt matt 4096  3月 11 16:38 ./
4 drwxrwxr-x 4 matt matt 4096  3月  5 18:19 source/
4 drwxrwxr-x 5 matt matt 4096  3月  6 21:59 ../


按文件的数值大小的后两位排序（第六列的三到四位）
    
    **不指定区分，列似乎包含了空格**
    
>>> ll -s | sort  -nk 6.4,6.5
0 -rw------- 1 matt matt    0  3月 11 16:38 nohup.out
总用量 36
8 -rw-rw-r-- 1 matt matt 5115  2月 24 22:23 make.bat
4 -rw-rw-r-- 1 matt matt 3339  2月 24 22:15 setting.txt
8 -rw-rw-r-- 1 matt matt 5593  2月 24 22:23 Makefile
4 drwxrwxr-x 4 matt matt 4096  2月 25 07:40 build/
4 drwxrwxr-x 4 matt matt 4096  3月 11 16:38 ./
4 drwxrwxr-x 4 matt matt 4096  3月  5 18:19 source/
4 drwxrwxr-x 5 matt matt 4096  3月  6 21:59 ../

