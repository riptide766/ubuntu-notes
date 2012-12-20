*********************
Bash 补全
*********************

Bash里可以通过 **Tab** 补全命令以及相关的参数。

这篇总结是如何实现下面这个例子的：

>>> foo
alpha   number  
>>> foo alpha 
a  b  c  
>>> foo number 
1  2  3  


代码
^^^^^^

.. code-block:: bash

    _foo() 
    {
        local cur prev opts
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        opts="number alpha"
     
        case "${prev}" in
            number)
            COMPREPLY=( 1 2 3)
                return 0
                ;;
            alpha)
            COMPREPLY=( a b c )
                return 0
                ;;
            \*)
            ;;
        esac

        COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
    }
    complete -F _foo foo


解释
^^^^^^^

1. 实现补全不一定需要一个真实的命令。是字符串就行。
   
   下面这个话的意思是：使用 **_foo函数** 处理对 **字符串foo** 的补全

 ::

    complete -F _foo foo

 
2. 具体实现补全的是内置的compgen命令。
   
   -W 处理指定字符串，也有其他参数是针对文件、目录、函数和别名等等
        
    >>> compgen -W “11 12 21 22” 1
    11
    12

3. COMPREPLY规定是一个数组。_foo通过它传递结果给背后的机制。

 ::
 
    COMPREPLY=( $(compgen -W "${opts}" ${cur}) )



4. COMP_WORDS和COMP_CWORD分别是目前命令行的所有单词和当前的索引。
   
   通过判断前个单词，可以实现不同选项对应不同参数的效果

 ::

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"


补充
^^^^^^^

-o 是设置一些补齐选项。 default和bashdefault的意思是如果没有补齐内容产生，就使用默认的其他补齐。

>>> complete -o default -o bashdefault -F _autojump_files cp mv meld diff kdiff3



参考文章
^^^^^^^^^^


    `An introduction to bash completion: part 2 <http://www.debian-administration.org/articles/317>`_

