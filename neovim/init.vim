" ========== 插件 ==========

" 设置插件路径
call plug#begin('~/.vim/plugged')

" 底部状态栏及顶部 tab 栏优化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
nnoremap <S-A-L> :bn<CR>
nnoremap <S-A-j> :bp<CR>

" easymotion 快速跳转
Plug 'easymotion/vim-easymotion'

" 自动引号/括号
Plug 'jiangmiao/auto-pairs'

" fzf 模糊查找、设置其快捷键
Plug 'junegunn/fzf'
noremap <C-f> :FZF<CR>

" git 支持
Plug 'airblade/vim-gitgutter'
set updatetime=100

" 插件结束
call plug#end()



" ========== 通用设置 ==========

" 语法高亮
syntax on

" 打开相对行号和行号
set rnu nu

" 共享系统粘贴板
set clipboard=unnamed

" vim 自身命令行模式智能补全
set wildmenu

" 设置搜索高亮
set hlsearch
" 模式搜索实时预览，增量搜索
set incsearch
" 忽略大小写（配合 smartcase）
set ignorecase
" 模式查找时智能忽略大小写
set smartcase

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4

" 滚动时设置光标距离屏幕边缘距离 10 行
set scrolloff=10

" 开启鼠标
set mouse=a

" 显示空白符
" set list
set listchars+=space:␣

" 跳转到文件关闭时的光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 显示光标所在行
set cursorline



" ========== 按键映射 ==========

" leader 键
let mapleader=","

" 光标移动
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap l <Right>

inoremap <A-i> <Up>
inoremap <A-j> <Left>
inoremap <A-k> <Down>
inoremap <A-l> <Right>

noremap <S-i> 5<Up>
noremap <S-j> ^
noremap <S-k> 5<Down>
noremap <S-l> $

" 整行移动
nnoremap <S-A-i> :m -2<CR>
nnoremap <S-A-k> :m +1<CR>
inoremap <S-A-i> <ESC>:m -2<CR>i
inoremap <S-A-k> <ESC>:m +1<CR>i

" 向下复制一整行
nnoremap <C-A-k> yyp
inoremap <C-A-k> <Esc>yypi

" 格式化代码
nnoremap <leader>f gg=G``

" 切换行注释
" nnoremap <leader>c <TODO>

" 多光标模式
nnoremap <leader>v <C-v>

" 选中整个单词
nnoremap vv viw

" 退出
noremap Q :q<CR>

" 调整 ESC
inoremap jj <ESC><Right>

" 插入模式
noremap <Space> i

" 修改当前单词
noremap ciw ciw
