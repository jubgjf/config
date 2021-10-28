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

" coc.nvim 智能插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-explorer',
            \ 'coc-git',
            \ 'coc-json',
            \ 'coc-markdown-preview-enhanced',
            \ 'coc-pyright',
            \ 'coc-snippets',
            \ 'coc-webview',
            \ 'coc-yank',
            \]
" Tab 确认补全
inoremap <expr> <tab> pumvisible() ? "\<C-y>" : "\<tab>"
" 在没有选中任何一项时，指定按 Tab 为选择第一项
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"
" 显示详细提示信息
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Alt k 和 Alt i 切换各个补全选项
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <A-k>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <A-k> pumvisible() ? "\<C-n>" : "\<A-k>"
inoremap <expr> <A-i> pumvisible() ? "\<C-p>" : "\<A-i>"
" TAB 跳转到下一个自动补全位置
let g:coc_snippet_next = '<TAB>'
" 状态栏支持
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" 快速注释
Plug 'preservim/nerdcommenter'

" vim 主题
Plug 'navarasu/onedark.nvim'

" vim-surround
Plug 'tpope/vim-surround'

" ranger.vim
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0

" 插件结束
call plug#end()



" ========== 通用设置 ==========

" 语法高亮
syntax on

" 打开相对行号和行号
set rnu nu

" win32yank 共享系统粘贴板
set clipboard=unnamedplus

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

" 滚动时设置光标距离屏幕边缘距离 5 行
set scrolloff=5

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
noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap l <Right>

nnoremap <A-i> <Up>
nnoremap <A-j> <Left>
nnoremap <A-k> <Down>
nnoremap <A-l> <Right>

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
nnoremap <S-A-l> :w<CR>:bn<CR>
nnoremap <S-A-j> :w<CR>:bp<CR>

" 格式化代码
nnoremap <leader>f :call CocAction('format')<CR>

" 切换行注释
nnoremap <leader>c :call nerdcommenter#Comment(0, 'toggle')<CR><Down>
vnoremap <leader>c :call nerdcommenter#Comment(0, 'toggle')<CR><Down>

" 切换文件目录树
nnoremap <leader>e :CocCommand explorer<CR>

" 多光标模式
nnoremap <leader>v <C-v>

" 清除搜索后的高亮
nnoremap <leader>h :noh<CR>

" 窗口切换
nnoremap <leader>wi <C-w><Up>
nnoremap <leader>wj <C-w><Left>
nnoremap <leader>wk <C-w><Down>
nnoremap <leader>wl <C-w><Right>

" 符号重命名
nmap <leader>rn <Plug>(coc-rename)

" 快速修复
nmap <leader>qf <Plug>(coc-fix-current)

" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :vsp<CR><Plug>(coc-definition)<C-w>L

" 跳转到引用
nmap <silent> gr <Plug>(coc-references)

"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)

" git 操作
nnoremap <leader>gci :CocCommand git.chunkInfo<CR>

" 切换缩进
nnoremap > >>
nnoremap < <<

" 退出
noremap Q :q<CR>

" 保存
noremap W :w<CR>

" 调整 ESC
inoremap jj <ESC>

" 插入模式
noremap <Space> i

" 修改当前单词
nnoremap ciw ciw

" 选中整个单词
nnoremap viw viw

" 复制当前单词
nnoremap yiw yiw

" 触发 ranger.vim
nnoremap <leader>r :w<CR>:Ranger<CR>

" 显示函数文档
nnoremap hh :call <SID>show_documentation()<CR>
nnoremap hj :call coc#float#jump()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

