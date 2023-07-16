---- Sign -----------------------------------

local oks, signs = pcall(require, "gitsigns")
if not oks then
  return
end

require "colorbuddy"

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group

Group.new("GitSignsAdd", c.green)
Group.new("GitSignsChange", c.yellow)
Group.new("GitSignsDelete", c.red)

signs.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsChangeNr" },
  },

  -- Highlights just the number part of the number column
  numhl = true,

  -- Highlights the _whole_ line.
  --    Instead, use gitsigns.toggle_linehl()
  linehl = false,

  -- Highlights just the part of the line that has changed
  --    Instead, use gitsigns.toggle_word_diff()
  word_diff = false,

  -- keymaps = {
  --   -- Default keymap options
  --   noremap = true,
  --   buffer = true,
  --
  --   ["n <leader>hd"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
  --   ["n <leader>hx"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
  --
  --   ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  --   ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  --   ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  -- },

  current_line_blame_opts = {
    delay = 2000,
    virt_text_pos = "eol",
  },
}

-- TODO: decide mappings for this
-- local nnoremap = vim.keymap.nnoremap
-- nnoremap { "<space>tsw", signs.toggle_word_diff }
-- nnoremap { "<space>tsh", signs.toggle_word_diff }

---- Neogit ---------------------------------

-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

local nmap = require("mapper").nmap

neogit.setup {
  integrations = {
    diffview = true,
  },
}

nmap { "<space>vv", ":DiffviewOpen " }

nmap { "<leader>gs", neogit.open }
nmap {
  "<leader>gc",
  function()
    neogit.open { "commit" }
  end,
}

-- hi NeogitNotificationInfo guifg=#80ff95
-- hi NeogitNotificationWarning guifg=#fff454
-- hi NeogitNotificationError guifg=#c44323
-- hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
-- hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
-- hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
-- hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
-- hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

-- git config --global merge.conflictStyle diff3


vim.g.lazygit_floating_window_winblend = 0         -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars =
"['╭','─', '╮', '│', '╯','─', '╰', '│']" -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0      -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1                -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0      -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = ''                -- custom config file path

---- Linker ---------------------------------

local oke, gitlinker = pcall(require, "gitlinker")
if not oke then
  return
end

-- <leader>gy yanks current line from github.
return gitlinker.setup()
