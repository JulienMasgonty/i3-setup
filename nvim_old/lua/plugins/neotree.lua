return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  config = function()
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")

    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticsSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
      event_handlers = {
        { -- close neotree after opening a file
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        }
      },
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_using_relative_paths = false,
      sort_case_insensitive = false,
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = nil,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander"
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- fallback :
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
        modified = { symbol = "[✚]", highlight = "NeoTreeModified" },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName"
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = ""
          }
        },
        file_size = { enabled = true, width = 12, required_width = 64 },
        type = { enabled = true, width = 10, required_width = 122 },
        last_modified = { enabled = true, width = 20, required_width = 88 },
        created = { enabled = true, width = 20, required_width = 110 },
        symlink_target = { enabled = false }
      },
      commands = {},
      window = {
        position = "right",
        width = 30,
        mapping_options = { noremap = true, nowait = true },
        mappings = { 
          ["<space>"] = { "toggle_node", nowait = false },
          ["<CR>"] = "open",
          ["<esc>"] = "cancel",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["l"] = "focus_preview",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = { "add", config = { show_path = "non" } },
          ["d"] = "add_directory",
          ["x"] = "delete",
          ["r"] = "rename",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["i"] = { "show_file_details", config = { created_format = "%Y-%m-%d %I:%M %p", modifed_format = "relative" } }
        }
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {},
          hide_by_pattern = {},
          always_show = {},
          always_show_by_pattern = {},
          never_show = {},
          never_show_by_pattern = {}
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false
        },
        group_empty_dirs = false,

      }
    })    
  end
}
