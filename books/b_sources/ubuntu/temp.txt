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
