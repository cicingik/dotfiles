vim.fn.sign_define("DapBreakpoint", { text = "√", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Error" })

return {
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,

        -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
        enabled_commands = false,

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
      "mfussenegger/nvim-dap-python",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_go = require("dap-go")

      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      local lldb = {
        name = "Launch lldb",
        type = "lldb",      -- matches the adapter
        request = "launch", -- could also attach to a currently running process
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

      dap.configurations.rust = {
        lldb
      }

      dap.adapters.go = function(callback, _)
        local stdout = vim.loop.new_pipe(false)
        local handle, pid_or_err
        local port = 38697

        handle, pid_or_err = vim.loop.spawn("dlv", {
          stdio = { nil, stdout },
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          stdout:close()
          handle:close()

          print("[delve] Exit Code:", code)
        end)

        assert(handle, "Error running dlv: " .. tostring(pid_or_err))

        stdout:read_start(function(err, chunk)
          assert(not err, err)

          if chunk then
            vim.schedule(function()
              require("dap.repl").append(chunk)
              print("[delve]", chunk)
            end)
          end
        end)

        -- Wait for delve to start
        vim.defer_fn(function()
          callback { type = "server", host = "127.0.0.1", port = port }
        end, 100)
      end

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug (from vscode-go)",
          request = "launch",
          showLog = false,
          program = "${file}",
          dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
        },
        {
          type = "go",
          name = "Debug (No File)",
          request = "launch",
          program = "",
        },
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
          showLog = true,
          -- console = "externalTerminal",
          -- dlvToolPath = vim.fn.exepath "dlv",
        },
        {
          name = "Test Current File",
          type = "go",
          request = "launch",
          showLog = true,
          mode = "test",
          program = ".",
          dlvToolPath = vim.fn.exepath "dlv",
        },
      }

      dapui.setup({
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
          expanded = ""
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
              "console",
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      dap_go.setup()
    end
  }
}
