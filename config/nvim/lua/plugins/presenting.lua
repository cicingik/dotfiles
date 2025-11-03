return {
  "sotte/presenting.vim",
  "mzlogin/vim-markdown-toc",
  {
    "iamcco/markdown-preview.nvim",
    dev = false,
    -- build = function() vim.fn["mkdp#util#install"]() end,
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
    end,
    config = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "0.0.0.0"
      vim.g.mkdp_port = "8888"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = false
      vim.g.mkdp_page_title = "${name}"
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,    -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup(
        {
          -- Highlight groups to use
          -- "dynamic" | "light" | "dark"
          highlight_groups = "dynamic",
          -- Modes where hybrid mode is enabled
          hybrid_modes = nil,
          -- Window configuration for split view
          -- split_conf = {},

          -- Rendering related configuration
          -- block_quotes = {},
          -- callbacks = {},
          checkboxes = {
            enable = true,
          },
          -- code_blocks = {},
          -- escaped = {},
          -- footnotes = {},
          -- headings = {},
          -- horizontal_rules = {},
          -- html = {},
          inline_codes = {},
          -- latex = {},
          -- links = {},
          -- tables = {}
          preview = {
            enable = true,
            filetypes = { "md", "markdown", "tex" },
            ignore_buftypes = { "nofile" },
            ignore_previews = {},

            modes = { "n", "no", "c" },
            hybrid_modes = {},
            debounce = 50,
            draw_range = { vim.o.lines, vim.o.lines },
            edit_range = { 1, 0 },

            callbacks = {},

            splitview_winopts = { split = "left" }
          },
          markdown = {
            list_items = {
              enable = true,
              wrap = false,

              marker_minus = {
                add_padding = false,
                conceal_on_checkboxes = true,

                text = "",
                hl = "MarkviewListItemMinus"
              },

              marker_plus = {
                add_padding = false,
                conceal_on_checkboxes = true,

                text = "",
                hl = "MarkviewListItemPlus"
              },

              marker_star = {
                add_padding = false,
                conceal_on_checkboxes = true,

                text = "",
                hl = "MarkviewListItemStar"
              },

              marker_dot = {
                add_padding = false,
                conceal_on_checkboxes = true,
              },

              marker_parenthesis = {
                add_padding = false,
                conceal_on_checkboxes = true,
              }
            },
          },
        }
      )
    end
  },
  {
    'Kicamon/markdown-table-mode.nvim',
    config = function()
      require('markdown-table-mode').setup({
        filetype = {
          '*.md',
        },
        options = {
          insert = true,       -- when typeing "|"
          insert_leave = true, -- when leaveing insert
        },
      })
    end
  }
}
