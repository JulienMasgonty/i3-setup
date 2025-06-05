return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "l3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "petertriho/cmp-git",
      "onsails/lspkind.nvim",
      "davidosomething/format-ts-errors.nvim",
    },
    config = function()

      -- CMP CONFIGURATION

      local lspkind = require("lspkind")
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
            { name = "buffer" }
          }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            return lspkind.cmp_format({})(entry, vim_item)
          end
        }
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }
        }, {
            { name = "buffer" }
          })
      })

      require("cmp_git").setup()

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
            { name = "cmdline" }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      require("luasnip.loaders.from_vscode").lazy_load()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP CONFIGURATION

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "require" }
            }
          }
        },
        capabilities = capabilities
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities
      })

      vim.lsp.config("eslint", {
        capabilities = capabilities
      })

      vim.lsp.config("emmet_ls", {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascriptreact",
          "typescriptreact"
        },
        init_options = {
          html = {
            options = {
              ["output.selfClosingStyle"] = "xhtml",
              ["jsx.enabled"] = true
            }
          }
        },
        capabilities = capabilities
      })

      vim.lsp.config("cssls", {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore"
            }
          }
        },
        capabilities = capabilities
      })

      vim.lsp.config("tailwindcss",  {
        capabilities = capabilities
      })

      vim.lsp.config("dockerls",  {
        capabilities = capabilities
      })

      vim.lsp.config("docker_compose_language_service",  {
        capabilities = capabilities
      })

      vim.lsp.config("helm_ls",  {
        capabilities = capabilities
      })

      vim.lsp.config("sqlls",  {
        capabilities = capabilities
      })

      vim.lsp.config("clangd",  {
        capabilities = capabilities
      })

      vim.lsp.config("bashls",  {
        capabilities = capabilities
      })

      vim.lsp.config("zls",  {
        capabilities = capabilities
      })

      require("mason").setup()

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "eslint",
          "emmet_ls",
          "html",
          "cssls",
          "tailwindcss",
          "dockerls",
          "docker_compose_language_service",
          "helm_ls",
          "sqlls",
          "clangd",
          "bashls",
          "zls"
        },
        automatic_enable = true
      }
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      hint_enable = false;
      handler_opts = {
        border = "single"
      }
    }
  }
}
