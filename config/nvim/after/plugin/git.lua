-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

local nmap = require("keymap").nmap

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


vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = "['╭','─', '╮', '│', '╯','─', '╰', '│']" -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = '' -- custom config file path
