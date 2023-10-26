return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "L3MON4D3/LuaSnip",
    "petertriho/cmp-git",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",  -- show only symbol annotations
          maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          symbol_map = { Copilot = "" },

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(entry, vim_item)
            return vim_item
          end
        })
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<A-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
        ["<A-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- Confirm with tab. If no entry is selected, confirm the first item.
          if cmp.visible() and has_words_before() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              cmp.confirm()
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, { "i", "s", "c", }),
      }),
      sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
      }),
      sorting = {
        comparators = {
          -- label_comparator,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
        },
      },
      experimental = {
        ghost_text = true,
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = "buffer" },
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })

    -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      })
    })

    -- Insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
}
