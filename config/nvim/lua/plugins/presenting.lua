return {
  "sotte/presenting.vim",
  "mzlogin/vim-markdown-toc",
  {
    "selimacerbas/mdkite.nvim",
    -- a kitehost.nvim checkout under another dir name needs its spec to
    -- say name = "kitehost.nvim", or lazy.nvim clones upstream beside it
    dependencies = { "selimacerbas/kitehost.nvim" },
    -- kitehost.nvim v2.0.0 or newer, the first release with its Host check
    config = function()
      require("mdkite").setup({
        -- all optional; sane defaults shown
        instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
        port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
        open_browser = true,
        default_theme = "dark", -- "dark" or "light"; initial preview theme
        debounce_ms = 300,
      })
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("markview").setup({
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

          splitview_winopts = { split = "left" },
        },
        markdown = {
          list_items = {
            enable = true,
            wrap = false,

            marker_minus = {
              add_padding = false,
              conceal_on_checkboxes = true,

              text = "",
              hl = "MarkviewListItemMinus",
            },

            marker_plus = {
              add_padding = false,
              conceal_on_checkboxes = true,

              text = "",
              hl = "MarkviewListItemPlus",
            },

            marker_star = {
              add_padding = false,
              conceal_on_checkboxes = true,

              text = "",
              hl = "MarkviewListItemStar",
            },

            marker_dot = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },

            marker_parenthesis = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },
          },
        },
      })
    end,
  },
  {
    "Kicamon/markdown-table-mode.nvim",
    config = function()
      require("markdown-table-mode").setup({
        filetype = {
          "*.md",
        },
        options = {
          insert = true, -- when typing "|"
          insert_leave = true, -- when leaving insert
          pad_separator_line = true, -- add space in separator line
          alig_style = "left", -- default, left, center, right
        },
      })
    end,
  },
}
