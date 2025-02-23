return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "dot",
        "gleam",
        "go",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "nginx",
        "perl",
        "php",
        "phpdoc",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "terraform",
        "tmux",
        "twig",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig"
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
