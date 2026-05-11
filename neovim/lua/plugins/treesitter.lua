return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "cmake",
        "csv",
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "html",
        "json",
        "json5",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "ssh_config",
        "toml",
        "tsv",
        "vim",
        "yaml",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require('treesitter-context').setup({
        enable = true,
      })
    end
  }
}
