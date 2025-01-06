return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")

        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan"
        }

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#423435" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#4d483e" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#394147" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#524840" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#384032" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3d3440" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2d393b" })
        end)

        ibl.setup { indent = { highlight = highlight } }
    end
}
