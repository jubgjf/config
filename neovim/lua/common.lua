----------          ----------
---------- 通用设置 ----------
----------          ----------

-- 打开真彩色
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 打开相对行号和行号
vim.wo.number = true
vim.wo.relativenumber = true

-- win32yank/xclip 共享系统粘贴板
vim.o.clipboard = "unnamedplus"

-- vim 自身命令行模式智能补全
vim.o.wildmenu = true

-- 设置搜索高亮
vim.o.hlsearch = true
-- 模式搜索实时预览，增量搜索
vim.o.incsearch = true
-- 搜索忽略大小写
vim.o.ignorecase = true
-- 当搜索字符出现大写时，自动切换大小写敏感
vim.o.smartcase = true

-- 设置制表符占用空格数
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- 设置格式化时制表符占用空格数
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 滚动时设置光标距离屏幕边缘距离 5 行
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

-- 开启鼠标
vim.o.mouse = "a"

-- 显示光标所在行
vim.wo.cursorline = true

-- 允许不保存跳转
vim.o.hidden = true

-- 代码折叠
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99

-- 刷新时间
vim.o.updatetime = 300

-- 不自动折行
vim.o.wrap = false
vim.wo.wrap = false

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 复制时高亮
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")
