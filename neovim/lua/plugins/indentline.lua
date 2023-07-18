vim.opt.list = true
vim.opt.listchars:append "space:⋅"

return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    space_char_blankline = " ",
  }
}
