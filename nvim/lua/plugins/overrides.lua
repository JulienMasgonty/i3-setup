return {
  { -- snacks.nvim
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      explorer = {
        layout = { preset = "sidebar", preview = true },
      },
      picker = {
        layouts = {
          sidebar = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },

  { -- lualine.nvim
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "",
        section_separators = "",
      },
    },
  },
}
