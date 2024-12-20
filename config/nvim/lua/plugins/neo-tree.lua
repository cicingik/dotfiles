-- TODO

-- references:
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    -- event = "VeryLazy",
    keys = {
        { "<leader>e",     ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
        { "<leader><tab>", ":Neotree toggle left<CR>",  silent = true, desc = "Left File Explorer" },
    },
    config = function()
        vim.fn.sign_define({
            {
                name = 'DiagnosticSignError',
                text = '',
                texthl = 'DiagnosticSignError',
                linehl = 'ErrorLine',
            },
            {
                name = 'DiagnosticSignWarn',
                text = '',
                texthl = 'DiagnosticSignWarn',
                linehl = 'WarningLine',
            },
            {
                name = 'DiagnosticSignInfo',
                text = '',
                texthl = 'DiagnosticSignInfo',
                linehl = 'InfoLine',
            },
            {
                name = 'DiagnosticSignHint',
                text = '',
                texthl = 'DiagnosticSignHint',
                linehl = 'HintLine',
            },
        })
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "single",
            enable_git_status = true,
            enable_modified_markers = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            default_component_configs = {
                diagnostics = {
                    symbols = {
                        hint = '',
                        info = '',
                        warning = '',
                        error = ''
                    },
                    highlights = {
                        hint = "DiagnosticSignHint",
                        info = "DiagnosticSignInfo",
                        warn = "DiagnosticSignWarn",
                        error = "DiagnosticSignError",
                    },
                },
                indent = {
                    with_markers = false,
                    with_expanders = true,
                },
                modified = {
                    symbol = " ",
                    highlight = "NeoTreeModified",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    folder_empty_open = "",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                    },
                },
            },
            window = {
                position = "float",
                width = 35,
                mappings = {
                    ["<Tab>"] = "open",
                },
            },
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                        "__pycache__",
                        ".mypy_cache"
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_window_after_open",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
                {
                    event = "neo_tree_window_after_close",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
            },
        })
    end,
}
