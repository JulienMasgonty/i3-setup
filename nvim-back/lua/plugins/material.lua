return {
    "marko-cerovac/material.nvim",
    config = function()
        local material = require("material")
        material.setup {
            config = {
                terminal = false,
                sidebars = false,
                floating_windows = false,
                cursor_line = true,
                lsp_virtual_text = true,
                non_current_windows = false,
                filetypes = {}
            },

            styles = {
                comments = { italic = true },
                strings = {},
                keywords = { bold = true },
                functions = { bold = true },
                variables = { bold = false },
                operators = {},
                types = { bold = true }
            },

            plugins = {
                "harpoon",
                "nvim-cmp",
                "telescope",
                "trouble"
            },

            disable = {
                colored_cursor = true,
                borders = false,
                background = true,
                term_colors = true,
                eob_lines = false
            },

            high_visibility = {
                lighter = false,
                darker = false
            },

            lualine_style = "stealth",

            async_loading = true,

            custom_colors = nil,

            custom_highlights = {}
        }

        vim.cmd "colorscheme material"
    end
}
