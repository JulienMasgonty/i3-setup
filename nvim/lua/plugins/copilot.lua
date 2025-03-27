return {
    {
        "github/copilot.vim",
        config = function()
          vim.g.copilot_filetypes = { zig = false }
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" }
        },
        config = function()
            --local prompts = require("CopilotChat.config.prompts")
            -- local context = require("CopilotChat.context")
            --local select = require("CopilotChat.select")
            -- local utils = require ("CopilotChat.utils")

            require("CopilotChat").setup({
                -- system_prompt = prompts.COPILOT_INSTRUCTIONS,
                -- model = "gpt-4o",
                -- agent = "copilot",
                -- context = nil,
                -- temperature = 0.1,

                -- headless = false,
                -- callback = nil,

                -- selection = function(source)
                --     return select.visual(source) or select.buffer(source)
                -- end,

                window = {
                    layout = "vertical",
                    width = 0.3,
                    height = 0.5
                },

                -- show_help = true,
                -- highlight_selection = true,
                -- highlight_headers = false,
                -- auto_follow_cursor = true,
                -- auto_insert_mode = false,
                -- insert_at_end = false,
                -- clear_chat_on_new_prompt = false,

                -- debug = false,
                -- log_level = "info",
                -- proxy = nil,
                -- allow_insecure = false,

                -- chat_autocomplete = true,
                -- history_path = vim.fn.stdpath("data") .. "/copilotchat_history",

                -- question_header = "# User ",
                -- answer_header = "# Copilot ",
                -- error_header = "> [!ERROR] Error",
                -- separator = "------",

                -- prompts = {
                --     Explain = {
                --         prompt = "> /COPILOT_EXPLAIN\n\nWrite an explanation for the selected code as paragraphs"
                --     },
                --     Review = {
                --         prompt = "> /COPILOT_REVIEW\n\nReview the selected code"
                --     },
                --     Fix = {
                --         prompt = "> /COPILOT_GENERATE\n\nThere is a problem in this code. Rewrite the code to show it with the bug fixed.",
                --     },
                --     Optimize = {
                --         prompt = "> /COPILOT_GENERATE\n\nOptimize the selected code to improve performance and readability.",
                --     },
                --     Docs = {
                --         prompt = "> /COPILOT_GENERATE\n\nPlease add documentation comments to the selected code.",
                --     },
                --     Tests = {
                --         prompt = "> /COPILOT_GENERATE\n\nPlease generate tests for my code.",
                --     },
                --     Commit = {
                --         prompt = "> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
                --     },
                -- },
            })
        end
    }
}
