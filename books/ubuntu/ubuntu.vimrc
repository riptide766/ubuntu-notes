"创建新的tab页面
":menu Tab.&amp;Addnew &lt;esc&gt;:tabnew&lt;cr&gt;
"关闭tab页面
":menu &lt;slient&gt;Tab.&amp;close &lt;esc&gt;:confirm tabclose&lt;cr&gt;

" 预览RST文件
":com RP :exec "Vst html" | w! /tmp/test.html | :q | !firefox /tmp/test.html
" :nmenu 80.100 Mine.preview	:RP<CR>

nmap <silent> <F5> :call MutilExec()<CR>

"autocmd! bufwritepost _vimrc source %

" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1

" 保存文件
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>


" 行选中移动
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" 映射变量<leader>
:let mapleader = ","

" 取消查找高亮
map <F4> :nohlsearch<CR>
"
" NERDTree插件：开关文件管理器
map <F3> :NERDTreeToggle<CR>
"
" 切换注释
map <F8> <leader>c<Space>
" 替换当前单词
nmap <silent> S :let @x=@"<CR>"_diw"xP

" 删除当前单词
nmap <silent> F :let @x=@"<CR>"xdiw

" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 语法高亮
set syntax=off
"配色方案
colorscheme torte
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
" 自动换行
set wrap
" 整词换行
set linebreak
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set helplang=cn
set encoding=utf8 
set langmenu=zh_CN.UTF-8 
set imcmdline 
source $VIMRUNTIME/delmenu.vim 
source $VIMRUNTIME/menu.vim
" 设置字体。
set guifont=Liberation\Mono\ 12

"set  guifont=Fixedsys\Excelsior\3.01\ 14

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
" 总是显示状态行
set laststatus=2
" 在编辑过程中，在右下角显示光标位置的状态行
set ruler           
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
if has("autocmd")

"设置字典 ~/.vim/dict/javascript.dict是字典文件的路径
autocmd FileType javascript set dictionary=~/.vim/dict/javascript.dict

autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number

autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->

autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/

autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100

autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim

" python 自动完成
autocmd FileType python set omnifunc=pythoncomplete#Complete  

autocmd BufReadPost * 

  \ if line("'\"") > 0 && line("'\"") <= line("$") | 

  \   exe "normal g`\"" |

  \ endif

endif " has("autocmd")



" F5编译和运行C程序，F6编译和运行C++程序
" C的编译和运行
"map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
"exec "!gcc -Wall % -o %<"
exec "!python %"
"exec "! ./%<"
endfunc

 

" C++的编译和运行
"map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
exec "!g++ -Wall % -o %<"
exec "! ./%<"
endfunc
" 能够漂亮地显示.NFO文件
set encoding=utf-8
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings

let &fileencodings=a:encodings

endfunction
function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak

unlet b:myfileencodingsbak

endfunction
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
" 用空格键来开关折叠
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"-----------
" 模仿MS Windows中的快捷键 
"-----------
vmap <C-c> "yy 
vmap <C-x> "yd 
nmap <C-v> "yp 
vmap <C-v> "yp 
nmap <C-a> ggvG$

function! MutilExec()
	let suffix = &ft
	echo suffix
	if(suffix=='python')	
		:exec ':! python %'
	endif
	if(suffix=='rst')
		:exec "Vst html" | w! /tmp/test.html | :q | !firefox /tmp/test.html
	endif	
endfunction
