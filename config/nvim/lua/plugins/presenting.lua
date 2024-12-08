return {
  "sotte/presenting.vim",
  "mzlogin/vim-markdown-toc",
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "8888"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup(
        {
          -- Buffer types to ignore
          buf_ignore = { "nofile" },
          -- Delay, in miliseconds
          -- to wait before a redraw occurs(after an event is triggered)
          debounce = 50,
          -- Filetypes where the plugin is enabled
          filetypes = { "markdown", "tex", "md" },
          -- Highlight groups to use
          -- "dynamic" | "light" | "dark"
          highlight_groups = "dynamic",
          -- Modes where hybrid mode is enabled
          hybrid_modes = nil,
          -- Tree-sitter query injections
          injections = {},
          -- Initial plugin state,
          -- true = show preview
          -- falss = don't show preview
          initial_state = true,
          -- Max file size that is rendered entirely
          max_file_length = 1000,
          -- Modes where preview is shown
          modes = { "n", "no", "c" },
          -- Lines from the cursor to draw when the
          -- file is too big
          render_distance = 100,
          -- Window configuration for split view
          -- split_conf = {},

          -- Rendering related configuration
          -- block_quotes = {},
          -- callbacks = {},
          checkboxes = {
            enable = false,
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
          list_items = {
            enable = false,
          },
          -- tables = {}
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
          insert = true,  -- when typeing "|"
          insert_leave = true, -- when leaveing insert
        },
      })
    end
  }
}
