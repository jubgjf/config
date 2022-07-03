----------          ----------
---------- 按键映射 ----------
----------          ----------

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- leader 键
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- 光标移动
map("", "i", "<Up>", opt)
map("", "j", "<Left>", opt)
map("", "k", "<Down>", opt)
map("", "l", "<Right>", opt)

map("i", "<A-i>", "<Up>", opt)
map("i", "<A-j>", "<Left>", opt)
map("i", "<A-k>", "<Down>", opt)
map("i", "<A-l>", "<Right>", opt)

map("", "<S-i>", "5<Up>", opt)
map("", "<S-j>", "^", opt)
map("", "<S-k>", "5<Down>", opt)
map("", "<S-l>", "g_", opt)

-- 整行移动
map("n", "<S-A-i>", ":m -2<CR>", opt)
map("n", "<S-A-k>", ":m +1<CR>", opt)
map("i", "<S-A-i>", "<ESC>:m -2<CR>i", opt)
map("i", "<S-A-k>", "<ESC>:m +1<CR>i", opt)

-- 向下复制一整行
map("n", "<C-A-k>", "yyp", opt)

-- 切换 Tab
map("n", "<S-A-l>", ":bn<CR>", opt)
map("n", "<S-A-j>", ":bp<CR>", opt)

-- 窗口切换
map("n", "<C-i>", "<C-w>k", opt)
map("n", "<C-j>", "<C-w>h", opt)
map("n", "<C-k>", "<C-w>j", opt)
map("n", "<C-l>", "<C-w>l", opt)

-- 切换缩进
map("n", ">", ">>", opt)
map("n", "<", "<<", opt)

-- 退出
map("n", "Q", ":q<CR>", opt)

-- 保存
map("n", "W", ":w<CR>", opt)

-- 调整 ESC
map("t", "<ESC>", "<C-\\><C-n>", opt)

-- 插入模式
map("n", "<Space>", "i", opt)

-- i 调整
map("n", "ciw", "ciw", opt)
map("n", "diw", "diw", opt)
map("n", "viw", "viw", opt)
map("n", "yiw", "yiw", opt)

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)

-- Telescope
map("n", "ff", "<cmd>Telescope find_files<cr>", opt)
map("n", "fg", "<cmd>Telescope live_grep<cr>", opt)
