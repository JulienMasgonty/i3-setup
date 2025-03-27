return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
  },
  config = function()
    require("mason").setup()

    local lspkind = require("lspkind")
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = entry.source.name
          return lspkind.cmp_format({})(entry, vim_item)
        end,
      },
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })
    require("cmp_git").setup()

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "eslint",
        -- "angularls",
        "emmet_ls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "dockerls",
        "docker_compose_language_service",
        "helm_ls",
        "sqlls",
        "clangd",
        "bashls",
        "zls",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["emmet_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
              "html",
              "css",
              "scss",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact"
            },
            init_options = {
              html = {
                options = {
                  ["output.selfClosingStyle"] = "xhtml",
                  ["jsx.enabled"] = true,
                }
              }
            }
          })
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
            capabilities = capabilities,
          })
        end,
        ["cssls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.cssls.setup({
            settings = {
              css = {
                lint = {
                  unknownAtRules = "ignore",
                },
              },
            },
          })
        end,
      },
    })
    vim.g.zig_fmt_autosave = 0 -- Disable zig's annoying autoformating
  end,
}
