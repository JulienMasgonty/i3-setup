return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    config = function()
        require("render-markdown").setup({
            render_modes = { "n", "c", "t" },
            file_types = { "markdown", "copilot-chat" }
        })
    end
}
