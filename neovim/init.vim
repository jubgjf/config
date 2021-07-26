" ========== 插件 ==========

" 设置插件路径
call plug#begin('~/.vim/plugged')

" 底部状态栏及顶部 tab 栏优化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" easymotion 快速跳转
Plug 'easymotion/vim-easymotion'

" 自动引号/括号
Plug 'jiangmiao/auto-pairs'

" fzf 模糊查找、设置其快捷键
Plug 'junegunn/fzf'
noremap <C-f> :FZF<CR>

" coc.nvim 智能插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-explorer']
" 回车确认补全
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" 在没有选中任何一项时，指定按回车为选择第一项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" 换行时自动格式化
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 显示详细提示信息
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" TAB 和 Shift TAB 切换各个补全选项
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" TAB 跳转到下一个自动补全位置
" let g:coc_snippet_next = '<TAB>'

" 快速注释
Plug 'preservim/nerdcommenter'

" vim 主题
Plug 'navarasu/onedark.nvim'

" vim-surround
Plug 'tpope/vim-surround'

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

" 光标样式：竖线
set guicursor=n-v:block,i:ver10

" vim 主题
let g:onedark_style = 'cool'
let g:onedark_transparent_background = 1
colorscheme onedark


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

" 切换 tab
nnoremap <S-A-l> :bn<CR>
nnoremap <S-A-j> :bp<CR>

" 格式化代码
nnoremap <leader>f :call CocAction('format')<CR>

" 切换行注释
nnoremap <leader>c :call NERDComment(0, 'toggle')<CR>

" 切换文件目录树
nnoremap <leader>e :CocCommand explorer<CR>

" 多光标模式
nnoremap <leader>v <C-v>

" 退出
noremap Q :q<CR>

" 保存
noremap W :w<CR>

" 调整 ESC
inoremap jj <ESC><Right>

" 插入模式
noremap <Space> i

" 修改当前单词
nnoremap ciw ciw

" 选中整个单词
nnoremap viw viw
