return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
        excludes = { "neo-tree" },
      },
      event = { "BufRead", "BufNewFile" }
    })

    vim.keymap.set("n", "<leader>ccc", ":CccPick<CR>")
  end
}
