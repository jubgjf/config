return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    local opt = { noremap = true, nowait = true }
    vim.keymap.set("n", "<leader>tf", builtin.find_files, opt)
    vim.keymap.set("n", "<leader>tg", builtin.live_grep, opt)
    vim.keymap.set("n", "<leader>tw", builtin.buffers, opt)
    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, opt)
  end
}
