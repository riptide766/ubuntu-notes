=====================
周边基础 - 汇编
=====================

汇编指示
=========

.section
----------

  指示把代码划分成若干个段（Section）,被操作系统加载执行时，每个段被加载到不同的地址


.section .date
---------------

  保存程序的数据,可读可写，相当于C程序的全局变量


.section .text
----------------

  保存代码,是只读和可执行的


汇编指令
=========

movl
----------

传送指令

cmpl
------------

比较指令

je
-------------

条件跳转指令(jump if equal).判断eflags寄存器的ZF位

incl
--------

自增指令

jle
--------

条件跳转指令(jump if less than or equal)

jmp
---------------

跳转指令

int
--------------

软中断指令


命令
==========


汇编器将助记符变成机器指令，生成目标文件.

>>> as hello.s -o hello.o

链接器将目标文件链接成可执行文件

>>> ld hello.o -o hello

读取ELF文件

>>> readelf -a hello.o
>>> readelf -a hello


汇编示例
===========

例一
----------------

::

    #PURPOSE: Simple program that exits and returns a
    #	  status code back to the Linux kernel
    #
    #INPUT:   none
    #
    #OUTPUT:  returns a status code. This can be viewed
    #	  by typing
    #
    #	  echo $?
    #
    #	  after running the program
    #
    #VARIABLES:
    #	  %eax holds the system call number
    #	  %ebx holds the return status
    #
     .section .data

     .section .text
     .globl _start
    _start:
     movl $1, %eax	# this is the linux kernel command
            # number (system call) for exiting
            # a program

     movl $4, %ebx	# this is the status number we will
            # return to the operating system.
            # Change this around and it will
            # return different things to
            # echo $?

     int $0x80	# this wakes up the kernel to run
                # the exit command




例二
----------------

::

    #PURPOSE: This program finds the maximum number of a
    #	  set of data items.
    #
    #VARIABLES: The registers have the following uses:
    #
    # %edi - Holds the index of the data item being examined
    # %ebx - Largest data item found
    # %eax - Current data item
    #
    # The following memory locations are used:
    #
    # data_items - contains the item data. A 0 is used
    # to terminate the data
    #
     .section .data
    data_items: 		#These are the data items
     .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

     .section .text
     .globl _start
    _start:
     movl $0, %edi  	# move 0 into the index register
     movl data_items(,%edi,4), %eax # load the first byte of data
     movl %eax, %ebx 	# since this is the first item, %eax is
                # the biggest

    start_loop: 		# start loop
     cmpl $0, %eax  	# check to see if we've hit the end
     je loop_exit
     incl %edi 		# load next value
     movl data_items(,%edi,4), %eax
     cmpl %ebx, %eax 	# compare values
     jle start_loop 	# jump to loop beginning if the new
                # one isn't bigger
     movl %eax, %ebx 	# move the value as the largest
     jmp start_loop 	# jump to loop beginning

    loop_exit:
     # %ebx is the status code for the _exit system call
     # and it already has the maximum number
     movl $1, %eax  	#1 is the _exit() syscall
     int $0x80


ELF文件
============

REL
-----------

::

    ELF Header:
      Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
      Class:                             ELF32
      Data:                              2's complement, little endian
      Version:                           1 (current)
      OS/ABI:                            UNIX - System V
      ABI Version:                       0
      Type:                              REL (Relocatable file)
      Machine:                           Intel 80386
      Version:                           0x1
      Entry point address:               0x0
      Start of program headers:          0 (bytes into file)
      Start of section headers:          200 (bytes into file)
      Flags:                             0x0
      Size of this header:               52 (bytes)
      Size of program headers:           0 (bytes)
      Number of program headers:         0
      Size of section headers:           40 (bytes)
      Number of section headers:         8
      Section header string table index: 5

    Section Headers:
      [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            00000000 000000 000000 00      0   0  0
      [ 1] .text             PROGBITS        00000000 000034 00002a 00  AX  0   0  4
      [ 2] .rel.text         REL             00000000 0002b0 000010 08      6   1  4
      [ 3] .data             PROGBITS        00000000 000060 000038 00  WA  0   0  4
      [ 4] .bss              NOBITS          00000000 000098 000000 00  WA  0   0  4
      [ 5] .shstrtab         STRTAB          00000000 000098 000030 00      0   0  1
      [ 6] .symtab           SYMTAB          00000000 000208 000080 10      7   7  4
      [ 7] .strtab           STRTAB          00000000 000288 000028 00      0   0  1
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings)
      I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
      O (extra OS processing required) o (OS specific), p (processor specific)

    There are no section groups in this file.

    There are no program headers in this file.

    Relocation section '.rel.text' at offset 0x2b0 contains 2 entries:
     Offset     Info    Type            Sym.Value  Sym. Name
    00000008  00000201 R_386_32          00000000   .data
    00000017  00000201 R_386_32          00000000   .data

    There are no unwind sections in this file.

    Symbol table '.symtab' contains 8 entries:
       Num:    Value  Size Type    Bind   Vis      Ndx Name
         0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
         1: 00000000     0 SECTION LOCAL  DEFAULT    1 
         2: 00000000     0 SECTION LOCAL  DEFAULT    3 
         3: 00000000     0 SECTION LOCAL  DEFAULT    4 
         4: 00000000     0 NOTYPE  LOCAL  DEFAULT    3 data_items
         5: 0000000e     0 NOTYPE  LOCAL  DEFAULT    1 start_loop
         6: 00000023     0 NOTYPE  LOCAL  DEFAULT    1 loop_exit
         7: 00000000     0 NOTYPE  GLOBAL DEFAULT    1 _start

    No version information found in this file.


EXEC
-----------

::

    ELF Header:
      Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
      Class:                             ELF32
      Data:                              2's complement, little endian
      Version:                           1 (current)
      OS/ABI:                            UNIX - System V
      ABI Version:                       0
      Type:                              EXEC (Executable file)
      Machine:                           Intel 80386
      Version:                           0x1
      Entry point address:               0x8048074
      Start of program headers:          52 (bytes into file)
      Start of section headers:          256 (bytes into file)
      Flags:                             0x0
      Size of this header:               52 (bytes)
      Size of program headers:           32 (bytes)
      Number of program headers:         2
      Size of section headers:           40 (bytes)
      Number of section headers:         6
      Section header string table index: 3

    Section Headers:
      [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            00000000 000000 000000 00      0   0  0
      [ 1] .text             PROGBITS        08048074 000074 00002a 00  AX  0   0  4
      [ 2] .data             PROGBITS        080490a0 0000a0 000038 00  WA  0   0  4
      [ 3] .shstrtab         STRTAB          00000000 0000d8 000027 00      0   0  1
      [ 4] .symtab           SYMTAB          00000000 0001f0 0000a0 10      5   6  4
      [ 5] .strtab           STRTAB          00000000 000290 000040 00      0   0  1
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings)
      I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
      O (extra OS processing required) o (OS specific), p (processor specific)

    There are no section groups in this file.

    Program Headers:
      Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
      LOAD           0x000000 0x08048000 0x08048000 0x0009e 0x0009e R E 0x1000
      LOAD           0x0000a0 0x080490a0 0x080490a0 0x00038 0x00038 RW  0x1000

     Section to Segment mapping:
      Segment Sections...
       00     .text 
       01     .data 

    There is no dynamic section in this file.

    There are no relocations in this file.

    There are no unwind sections in this file.

    Symbol table '.symtab' contains 10 entries:
       Num:    Value  Size Type    Bind   Vis      Ndx Name
         0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
         1: 08048074     0 SECTION LOCAL  DEFAULT    1 
         2: 080490a0     0 SECTION LOCAL  DEFAULT    2 
         3: 080490a0     0 NOTYPE  LOCAL  DEFAULT    2 data_items
         4: 08048082     0 NOTYPE  LOCAL  DEFAULT    1 start_loop
         5: 08048097     0 NOTYPE  LOCAL  DEFAULT    1 loop_exit
         6: 08048074     0 NOTYPE  GLOBAL DEFAULT    1 _start
         7: 080490d8     0 NOTYPE  GLOBAL DEFAULT  ABS __bss_start
         8: 080490d8     0 NOTYPE  GLOBAL DEFAULT  ABS _edata
         9: 080490d8     0 NOTYPE  GLOBAL DEFAULT  ABS _end

    No version information found in this file.
        ELF Header:
          Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
          Class:                             ELF32
          Data:                              2's complement, little endian
          Version:                           1 (current)
          OS/ABI:                            UNIX - System V
          ABI Version:                       0
          Type:                              REL (Relocatable file)
          Machine:                           Intel 80386
          Version:                           0x1
          Entry point address:               0x0
          Start of program headers:          0 (bytes into file)
          Start of section headers:          200 (bytes into file)
          Flags:                             0x0
          Size of this header:               52 (bytes)
          Size of program headers:           0 (bytes)


