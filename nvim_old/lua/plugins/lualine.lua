return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  config = function()
    require("lualine").setup({
      options = {
        theme = "onedark",
        component_separators = '',
        section_separators = '',
        disabled_filetypes = { 'neo-tree', 'undotree', 'diff' },
        ignore_focus = { 'neo-tree', 'undotree', 'diff' }
      }
    })
  end
}
