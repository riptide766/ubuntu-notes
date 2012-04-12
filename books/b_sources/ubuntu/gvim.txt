文本编辑 GVIM 使用总结
==========================

插入当前时间
--------------

输入xdate, 替换成当前日期  

::

    iab xdate <c-r>=strftime("20%y%m%d %H:%M:")<C-I> 


用不同的标签打开多个文件
--------------------------

>>> gvim -p *


删除、复制单词
----------------

* [cdy]iw 
* [cdy]aw 

**i** 内含单词
**a** 一个单词(含空格之类的


删除、复制标点配对内容
-----------------------

ci'、ci"、ci(、ci[、ci{、ci< 

di'、di"、di(、di[、di{、di< 

yi'、yi"、yi(、yi[、yi{、yi< 

**i** 换成 **a** 连同标点一起操作

中文帮助
--------------


    下载 `中文帮助 <http://vimcdoc.sourceforge.net/>`_
    
    ::

        tar zxvf vimcdoc-1.8.0.tar.gz
        cd vimcdoc-1.8.0
        ./vimcdoc.sh -i

    
    使用英文帮助

        ::

            :h help@en


javascript / ctag / taglist
-----------------------------

    安装ctags

        ::
        
            sudo apt-get install exuberant-ctags


    下载安装 `taglist <http://www.vim.org/scripts/script.php?script_id=273>`_

    添加配置文件 ~/.ctags

        ::

            --regex-JavaScript=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*new[ \t]+Object\(/\1/o,object/
            --regex-JavaScript=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*\{/\1/o,object/
            --regex-JavaScript=/([A-Za-z0-9._$()]+)[ \t]*[:=][ \t]*function[ \t]*\(/\1/f,function/
            --regex-JavaScript=/function[ \t]+([A-Za-z0-9._$]+)[ \t]*\([^\]\)]*\)/\1/f,function/
            --regex-JavaScript=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*new[ \t]+Array\(/\1/a,array/
            --regex-JavaScript=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*\[/\1/a,array/
            --regex-JavaScript=/([^= ]+)[ \t]*=[ \t]*[^""]'[^'']*/\1/s,string/
            --regex-JavaScript=/([^= ]+)[ \t]*=[ \t]*[^'']"[^""]*/\1/s,string/


    修改配置 ～/.vimrc

        ::

            nnoremap <silent> <F9> :TlistToggle<CR>
            let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'



