=============
临时记录
=============

统计求平均

>>> awk'{a[$1]+=$2; b[$1]+=1} END {for (i in a ) a[i]/b[i]}' 

6=>6;6

>>> echo 'Port=6,Port=2,Port=1' | sed 's/[0-9]/&;&/g'

列出d1和d2相同的文件

>>> ls -1 d1 d2 | awk '{ab[$0]++} END{for (i in ab){if(ab[i]>1)print i;}}'

显示不打印字符 v 显示行结束E 显示Tab T

>>> cat -A file

转换window文件

>>> dos2unix file

两行合并 N命令读取下一行,和当前行看成"一行"

>>> echo -e "1\n2\n3" | sed  'N;s/\n//'

n命令会读取下一行,sed命令只会对n命令读取的行进行处理

>>> echo -e "1a\n2a\n3a\n4a" | sed  'n;s/a/111/g'

压缩重复的字符

>>> echo 122221111111111 | tr -s '12'

找到含有NF的B那行, 将下面条空行删除

>>> sed '/NFB/ {n;/^$/d}' test

非整数运算

>>> echo "1.20*2.40" | bc


替代手动输入

.. code-block:: bash


    echo "please choose a oracle sid: 1):apparc 2):b2bapp2 default:apparc"
      read ans
      case $ans in
    1)
    ORACLE_SID=apparc; echo $ORACLE_SID;;
    2)
    ORACLE_SID=b2bapp2; echo $ORACLE_SID;;
    \*)
    ORACLE_SID=apparc; echo $ORACLE_SID;;
    esac

>>> source script <<< ""
>>> source script <<< "2"

sed 分组和匹配例子

>>> echo 'Port=6;Port=2;Port=1' | sed 's/\(Port=\)\(.\);/\1\2;\2,/g'

打印够个挂载点的使用率,'-n' 选项，该选项告诉 sed 除非明确要求打印模式空间，否则不这样做。

>>> df -k | sed -n '/^\/dev\/sda8/p' | awk '{print $5}' | sed 's/.$//'

c\修改 a\追加 i\插入

>>> echo "a" | sed '1a\b'
>>> echo "a" | sed '1i\b'
>>> echo "a" | sed '1c\b'

监视指定的进程.  -d的作用是用逗号分割pgreg的结果

>>> top -p $(pgrep -d , gvfs)

# 找出含关键字最多的那一行. -F是指定分割行的分割符; NF指出当前行的字段数 

>>> echo -e 'aaabbccc\nabababab\nabcabc' | awk -Fab '{if(NF-1>a) {a=NF-1;b=$0 }}END{print a; print b}'

awk设置变量

>>> echo -e 'xxxx\nxxxxxx' | awk -v a=$aaa '{print a}'

第二个a起都变成b.  

>>> echo "a=aaaa" | sed 's/a/b/2g'

监视cpu使用率最高的4个软件. --sort -pcpu 按cpu使用率排序

>>> watch "ps -eo pcpu,user,pid,cmd --sort -pcpu | head -5"

%指定数字位数, g表示用空格填充

>>> seq -f "str%03g" 9 11

输出等宽

>>> seq -w 1 29

指定分割符

>>> seq -s, -f"str%03g" 9 11

创建目录是指定权限

>>> mkdir -m 777 /tmp/123

列出不同gvim实例的环境变量. -C 根据名字选择. e 列出环境变量

>>> ps -C gvim e

列出pts/2上的进程

>>> ps  -t 'pts/2' -o comm,tty

每隔10秒高亮目录变化

>>> watch -d -n 10 ls /tmp

刷新xbindkeys

>>> killall -HUP xbindkeys

awk计算

>>> a=0.1
>>> echo '' |  awk -v a=$a '{print int(a+0.999)}'

查看当月日历

>>> cal $(date +%m\ %Y)
