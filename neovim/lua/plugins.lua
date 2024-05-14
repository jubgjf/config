local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    require("plugins.autopairs"),
    -- require("plugins.autosave"),
    -- require("plugins.cmp"),
    require("plugins.comment"),
    -- require("plugins.copilot"),
    require("plugins.flash"),
    require("plugins.git"),
    -- require("plugins.illuminate"),
    -- require("plugins.indentline"),
    require("plugins.lastplace"),
    -- require("plugins.lsp"),
    require("plugins.neotree"),
    require("plugins.surround"),
    -- require("plugins.telescope"),
    -- require("plugins.terminal"),
    require("plugins.treesitter"),
    -- require("plugins.trouble"),
    require("plugins.ui"),
  },
  {}
)
