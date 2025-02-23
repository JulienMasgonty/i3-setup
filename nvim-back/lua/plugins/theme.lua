return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        local gruvbox = require("gruvbox")
        gruvbox.setup {
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = true,
                folds = true
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            inver_tabline = false,
            invert_indent_guides = true,
            inverse = true,
            contrast = "soft",
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false
        }
        vim.cmd("colorscheme gruvbox")
    end
}
