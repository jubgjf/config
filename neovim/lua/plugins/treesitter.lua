return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "c",
      "cmake",
      "diff",
      "cpp",
      "jq",
      "lua",
      "make",
      "python",
      "rust",
      "toml",
      "vim",
      "yaml",
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
}
