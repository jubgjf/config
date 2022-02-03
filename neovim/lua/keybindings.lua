----------          ----------
---------- 按键映射 ----------
----------          ----------


local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- leader 键
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- 光标移动
map('', 'i', '<Up>', opt)
map('', 'j', '<Left>', opt)
map('', 'k', '<Down>', opt)
map('', 'l', '<Right>', opt)

map('i', '<A-i>', '<Up>', opt)
map('i', '<A-j>', '<Left>', opt)
map('i', '<A-k>', '<Down>', opt)
map('i', '<A-l>', '<Right>', opt)

map('', '<S-i>', '5<Up>', opt)
map('', '<S-j>', '^', opt)
map('', '<S-k>', '5<Down>', opt)
map('', '<S-l>', 'g_', opt)

-- 整行移动
map('n', '<S-A-i>', ':m -2<CR>', opt)
map('n', '<S-A-k>', ':m +1<CR>', opt)
map('i', '<S-A-i>', '<ESC>:m -2<CR>i', opt)
map('i', '<S-A-k>', '<ESC>:m +1<CR>i', opt)

-- 向下复制一整行
map('n', '<C-A-k>', 'yyp', opt)

-- 切换 Tab
map('n', '<S-A-l>', ':bn<CR>', opt)
map('n', '<S-A-j>', ':bp<CR>', opt)

-- 清除搜索后的高亮
map('n', '<leader>h', ':noh<CR>', opt)

-- 窗口切换
map('n', '<leader>wi', '<C-w><Up>', opt)
map('n', '<leader>wj', '<C-w><Left>', opt)
map('n', '<leader>wk', '<C-w><Down>', opt)
map('n', '<leader>wl', '<C-w><Right>', opt)

-- 切换缩进
map('n', '>', '>>', opt)
map('n', '<', '<<', opt)

-- 退出
map('n', 'Q', ':q<CR>', opt)

-- 保存
map('n', 'W', ':w<CR>', opt)

-- 调整 ESC
map('i', 'jj', '<ESC>', opt)
map('t', 'jj', '<C-\\><C-n>', opt)

-- 插入模式
map('n', '<Space>', 'i', opt)

-- 文件目录树
map('n', '<leader>e', ':NvimTreeToggle<CR>', opt)
