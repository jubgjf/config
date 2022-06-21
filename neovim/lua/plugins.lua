----------          ----------
---------- 插件配置 ----------
----------          ----------

-- 安装插件
require("packer").startup(function()
  -- 插件管理器 Packer
  use("wbthomason/packer.nvim")

  -- LSP 支持
  use("neovim/nvim-lspconfig")

  -- 代码补全
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp") -- LSP      source for nvim-cmp
  use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
  use("hrsh7th/cmp-path") -- 路径补全
  use("L3MON4D3/LuaSnip") -- 代码片段
  use("onsails/lspkind-nvim") -- 代码补全小图标

  -- onedark 主题
  use("navarasu/onedark.nvim")

  -- 文件目录树
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

  -- 文件 Tab 页
  use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })

  -- 代码高亮
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- 括号配对
  use("windwp/nvim-autopairs")

  -- 底部状态栏
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

  -- Git 更改信息
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup()
    end,
  })

  -- 保存文件关闭时的光标位置
  use("ethanholz/nvim-lastplace")
end)

-----                -----
----- nvim-lspconfig -----
-----                -----

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "he", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- on_attach 在 LSP 加载后才会运行
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>:vsp<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "hh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

-- nvim-cmp 额外功能
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = { }
for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

-----          -----
----- nvim-cmp -----
-----          -----
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    -- 自动选中第一项
    completeopt = "menu,menuone,noinsert",
  },
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<A-i>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<A-k>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<A-j>"] = function(fallback)
      if luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<A-l>"] = function(fallback)
      if luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end,
  },
  -- 使用 lspkind-nvim 显示图标
  formatting = {
    format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      before = function(entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end,
    }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
  experimental = {
    ghost_text = true,
  },
})

-----              -----
----- onedark.nvim -----
-----              -----
require("onedark").setup({
  style = "cool",
})
require("onedark").load()

-----            -----
----- bufferline -----
-----            -----
require("bufferline").setup({
  options = {
    -- 使用 nvim 内置lsp
    diagnostics = "nvim_lsp",
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
-- 在 nvim-cmp 补全一个函数之后，自动加上括号
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-----         -----
----- lualine -----
-----         -----
require("lualine").setup({
  options = { theme = "palenight" },
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
