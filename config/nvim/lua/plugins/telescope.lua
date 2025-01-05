local builtin = require 'telescope.builtin'
-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = 'Search in Open Files' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Search Neovim files' })

return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'telescope-dap.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local trouble = require("trouble.sources.telescope")

      telescope.setup {
        file_ignore_patterns = { "%.git/." },
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-t>"] = trouble.open,
            },

            n = { ["<C-t>"] = trouble.open },
          },
          previewer = false,
          -- hidden = true,
          prompt_prefix = "   ",
          file_ignore_patterns = { "node_modules", "package-lock.json" },
          initial_mode = "insert",
          select_strategy = "reset",
          sorting_strategy = "ascending",
          -- layout_strategy = "horizontal",
          layout_config = {
            --   width = 0.5,
            --   height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        pickers = {
          find_files = {
            -- theme = "dropdown",
            previewer = true,
            layout_config = {
              -- width = 0.5,
              height = 0.8,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          git_files = {
            previewer = true,
            layout_config = {
              height = 0.8,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          buffers = {
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["<C-d>"] = actions.delete_buffer,
              },
            },
            previewer = false,
            initial_mode = "insert",
            theme = "dropdown",
            layout_config = {
              width = 0.5,
              height = 0.4,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          current_buffer_fuzzy_find = {
            previewer = true,
            -- theme = "dropdown",
            layout_config = {
              -- width = 0.5,
              height = 0.8,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          grep_string = {
            only_sort_text = true,
            previewer = true,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          lsp_references = {
            show_line = false,
            previewer = true,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          treesitter = {
            show_line = false,
            previewer = true,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer        = false,
              initial_mode     = "normal",
              sorting_strategy = 'ascending',
              layout_strategy  = 'horizontal',
              layout_config    = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            })
          },
          frecency = {
            default_workspace = 'CWD',
            show_scores = true,
            show_unindexed = true,
            disable_devicons = false,
            ignore_patterns = {
              "*.git/*",
              "*/tmp/*",
              "*/lua-language-server/*",
            },
          },
        }
      }
    end
  },
}
