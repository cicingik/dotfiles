vim.fn.sign_define("DapBreakpoint", { text = "🧘", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Error" })


local dapui_option = {
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = "",
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    element_mappings = {},
    expand_lines = true,
    force_buffers = true,
    render = {
        indent = 1,
        max_value_lines = 100
    },
    layouts = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                -- "console",
            },
            size = 10,
            position = "bottom",
        },
    },
}

return {
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
        config = function()
            require("nvim-dap-virtual-text").setup({
                enabled = true,

                -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
                enabled_commands = true,

                -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_changed_variables = true,
                highlight_new_as_changed = true,

                -- prefix virtual text with comment string
                commented = false,

                show_stop_reason = true,

                -- experimental features:
                virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
                all_frames = false,    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        enabled = true,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "folke/neodev.nvim",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
            -- "mfussenegger/nvim-dap-python", -- python adapter
            -- "jbyuki/one-small-step-for-vimkind", -- lua adapter
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local dap_go = require("dap-go")

            dapui.setup(dapui_option)


            local lldb = {
                name = "Launch lldb",
                command = '/opt/homebrew/Cellar/llvm/19.1.5/bin/lldb-dap', -- adjust as needed, must be absolute path
                type = "lldb-dap",                                         -- matches the adapter
                request = "launch-target",                                 -- could also attach to a currently running process
                program = function()
                    return vim.fn.input(
                        "Path to executable: ",
                        vim.fn.getcwd() .. "/",
                        "file"
                    )
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            }

            dap.adapters.lldb = lldb

            -- NOTE: GO Debug Configuration
            dap_go.setup()
        end
    }
}
