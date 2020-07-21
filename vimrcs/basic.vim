"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 维护成员 Maintainer: 
"       Amir Salihefendic — @amix3k
"
" 增强版本 Awewesome_version:
"       Get this config, nice color schemes and lots of plugins!
"       获得这份配置,漂亮的主题,和一堆有用的插件!
"       Install the awesome version from:
"       从下面的网址安装增强版:
"
"           https://github.com/amix/vimrc
"
" 配置分区 Sections:
"    -> 通用设置 General
"    -> VIM用户界面 VIM user interfase
"    -> 颜色和字体 Colors and Fonts
"    -> 文件和备份 Files and backups
"    -> 文字,索引标签及缩进相关 Text, tab and indent related
"    -> 可视模式相关 Visual mode related
"    -> 移动,标签栏和缓冲区 Moving around, tabs and buffers
"    -> 状态栏 Status line
"    -> 按键映射 Editing mappings
"    -> vimgrep搜索和显示 vimgrep searching and cope displaying
"    -> 拼写检查 Spell checking
"    -> 杂项 Misc
"    -> 辅助功能 Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 通用设置 General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
" 设置VIM历史行数
set history=500

" Enable filetype plugins
" 启用文件类型插件
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
" 从外部更改文件时重新读取
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" 通过设置[映射引导按键] <leader> 可以绑定更多的组合键
" 例如 <leader>w 保存当前文件
let mapleader = ","

" Fast saving
" 快速保存
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
" :W 以管理员权限保存
" (在处理权限错误拒绝时非常有效)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM 用户界面 VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
" 设置在使用j/k案件移动时,光标始终距离底栏有7行
set so=7

" Avoid garbled characters in Chinese language windows OS
" 避免在中文windows操作系统上混淆字符
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
" 其用命令行增强模式,在命令行tab补全时有提示栏
set wildmenu

" Ignore compiled files
" 忽略已编译文件
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
" 始终显示当前位置(行,列)
set ruler

" Height of the command bar
" 命令行高度
set cmdheight=1

" A buffer becomes hidden when it is abandoned
" 当缓冲区被放弃时隐藏
set hid

" Configure backspace so it acts as it should act
" 配置 Backspace 键,让它符合日常习惯
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
" 搜索时忽略大小写
set ignorecase

" When searching try to be smart about cases 
" 开启智能搜索,当输入大写时,忽略大小写失效
set smartcase

" Highlight search results
" 高亮显示搜索结果
set hlsearch

" Makes search act like search in modern browsers
" 实时高亮显示搜索字符,多输入一个匹配多一个,不必等待全部输完
set incsearch 

" Don't redraw while executing macros (good performance config)
" 在执行宏时不重绘屏幕(不在意性能消耗的时候打开会有更好的视觉效果 :set redraw)
set lazyredraw 

" For regular expressions turn magic on
" 设置正则表达式的模式(vim支持数种正则匹配规则)
set magic

" Show matching brackets when text indicator is over them
" 插入括号时，短暂地跳转到匹配的对应括号,有闪烁提醒的效果
set showmatch 
" How many tenths of a second to blink when matching brackets
" 上一项跳转停留时间,单位:0.1s,过了时间后跳回去
set mat=2

" No annoying sound on errors
" 错误不吵人
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
" 准确禁用MacVim上的错误声音
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
" 在左边添加一点额外的空白
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 颜色和字体 Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" 启用语法高亮
syntax enable 

" Enable 256 colors palette in Gnome Terminal
" 启用终端256色显示
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

" 设置主题为黑
set background=dark

" Set extra options when running in GUI mode
" 当在GUI模式下运行的时候的额外设置
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
" 设置utf8为默认编码规则,en_US为标准语言
set encoding=utf8

" Use Unix as the standard file type
" 使用UNIX作为默认文件类型标准
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文件,备份和撤销操作 Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
" 取消备份设置,现在一般都用SVN,git
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文本,<tab>键和缩进相关 Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
" 使用空格代替缩进
set expandtab

" Be smart when using tabs ;)
" 使用智能缩进
set smarttab

" 1 tab == 4 spaces
" 1 <tab>等于4空格
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
" 500个字符就换行
set lbr
set tw=500

set ai 
"Auto indent 自动缩进
set si 
"Smart indent 智能缩进
set wrap 
"Wrap lines 换行


""""""""""""""""""""""""""""""
" => 可视模式相关 Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" 可视模式按*或#搜索当前选中内容
" 非常有用的设置
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 移动,标签页,窗口和缓冲区 Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" 把空格键映射为搜索,ctrl+空格映射为反向搜索
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
" 同时按下<lerder><cr>取消高亮 <CR>回车键
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" 在窗口间移动的高效方法
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" 关闭当前缓冲区
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
" 关闭所有缓冲区
map <leader>ba :bufdo bd<cr>

" 切换缓冲区
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
" 高效管理标签页的映射
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
" 按下<leader>tl交换标签页
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
" 在新标签页中打开当前工作目录
" 非常有用
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
" 更换到当前缓存的工作目录
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
" 指定切换缓冲区时的行为
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
" 当打开文件时返回到最后一次编辑位置(你需要这个!!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => 状态栏 Status line
""""""""""""""""""""""""""""""
" Always show the status line
" 始终允许显示状态栏
set laststatus=2

" Format the status line
" 设置状态栏的格式
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 编辑映射 Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" 将vim 0 重新映射到第一个非空字符
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
" 用ALT+[jk]或者command+[jk]移动一行文本
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes :)
" 在保存时删除尾随的空白,对某些文件类型有用:)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 拼写检查 Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
" 按下<leader>ss将切换拼写检查是否开启的状态
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
" 使用<leader>的快捷键
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 杂项 Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
" 当编码混乱时,删除window
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
" 快速打开一个缓冲区作为草稿
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" 快速打开一个markdown格式缓冲区作为草稿
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
" 切换粘贴模式
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
" 如果粘贴模式启用返回ture
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
" 删除缓冲区的时候不会关闭窗口
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
