====================
脚本片段记录
====================


这段话的作用是把多行的$comps变成一个一维数组

.. code-block:: bash

    while read i
    do
        COMPREPLY=("${COMPREPLY[@]}" "${i}")
    done <<EOF
    $comps


