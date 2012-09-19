******************************
Zsh笔记
******************************

提示vim的session文件
============================


* compctl -K

  Call the given function to get the completions.

* reply

  一个数组,放自动完成的选项

.. code-block:: bash

    function gvims(){
        gvim -S "$MTMKRES/visession/$1"
    }

    function _compctl_gs () {
        reply=(`ls -1 $MTMKRES/visession/\*vim \|cut -d"/" -f 6 | tr "\n" " " `)
    }

    compctl -K _compctl_gs gvims


命令执行后提醒
=========================

* alias -g 是全局替换别名
* precmd 是hook函数，在每个prompt前被调用

.. code-block:: bash

    alias -g W="WATCH_FOR_CMD=watch;"

    function precmd(){
        local rslt=$?
        [ "$WATCH_FOR_CMD" ] || return
        local cmd="`history | tail -n1 | cut -d" " -f 2-`"
        notify-send $cmd $rslt
        WATCH_FOR_CMD=
    }


* bindkey 绑定快捷键
* zle -N 创建或覆盖一个widget
* zle up-history 相当于ctrl+p，上条历史
* $BUFFER 编辑器缓存区

.. code-block:: bash

    W-command-line() {
        [[ -z $BUFFER ]] && zle up-history
        [[ $BUFFER != W\ * ]] && BUFFER="W $BUFFER"
        zle end-of-line
    }
    zle -N W-command-line
    bindkey "\ew" W-command-line

命令前添加sudo
========================

.. code-block:: bash

    sudo-command-line() {
        [[ -z $BUFFER ]] && zle up-history
        [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
        zle end-of-line
    }
    zle -N sudo-command-line
    bindkey "\e\e" sudo-command-line

oh-my-zsh自定义主题
===========================

* PROMPT是左边的提示,RPS1是右边的提示.

* %(?.str1.str2) 三元表达式的写法. 详见: man zshmisc

* %{$fg[red]%} 定义颜色

* %{$reset_color%%} 重置颜色

.. code-block:: bash

    local return_status="%{$fg_bold[red]%}%(?..:( )%{$reset_color%}"

    PROMPT='%{$fg[green]%} %% '
    RPS1='${return_status}%{$fg[white]%}%2~$(git_prompt_info) %{$fg_bold[blue]%}%m%{$reset_color%}'

>>> man zshmisc

==========  =================
转义序列      打印效果
==========  =================
%T          系统时间（时：分）
%*          系统时间（时：分：秒）
%D          系统日期（年-月-日）
%n          你的用户名
%B          开始到结束使用粗体打印
%U          开始到结束使用下划线打印
%d          你目前的工作目录
%~          你目前的工作目录相对于～的相对路径
%M          计算机的主机名
%m          计算机的主机名（在第一个句号之前截断）
%l          你当前的tty
==========  =================


