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
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#45282a" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#524a3a" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2d3d4a" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#4d3b2a" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#37452d" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3a2940" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#283d40" })
        end)

        ibl.setup { indent = { highlight = highlight } }
    end
}
