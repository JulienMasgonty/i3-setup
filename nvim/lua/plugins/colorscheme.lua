return {
  "EdenEast/nightfox.nvim",
  name = "carbonfox",
  priority = 1000,
  config = function()
    local palette = require("nightfox").load("carbonfox")
    require("nightfox").setup( { palettes = palette } )
    vim.cmd.colorscheme "carbonfox"
  end
}
