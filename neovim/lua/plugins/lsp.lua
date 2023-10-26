return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", build = ":MasonUpdate", },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- We set up the plugins in the following order (according to mason-lspconfig.nvim README):
    --   1. mason.nvim
    --   2. mason-lspconfig.nvim
    --   3. Setup servers via lspconfig

    -- 1/3: setup mason.nvim
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
        keymaps = {
          toggle_package_expand = "o",     -- Expand a package
          install_package = "<CR>",        -- Install the package under the current cursor position
          update_package = "u",            -- Reinstall/update the package under the current cursor position
          check_package_version = "c",     -- Check for new version for the package under the current cursor position
          update_all_packages = "U",       -- Update all installed packages
          check_outdated_packages = "C",   -- Check which installed packages are outdated
          uninstall_package = "X",         -- Uninstall a package
          cancel_installation = "<C-c>",   -- Cancel a package installation
          apply_language_filter = "<C-f>", -- Apply language filter
        },
      }
    })

    -- 2/3: setup mason-lspconfig.nvim
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "jsonls",
        "lua_ls",
        "jedi_language_server",
      },
      automatic_installation = true,
    })

    -- 3/3: setup lspconfig
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason-lspconfig").setup_handlers {
      -- Let mason-lspconfig auto load lspconfig settings
      function(server_name)
        require("lspconfig")[server_name].setup {}
      end,

      -- Special config for each lsp
      ["pylsp"] = function()
        require("lspconfig").pylsp.setup {
          capabilities = capabilities,
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { maxLineLength = 120 },
                pydocstyle = { enabled = true },
                rope_autoimport = { enabled = true },
                rope_completion = { enabled = true },
              }
            }
          }
        }
      end
    }

    -- Settings after lsp attach to current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- See `:help vim.lsp.*` for more
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "qf", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    -- Icon for lsp diagnostics on the left column
    -- Need to set `vim.opt.signcolumn = "yes"` for better experience
    local signs = {
      Error = " ",
      Warn  = " ",
      Hint  = "💡",
      Info  = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Icon for lsp diagnostics with virtual text
    vim.diagnostic.config({
      virtual_text = {
        prefix = " "
      }
    })
  end
}
