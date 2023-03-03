----------          ----------
---------- 插件配置 ----------
----------          ----------

-- 安装插件
require("packer").startup(function()
  -- 插件管理器 Packer
  use("wbthomason/packer.nvim")

  -- dracula 主题
  use ('Mofiqul/dracula.nvim')

  -- 文件目录树
  use({ "nvim-tree/nvim-tree.lua", requires = "nvim-tree/nvim-web-devicons" })

  -- 文件 Tab 页
  use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

  -- 代码高亮
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- 括号配对
  use("windwp/nvim-autopairs")

  -- 底部状态栏
  use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })

  -- Git 更改信息
  use({ "lewis6991/gitsigns.nvim" })

  -- 保存文件关闭时的光标位置
  use({ "ethanholz/nvim-lastplace" })

  -- Telescope 搜索
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
end)


-----              -----
----- dracula.nvim -----
-----              -----
require("dracula").setup({})
require("dracula").load()

-----           -----
----- nvim-tree -----
-----           -----
require("nvim-tree").setup({})

-----            -----
----- bufferline -----
-----            -----
require("bufferline").setup({
  options = {
    -- 左侧让出 nvim-tree 的位置
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

-----                 -----
----- nvim-treesitter -----
-----                 -----
require("nvim-treesitter.configs").setup({
  -- 安装 language parser
  ensure_installed = {"c", "cmake", "cpp", "lua", "make", "python", "rust", "toml", "vim", "yaml" },
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-----                -----
----- nvim-autopairs -----
-----                -----
require("nvim-autopairs").setup({})

-----         -----
----- lualine -----
-----         -----
require("lualine").setup({
  options = { theme = "dracula-nvim" },
})

-----          -----
----- gitsigns -----
-----          -----
require("gitsigns").setup({})

-----                -----
----- nvim-lastplace -----
-----                -----
require("nvim-lastplace").setup({
  lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
  lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
  lastplace_open_folds = true,
})
