版本控制 GIT学习笔记
=====================

配置参数
-----------
    
    设置    

    ::
    
        git config --global user.name "mattmonkey"
        git config --global user.email "mattmonkey@sina.com"


    列出
    
    ::

        git config --list
        git config --global --list
        git config --local --list

    颜色

    ::

        git config --global color.branch auto
        git config --global color.diff auto
        git config --global color.interactive auto
        git config --global color.status auto
        git config --global color.ui auto

    别名

    ::

        git config --global alias.st status
        git config --global alias.ci commit
        git config --global alias.co checkout
        git config --global alias.br branch

    其他

    ::

        git config format.pretty oneline



辅助工具
---------

:qgit: 查看历史
:gitk: git默认的gui管理工具
:lighttpd: web server
:git instaweb: web based 管理工具


.. index::
   single: ssh ; ssh-keygen


生成SSH Key
-----------

    生成SSH Key

    ::

        cd ~/.ssh
        ssh-keygen -t rsa -C "xxxxxx@xxx.com"

    添加Key到 `github ssh <https://github.com/settings/ssh>`_

    ::

        cat id_rsa.pub | xsel -b
    
    测试有效性

    ::

        ssh -T git@github.com
        

配置多个SSH
-------------

1. 生成SSH Key

   ** 主要不要和默认的ssh文件重复了**

2. key 加入到ssh-agent
   ssh-add ~/.ssh/id2_rsa

3. 配置~/.ssh/config, t
   
 ::

    # Default git
    Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa

    # riptide git (riptide766@mail.com)
    Host github-riptide.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id2_rsa

4. 配置git仓库

   >>> git remote -v
   origin	git@github.com:riptide766/ubuntu-notes.git (fetch)
   origin	git@github.com:riptide766/ubuntu-notes.git (push)
   >>> git remote origin
   >>> git remote add origin git@github-riptide:riptide766/ubuntu-notes.git


git重置提交者 
-------------
    
    ::
        
        git commit --amend --reset-author


gh-pages分支
-------------

* 库已经存在，切换到gh-pages分支

  ::

    git clone git@github.com:mattmonkey/CtrlCtrl ctrlctrl
    git checkout gh-pages


* 新建gh-pages分支


文件周期变化
------------

.. image:: ./pics/git-files-status.png



查看和比较
--------------------

* 查看文件
    
    ::

        git show  HEAD:chrome/content/ctrlctrl.js 


* 比较某个版本

    列出简要差别
    
    >>> git diff HEAD --stat
    >>> git diff HEAD~2 --stat


* 比较修改的部分

    **当前文件** 和 **上个版本** 之间的差异
    
    >>> git diff HEAD -- test


    **当前文件** 和 **暂存区域快照** 之间的差异
    
    >>> git diff


    **已经暂存** 起来的文件和 **上次提交** 时的快照之间的差异.
    
    >>> git diff --staged



打补丁
--------

    diff的结果就是补丁。 使用apply命令打补丁

    >>> git diff > /tmp/patch
    >>> git apply  /tmp/patch

恢复文件
---------

    解除文件staged状态

    >>> git reset HEAD file

    恢复文件

    >>> git checkout -- python/indicator-demo.py
    >>> git checkout HEAD~2 -- python/indicator-demo.py


恢复版本
----------

    恢复之前的版本. 不包括Untracked files ，因为Untracked...

    >>> git reset --hard 



    恢复到之前的某个版本个，并 **删除之间的记录**

    >>> git reset --hard er23



    另一种恢复版本的方法是 **git revert** . 不会删除提交记录。还会把恢复的版本作为一次提交。 **:/first** 用注释查找提交 

    >>> git revert :/first



    git checkout 可以切换的版本 ，但如果有冲突会报错提醒
    
    >>> git checkout c2ca
    error: The following untracked working tree files would be overwritten by checkout:
	    test 
    Please move or remove them before you can switch branches.


    在旧版本里执行 **git log** 是查不到新版本的hash值的．
    使用下面的命令回到最新版本

    >>> git checkout master



