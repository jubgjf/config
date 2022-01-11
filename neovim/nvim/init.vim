" ==========          ==========
" ========== 安装插件 ==========
" ==========          ==========

" 设置插件路径
call plug#begin('~/.vim/plugged')

" vim-airline 底部状态栏及顶部 tab 栏优化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" coc.nvim 插件集合
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerdcommenter 快速注释
Plug 'preservim/nerdcommenter'

" onedark.nvim 主题
Plug 'navarasu/onedark.nvim'

" vim-surround 代码包围
Plug 'tpope/vim-surround'

" vim-rainbow 彩虹括号
Plug 'frazrepo/vim-rainbow'

" 插件结束
call plug#end()



" ==========          ==========
" ========== 通用设置 ==========
" ==========          ==========

" 打开真彩色
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" 打开相对行号和行号
set rnu nu

" win32yank/xclip 共享系统粘贴板
set clipboard=unnamedplus

" vim 自身命令行模式智能补全
set wildmenu

" 设置搜索高亮
set hlsearch
" 模式搜索实时预览，增量搜索
set incsearch
" 搜索忽略大小写
set ignorecase
" 当搜索字符出现大写时，自动切换大小写敏感
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

" 显示空白符的样式
set listchars+=space:␣

" 跳转到文件关闭时的光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 显示光标所在行
set cursorline

" 光标样式
set guicursor=n-v:block,i:ver10

" 允许不保存跳转
set hidden

" 代码折叠
set foldmethod=syntax
set nofoldenable

" 刷新时间
set updatetime=300

" 不自动折行
set nowrap



" ==========          ==========
" ========== 按键映射 ==========
" ==========          ==========

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
noremap <S-l> g_

" 整行移动
nnoremap <S-A-i> :m -2<CR>
nnoremap <S-A-k> :m +1<CR>
inoremap <S-A-i> <ESC>:m -2<CR>i
inoremap <S-A-k> <ESC>:m +1<CR>i

" 向下复制一整行
nnoremap <C-A-k> yyp
inoremap <C-A-k> <Esc>yypi

" 切换 Tab
nnoremap <S-A-l> :bn<CR>
nnoremap <S-A-j> :bp<CR>

" 多光标模式
nnoremap <leader>v <C-v>

" 清除搜索后的高亮
nnoremap <leader>h :noh<CR>

" 窗口切换
nnoremap <leader>wi <C-w><Up>
nnoremap <leader>wj <C-w><Left>
nnoremap <leader>wk <C-w><Down>
nnoremap <leader>wl <C-w><Right>

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
nnoremap <Space> i

" 修改当前单词
nnoremap ciw ciw

" 选中整个单词
nnoremap viw viw

" 复制当前单词
nnoremap yiw yiw



" ==========          ==========
" ========== 插件设置 ==========
" ==========          ==========

" =====             =====
" ===== vim-airline =====
" =====             =====

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1


" =====          =====
" ===== coc.nvim =====
" =====          =====

let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-explorer',
            \ 'coc-git',
            \ 'coc-highlight',
            \ 'coc-json',
            \ 'coc-pairs',
            \ 'coc-pyright',
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-yank',
            \]

" Tab 确认补全
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Alt k 和 Alt i 切换各个补全选项
inoremap <expr> <A-k> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <A-i> pumvisible() ? "\<C-p>" : "\<Up>"

" Tab 跳转到下一个自动补全位置，并保持 Tab 确认补全的兼容性
inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<Tab>'

" 格式化代码
nnoremap <leader>f :call CocAction('format')<CR>

" 符号重命名
nmap <leader>rn <Plug>(coc-rename)

" 快速修复
nmap <leader>qf <Plug>(coc-fix-current)

" 触发 LSP 代码功能
nmap <leader>ac <Plug>(coc-codeaction)

" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :vsp<CR><Plug>(coc-definition)<C-w>L

" 跳转到引用
nmap <silent> gr <Plug>(coc-references)

" 快速 CocCommand
nnoremap <leader>cc :CocCommand<Space>

" git 显示更改
nnoremap <leader>gci :CocCommand git.chunkInfo<CR>

" 切换文件目录树
nnoremap <leader>e :CocCommand explorer<CR>

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

" 禁用括号匹配字符
let b:coc_pairs_disabled = ['<']

" 高亮光标所在符号
autocmd CursorHold * silent call CocActionAsync('highlight')


" =====               =====
" ===== nerdcommenter =====
" =====               =====
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
nnoremap <leader>cm :call nerdcommenter#Comment(0, 'toggle')<CR><Down>
vnoremap <leader>cm :call nerdcommenter#Comment(0, 'toggle')<CR><Down>


" =====              =====
" ===== onedark.nvim =====
" =====              =====

let g:onedark_config = {
    \ 'style': 'cool',
\}
colorscheme onedark


" =====             =====
" ===== vim-rainbow =====
" =====             =====

let g:rainbow_active = 1

